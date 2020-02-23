// Generates shims to work around some ABI problems
// with passing some structs by value.  This is geared
// for x86_64, and doesn't consider the separate issues
// for ARM, etc...
const std = @import("std");
const zig = std.zig;
const ast = std.zig.ast;
const assert = std.debug.assert;
const warn = std.debug.warn;
const fs = std.fs;
const mem = std.mem;
const ArrayList = std.ArrayList;

// Rather than being fancy, and inspecting struct types to see if we
// can pass them, just listing the types that we can't pass as a parameter.
// Not a hardship, as raylib doesn't have a lot of types.
const BadTypes =  [_][]const u8 {
  // Struct passed by value <= 16 bytes.
  "Vector2", "Vector3", "Vector4", "Rectangle"
};

pub fn main() !void {
    const inf = try fs.cwd().openFile("gen-raylib.zig", .{ .read = true });
    const st = try inf.stat();
    const buf = try std.heap.c_allocator.alloc(u8, st.size);

    var zigOut = try fs.cwd().createFile("raylib.zig", .{ .read = false});
    var zigStr = zigOut.outStream();

    var cOut = try fs.cwd().createFile("rayshims.c", .{ .read = false });
    var cStr = cOut.outStream();

    try cOut.write("#include \"raylib.h\"\n#include \"physac.h\"\n");
    try cOut.write("#define RAYGUIDEF\n#include \"raygui.h\"\n\n");

    defer std.heap.c_allocator.free(buf);

    var numRead: usize = 0;
    while (numRead < st.size) {
        const rv = try inf.read(buf[numRead..]);
        numRead += rv;
    }

    const tree = try zig.parse(std.heap.c_allocator, buf[0..]);

    var i: usize = 0;
    while (tree.root_node.iterate(i)) |n| : (i += 1) {
        if (n.cast(ast.Node.FnProto)) |prot| {
            if (prot.body_node == null) {
                // Prototypes only.
                if (fnHasAbiProblem(tree, buf, prot)) {
                    var pinfo = try allocParamInfo(std.heap.c_allocator, tree, buf, prot);
                    defer freeParamInfo(std.heap.c_allocator, &pinfo);
                    try writeZigShim(&zigStr.stream, std.heap.c_allocator, tree, buf, prot, &pinfo);
                    try writeCShim(&cStr.stream, std.heap.c_allocator, tree, buf, prot, &pinfo);
                } else {
                    try zigOut.write(tree.getNodeSource(n));
                    try zigOut.write(";\n");
                }
            } else {
              try zigOut.write(tree.getNodeSource(n));
              try zigOut.write("\n");
            }
        } else {
            try zigOut.write(tree.getNodeSource(n));
            try zigOut.write("\n");
        }
    }
}

// All fields except ctype are unowned slices
const ParamInfo = struct {
  name: []const u8,
  ctype: []const u8,
  ztype: []const u8,
  hasProblemType: bool,
};

fn freeParamInfo(alloc: *mem.Allocator, pi: *ArrayList(*ParamInfo)) void {
  for (pi.toSlice()) |p| {
     alloc.free(p.ctype);
     alloc.destroy(p);
  }
  pi.deinit();
}

// Break out parameter info so we don't have to do
// the tedious iteration of the FnProto params and
// type translations several times.
fn allocParamInfo(
     alloc: *mem.Allocator,
     tree: *ast.Tree,
     source: []const u8,
     fun: *ast.Node.FnProto) !ArrayList(*ParamInfo)
{
  var pi = fun.params.iterator(0);
  var rv = ArrayList(*ParamInfo).init(alloc);

  while (pi.next()) |parm| {
      if (parm.*.cast(ast.Node.ParamDecl)) |pd| {
        const name_sl = if (pd.name_token) |nt| tree.tokenSlice(nt) else "";
        const sparam = try alloc.create(ParamInfo);

        if (pd.var_args_token) |va| {
            sparam.name = name_sl;
            sparam.ctype = try mem.dupe(alloc, u8, "...");
            sparam.ztype = "...";
            sparam.hasProblemType = false;
        } else {
            const ztype = tree.getNodeSource(pd.type_node);
            const tname = try toCType(ztype, alloc);

            sparam.name = name_sl;
            sparam.ctype = tname;
            sparam.ztype = ztype;
            sparam.hasProblemType = typeHasAbiProblem(tree, source, pd.type_node);
        }
        try rv.append(sparam);
      } else {
          unreachable;
      }
  }
  return rv;
}

fn writeCShim(out: *std.io.OutStream(fs.File.WriteError),
    alloc: *mem.Allocator,
    tree: *ast.Tree,
    source: []const u8,
    fun: *ast.Node.FnProto,
    params: *ArrayList(*ParamInfo)) !void {

  const rt_sl = try toCType(switch (fun.return_type) {
    .Explicit => |x| tree.getNodeSource(x),
    .InferErrorSet => |x| tree.getNodeSource(x),
  }, alloc);
  defer alloc.free(rt_sl);

  const name_sl = if (fun.name_token) |nt| tree.tokenSlice(nt) else "";

  try out.print("{} {}Shim(", .{rt_sl, name_sl});

  var firstParam = true;

  for (params.toSlice()) |pd| {
    if (firstParam) {
        firstParam = false;
    } else {
        try out.write(", ");
    }
    if (mem.eql(u8, pd.ctype, "...")) {
        try out.write("...");
    } else {
        try out.write(pd.ctype);
        if (pd.hasProblemType) {
          try out.write(" const*");
        }
        try out.write(" ");
        try out.write(pd.name);
    }
  }

  try out.write(")\n");
  try out.write("{\n");

  const mayberet = if (!mem.eql(u8, rt_sl, "void")) "return " else "";

  try out.print("    {}{}(", .{mayberet, name_sl});
  firstParam = true;

  for (params.toSlice()) |pd| {
      if (firstParam) {
          firstParam = false;
      } else {
          try out.write(", ");
      }

      if (mem.eql(u8, pd.ctype, "...")) {
          try out.write("...");
      } else {
          if (pd.hasProblemType) {
            try out.write("*");
          }
          try out.write(pd.name);
      }
  }
  try out.write(");\n}\n");
}

// Takes one of the c_ types and converts it to a type we can use in
// the C shim code. Always allocates a copy, though technically it's
// not needed for all cases.
fn toCType(ztype: []const u8, alloc: *mem.Allocator) mem.Allocator.Error![]const u8 {
  if (mem.eql(u8, ztype, "u8")) {
    return mem.dupe(alloc, u8, "char");
  } else if (mem.eql(u8, ztype, "f32")) {
    return mem.dupe(alloc, u8, "float");
  } else if (mem.eql(u8, ztype, "f64")) {
    return mem.dupe(alloc, u8, "double");
  } else if (ztype.len > 2 and ztype[0] == 'c' and ztype[1] == '_') {
    return mem.dupe(alloc, u8, ztype[2..]);
  } else if (ztype.len > 4 and mem.eql(u8, ztype[0..4], "[*c]")) {
    const inner = try toCType(ztype[4..], alloc);
    defer alloc.free(inner);
    const rv = try alloc.alloc(u8, inner.len + 1);
    mem.copy(u8, rv, inner);
    rv[rv.len-1] = '*';
    return rv;
  } else if (ztype.len > 6 and mem.eql(u8, ztype[0..6], "const ")) {
    const inner = try toCType(ztype[6..], alloc);
    defer alloc.free(inner);
    const rv = try alloc.alloc(u8, inner.len + 6);
    mem.copy(u8, rv, "const ");
    mem.copy(u8, rv[6..], inner);
    return rv;
  } else {
    return mem.dupe(alloc, u8, ztype);
  }
}

// Write out the zig declaration, and the internal shim declaration.
fn writeZigShim(
   out: *std.io.OutStream(fs.File.WriteError),
   alloc: *mem.Allocator,
   tree: *ast.Tree,
   source: []const u8,
   fun: *ast.Node.FnProto,
   params: *ArrayList(*ParamInfo)) !void
{
    assert(fun.name_token != null);
    assert(fun.body_node == null);

    // First, write out the declaration for the C shim we will generate.
    const vis_sl = if (fun.visib_token) |ti| tree.tokenSlice(ti) else "";
    const exp_sl = if (fun.extern_export_inline_token) |ti| tree.tokenSlice(ti) else "";
    const name_sl = if (fun.name_token) |ti| tree.tokenSlice(ti) else "";

    try out.print("{} {} fn {}Shim(", .{vis_sl, exp_sl, name_sl});

    var firstParam = true;
    for (params.toSlice()) |pd| {
        if (firstParam) {
            firstParam = false;
        } else {
            try out.write(", ");
        }

        if (mem.eql(u8, pd.ztype,  "...")) {
            try out.write(pd.ztype);
        } else {
            try out.write(pd.name);
            try out.write(": ");

            if (pd.hasProblemType) {
              try out.write("* const "); // Presto chango, it's a pointer.
            }
            try out.write(pd.ztype);
        }
    }

    const cc_sl = if (fun.callconv_expr) |nd| tree.getNodeSource(nd) else "";
    const rt_sl = switch (fun.return_type) {
      .Explicit => |x| tree.getNodeSource(x),
      .InferErrorSet => |x| tree.getNodeSource(x),
    };
    try out.print(") {} {};\n", .{cc_sl, rt_sl});

    // Now, write the zig shim that takes the original
    // parameters, and calls the C side shim in a way that avoids
    // the temporary ABI limitations.
    const decl_sl = mem.trimRight(u8, tree.getNodeSource(&fun.base), " ;");
    const maybe_ret = if (mem.eql(u8, rt_sl, "void")) "" else "return ";
    const mod_decl = try alloc.alloc(u8, decl_sl.len);
    defer alloc.free(mod_decl);

    mem.copy(u8, mod_decl, decl_sl);
    eraseExtern(mod_decl);
    try out.write(mod_decl);
    try out.write(" {\n");
    try out.print("   {} {}Shim(", .{maybe_ret, name_sl});

    firstParam = true;
    for (params.toSlice()) |pd| {
      if (firstParam) {
          firstParam = false;
      } else {
          try out.write(", ");
      }

      if (pd.hasProblemType) {
        try out.write("&");
      }
      try out.write(pd.name);
    }

    try out.write(");\n}\n");
}

fn eraseExtern(s: []u8) void {
  const needle = " extern ";
  if (mem.indexOf(u8, s, needle)) |idx| {
    for (s[idx..idx+needle.len]) |*c| {
      c.* = ' ';
    }
  }
}


fn fnHasAbiProblem(tree: *ast.Tree, source: []const u8, fun: *ast.Node.FnProto) bool {
    var pi = fun.params.iterator(0);
    while (pi.next()) |parm| {
        if (parm.*.cast(ast.Node.ParamDecl)) |pd| {
            if (pd.var_args_token != null) {
                // If this is set, then atm type_node is undefined, and we don't
                // want to acccess that.
                continue;
            }
            if (typeHasAbiProblem(tree, source, pd.type_node)) {
                return true;
            }
        }
    }
    //TODO need to check return type too?
    return false;
}

fn typeHasAbiProblem(tree: *ast.Tree, source: []const u8, pd: *ast.Node) bool {
    if (pd.cast(ast.Node.Identifier)) |id| {
        const name = tree.tokenSlice(id.token);
        for (BadTypes) |t| {
          if (std.mem.eql(u8, name, t)) return true;
        }
        return false;
    } else {
        return false;
    }
}
