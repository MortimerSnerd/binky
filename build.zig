const Builder = @import("std").build.Builder;

pub fn build(b: *Builder) void {
    const mode = b.standardReleaseOptions();
    const exe = b.addExecutable("main", "src/main.zig");
    const args = [_][] const u8{"-Ivendor/include"};
    exe.addIncludeDir("vendor/include");
    exe.linkSystemLibrary("c");
    exe.linkSystemLibrary("raylib");
    exe.linkSystemLibrary("GL");
    exe.linkSystemLibrary("X11");

    exe.addLibPath("vendor/lib");
    exe.addCSourceFile("src/rayshims.c", args[0..]);
    exe.addCSourceFile("src/rayimpl.c", args[0..]);
    exe.setBuildMode(mode);
    exe.install();

    const run_cmd = exe.run();
    run_cmd.step.dependOn(b.getInstallStep());

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);
}
