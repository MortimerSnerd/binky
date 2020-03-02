// Simple level editing.
const std = @import("std");
const tile = @import("tile.zig");
const rl = @import("raylib.zig");

const assert = std.debug.assert;
const fmt = std.fmt;
const fs = std.fs;
const heap = std.heap;
const mem = std.mem;
const warn = std.debug.warn;

const State = struct {
    al: *mem.Allocator,

    state: StateName,

    // Unowned pointers to the level data
    // we're working on.
    tset: *tile.Set,
    layer1: *tile.Layer,

    // tile.Block and tile.Layer have unowned slices of objects,
    // mostly for things that can be shared between multiple instances, or
    // to avoid doing several small allocations.  When we're editing these, we need to create
    // and own this memory instead.  So we have buffers here we can add and
    // modify, and the Layer and Blocks just see slices into this.
    //
    // Another consequence of this is when we are finished with an edit,
    // we need to save to a file, and reload from the file so the returned
    // level data doesn't reference our backing buffers, which will go away
    // when editing ends.
    layerBlocks: []tile.Block,
    layerBlocksUsed: usize,
    blockTiles: []tile.TileIdx,
    blockTilesUsed: usize,

    create: CreatingState,

    pub fn deinit(st: *State) void {
        st.al.free(st.layerBlocks);
        st.al.free(st.blockTiles);
    }

    const StateName = enum {
        Editing,
        CreatingNew,
        // See GState definition comment, this is an initial workaround state that exists before a call to init0().
        InitialInvalid,
    };
};

const CreatingState = struct {
    // Any error message displayed at the top of the screen.
    topMsg: [:0]const u8 = "",

    // Path to png file for tileset.
    imgPath: [:0]const u8 = "",
    imgPathBuf: [fs.MAX_PATH_BYTES]u8 = [_]u8{0} ** fs.MAX_PATH_BYTES,

    // Base name used to create level and tile block
    // files.
    baseName: [:0]const u8 = "",
    baseNameBuf: [64]u8 = [_]u8{0} ** 64,

    // index of text buffer that has focus.
    focus: usize = 0,

    // Grid dimensions, assume grids are square.
    gridDim: u16 = 32,

    workDir: fs.Dir,

    // Set up our buffers.
    pub fn init(cs: *CreatingState) void {
        cs.imgPath = cs.imgPathBuf[0..0:0];
        cs.baseName = cs.baseNameBuf[0..0:0];
    }

};

// Due to https://github.com/ziglang/zig/issues/2622, I can't define a global
// State here, and initialize it undefined.  So we build out an equally invalid
// instantiation here manually, which init0 will overwrite.
var GState: State = undefInit();

fn undefInit() State {
   return State{
        .al = heap.c_allocator,
        .state = .InitialInvalid,
        .tset = @intToPtr(*tile.Set, 0x1000),
        .layer1 = @intToPtr(*tile.Layer, 0x1000),
        .layerBlocks = @intToPtr([*]tile.Block, 0x1000)[0..0],
        .layerBlocksUsed = 0,
        .blockTiles = @intToPtr([*]tile.TileIdx, 0x1000)[0..0],
        .blockTilesUsed = 0,
        .create = CreatingState{
            .workDir = fs.cwd(),
        },
    };
}


fn init0(al: *mem.Allocator, tset: *tile.Set, layer1: *tile.Layer, start: State.StateName) !void {
    GState = State{
        .al = al,
        .state = start,
        .tset = tset,
        .layer1 = layer1,
        .layerBlocks = try al.alloc(tile.Block, 300),
        .layerBlocksUsed = 0,
        .blockTiles = try al.alloc(tile.TileIdx, 500),
        .blockTilesUsed = 0,
        .create = CreatingState{
            .workDir = fs.cwd(),
        },
    };
    GState.create.init();

    if (start == .Editing) {
        // We control the memory of layers, blocks while editing.
        GState.layerBlocksUsed = try GState.layer1.useBlockDefBuffer(GState.layerBlocks);
        var tilesUsed: usize = 0;
        for (GState.layerBlocks[0..GState.layerBlocksUsed]) |*bd| {
            tilesUsed += try bd.useTileBuffer(GState.blockTiles[tilesUsed..]);
        }
        GState.blockTilesUsed = tilesUsed;
        warn("Owned buffer usage, blocks = {}, tiles = {}\n", .{GState.layerBlocksUsed, tilesUsed});
    }
}

// Must be called before calling any other
// functions.  Call deinit() when done.
pub fn init(al: *mem.Allocator, tset: *tile.Set, layer1: *tile.Layer) !void {
    return init0(al, tset, layer1, .Editing);
}

// Should be called to have the editor create a new level.
// Pointers to assets for this call should be to undefined
// structs, that the editor will initialize.  If the editor
// can not initialize the level data, handleFrame will return
// CreateCancelled, so the caller will know to throw out the level
// data without attempting to use or deinit() it.
pub fn mkNew(al: *mem.Allocator, tset: *tile.Set, layer1: *tile.Layer) !void {
    return init0(al, tset, layer1, .CreatingNew);
}

pub fn deinit() void {
    GState.deinit();

    // Part of GState workaround, see GState def for details.
    GState = undefInit();
}

pub const FrameResponse = enum {
    Running,
    Finished,

    // User didn't provide enough info to properly init level, data should be dropped by caller.
    // Whenever we return this, if the level data is only partially initialized,
    // we have to do any partial cleanup ourselves, as the caller can't just call deinit()
    // on the resources.
    CreateCancelled,
};

pub fn handleFrame(dT: f32) !FrameResponse {
    switch (GState.state) {
        .InitialInvalid => unreachable,
        .Editing => {
            if (rl.IsKeyPressed(rl.KEY_NINE)) return .Finished;
            rl.BeginDrawing();
            rl.ClearBackground(.{.r = 0, .g = 0, .b = 0, .a = 255});
            rl.EndDrawing();
            return .Running;
        },

        .CreatingNew => {
            return try handleCreatingNew(dT);
        },
    }
}

// Updates a slice from the buffer backing the slice after a C call
// may have modfied the null terminated string in the buffer.
fn updateSliceFromCStr(slice: *[] const u8, buf: []u8) void {
    const sl = mem.len(u8, @ptrCast([*:0] const u8, &buf[0]));

    slice.* = buf[0..sl];
}

fn handleCreatingNew(dT: f32)  !FrameResponse {
    const cr = &GState.create;

    if (rl.IsKeyPressed(rl.KEY_NINE)) return .CreateCancelled;

    if (cr.imgPath.len == 0) {
        const defpath = "resources/";
        mem.copy(u8, cr.imgPathBuf[0..], defpath);
        cr.imgPathBuf[defpath.len] = 0; // Must terminate, because passing to C fn.
        cr.imgPath = cr.imgPathBuf[0..defpath.len:0];
    }

    rl.BeginDrawing();
    rl.ClearBackground(.{.r = 0, .g = 255, .b = 0, .a = 255});

    // Draw the UI
    const fntSz:f32 = 16;
    const vspace:f32 = 4;
    const labwidth:f32 = fntSz * 10;
    const lmargin:f32 = 40;
    var liney: f32 = 100;
    var retHit = false;

    if (cr.topMsg.len > 0) {
        rl.DrawText(@ptrCast([*c]const u8, &cr.topMsg[0]), 50, 50, fntSz, .{.r = 255, .g = 0, .b = 0, .a = 255});
    }

    rl.GuiLabel(.{.x = lmargin, .y = liney, .width = labwidth, .height = fntSz + vspace}, "Tileset image path:");
    retHit =  rl.GuiTextBox(.{.x = lmargin + labwidth, .y = liney, .width = fntSz * 20, .height = fntSz + vspace},
       &cr.imgPathBuf,
       @intCast(c_int, cr.imgPathBuf.len),
        cr.focus % 2 == 0) or retHit;
    liney += vspace*2 + fntSz;

    rl.GuiLabel(.{.x = lmargin, .y = liney, .width = labwidth, .height = fntSz + vspace}, "Base name for new level/set:");
    retHit = rl.GuiTextBox(.{.x = lmargin + labwidth, .y = liney, .width = fntSz*20, .height = fntSz + vspace},
        &cr.baseNameBuf,
        @intCast(c_int, cr.baseNameBuf.len),
        cr.focus % 2 == 1) or retHit;
    liney += vspace*2 + fntSz;

    const ok = rl.GuiButton(.{.x = lmargin, .y = liney, .width = fntSz*5, .height = fntSz+vspace}, "OK");
    const canceled = rl.GuiButton(.{.x = lmargin + fntSz*5 + 10, .y = liney, .width = fntSz*5, .height = fntSz+vspace}, "Cancel");

    // The GuiTextBox call can modify the text in the imgPathBuf.
    updateSliceFromCStr(&cr.imgPath, cr.imgPathBuf[0..]);
    updateSliceFromCStr(&cr.baseName, cr.baseNameBuf[0..]);

    if (retHit) {
        cr.focus += 1;
    }

    // TODO: we're beating the crap out the fs doing these file checks every frame,
    // but not sure it's worth keeping up when the strings change to do
    // better.
    if (!checkValidFile(cr.imgPath)) {
        cr.topMsg = "Tileset image path doesn't point to an existing image file.";
    } else if (cr.baseName.len == 0) {
        cr.topMsg = "No basename supplied.";
    } else if (cr.baseName.len > 0) {
        var buf: [fs.MAX_PATH_BYTES]u8 = undefined;
        const bfn = try blockFileName(buf[0..], cr.baseName);

        if (fileExists(bfn)) {
            cr.topMsg = "Already a file in resources with the given base name.";
        } else {
            cr.topMsg.len = 0;
        }
    } else {
        cr.topMsg.len = 0;
    }

    if (cr.topMsg.len == 0 and ok) {
        try createLvl();
        return .Finished;
    }

    if (canceled) {
       return .CreateCancelled;
    }

    rl.EndDrawing();

    return .Running;
}

// Checks for the existance of the file at
// a path expected to be relative to the working directory
// of the program.
//TODO: is there really no way exposed in the fs.Dir/File api
// to test if something is a file or directory, or am I missing
// something?
fn checkValidFile(fname: []const u8) bool {
    const cr = &GState.create;
    var fl = cr.workDir.openFile(fname, .{.read = true}) catch return false;
    defer fl.close();

    const st = fl.stat() catch return false;
    return true;
}

// This is ugly.
fn fileExists(fname: []const u8) bool {
    var fl = GState.create.workDir.openFile(fname, .{.read = true}) catch return false;
    fl.close();
    return true;
}


fn blockFileName(buf: []u8, basename: []const u8) ![]const u8 {
    return fmt.bufPrint(buf, "resources/{}.blk", .{basename});
}

// Creates a blank level based on the information in
// GState.create.
fn createLvl() !void {
    var txt = rl.LoadTexture(GState.create.imgPath);
    const gd = GState.create.gridDim;

    GState.tset.* = try tile.Set.init(GState.al, txt, GState.create.gridDim, GState.create.gridDim);
    GState.layer1.* = tile.Layer.init(GState.layerBlocks[0..0], 1);
    GState.layerBlocksUsed = try GState.layer1.useBlockDefBuffer(GState.layerBlocks);
}

