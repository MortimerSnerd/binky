const std = @import("std");
const mem = std.mem;
const fmt = std.fmt;
const Builder = std.build.Builder;
const LibExeObjStep = std.build.LibExeObjStep;

pub fn build(b: *Builder) void {

    // Simple test program that just moves colors around on a texture.
    rayLibExe(b, "src/main.zig", "simple", "Dots doing a random walk.") catch unreachable;

    // Another executable.
    rayLibExe(b, "src/fool.zig", "fool", "Fooling around.") catch unreachable;
}

fn rayLibExe(b: *Builder, root_src: []const u8, suffix: []const u8, desc: []const u8) !void {
    var run_name_buffer: [64]u8 = undefined;
    const run_name = try fmt.bufPrint(run_name_buffer[0..], "run_{}", .{suffix});
    const mode = b.standardReleaseOptions();
    const exe = b.addExecutable("main", root_src);

    exe.setBuildMode(mode);
    linkLinuxLibs(exe);
    addRaylibFiles(exe);
    exe.install();

    const run_cmd = exe.run();
    run_cmd.step.dependOn(b.getInstallStep());

    const cmd_name = try mem.dupe(b.allocator, u8, run_name);
    const cmd_desc = try mem.dupe(b.allocator, u8, desc);
    const run_step = b.step(cmd_name, cmd_desc);

    run_step.dependOn(&run_cmd.step);
}

fn linkLinuxLibs(exe: *LibExeObjStep) void {
    exe.linkSystemLibrary("GL");
    exe.linkSystemLibrary("X11");
}

fn addRaylibFiles(exe: *LibExeObjStep) void {
    const args = [_][]const u8{"-Ivendor/include"};

    exe.addIncludeDir("vendor/include");
    exe.linkSystemLibrary("c");
    exe.linkSystemLibrary("raylib");
    exe.addLibPath("vendor/lib");
    exe.addCSourceFile("src/rayshims.c", args[0..]);
    exe.addCSourceFile("src/rayimpl.c", args[0..]);
}
