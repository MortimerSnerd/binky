// Simple level editing.
const std = @import("std");
const tile = @import("tile.zig");
const rl = @import("raylib.zig");

const assert = std.debug.assert;
const fmt = std.fmt;
const fs = std.fs;
const mem = std.mem;
const warn = std.debug.warn;

const State = struct {
    al: *mem.Allocator,

    state: StateName,

    // Unowned pointers to the level data
    // we're working on.
    tset: *tile.Set,
    layer1: *tile.Layer,

    create: CreatingState,

    pub fn deinit(st: *State) void {
    }

    const StateName = enum {
        Editing,
        CreatingNew,
    };
};

const CreatingState = struct {
    // Any error message displayed at the top of the screen.
    topMsg: [:0]const u8 = "",
    topMsgBuf: [256]u8 = [_]u8{0} ** 256,

    // Path to png file for tileset.
    imgPath: []const u8 = "",
    imgPathBuf: [fs.MAX_PATH_BYTES]u8 = [_]u8{0} ** fs.MAX_PATH_BYTES,

    // Base name used to create level and tile block
    // files.
    baseName: []const u8 = "",
    baseNameBuf: [64]u8 = [_]u8{0} ** 64,

    workDir: fs.Dir,

    // Set up our buffers.
    pub fn init(cs: *CreatingState) void {
        cs.topMsg = cs.topMsgBuf[0..0:0];
        cs.imgPath = cs.imgPathBuf[0..0];
        cs.baseName = cs.baseNameBuf[0..0];
    }
};

var GState: State = undefined;

fn init0(al: *mem.Allocator, tset: *tile.Set, layer1: *tile.Layer, start: State.StateName) void {
    GState = State{
        .al = al,
        .state = start,
        .tset = tset,
        .layer1 = layer1,
        .create = CreatingState{
            .workDir = fs.cwd(),
        },
    };
    GState.create.init();
}

// Must be called before calling any other
// functions.  Call deinit() when done.
pub fn init(al: *mem.Allocator, tset: *tile.Set, layer1: *tile.Layer) void {
    return init0(al, tset, layer1, .Editing);
}

// Should be called to have the editor create a new level.
// Pointers to assets for this call should be to undefined
// structs, that the editor will initialize.  If the editor
// can not initialize the level data, handleFrame will return
// CreateCancelled, so the caller will know to throw out the level
// data without attempting to use or deinit() it.
pub fn mkNew(al: *mem.Allocator, tset: *tile.Set, layer1: *tile.Layer) void {
    return init0(al, tset, layer1, .CreatingNew);
}

pub fn deinit() void {
    GState.deinit();
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

pub fn handleFrame(dT: f32) FrameResponse {
    switch (GState.state) {
        .Editing => {
            if (rl.IsKeyPressed(rl.KEY_NINE)) return .Finished;
            rl.BeginDrawing();
            rl.ClearBackground(.{.r = 0, .g = 0, .b = 0, .a = 255});
            rl.EndDrawing();
        },

        .CreatingNew => {
            return handleCreatingNew(dT);
        },
    }

    return .Running;
}

// Updates a slice from the buffer backing the slice after a C call
// may have modfied the null terminated string in the buffer.
fn updateSliceFromCStr(slice: *[] const u8, buf: []u8) void {
    const sl = mem.len(u8, @ptrCast([*:0] const u8, &buf[0]));

    slice.* = buf[0..sl];
}

fn handleCreatingNew(dT: f32)  FrameResponse {
    const cr = &GState.create;

    if (rl.IsKeyPressed(rl.KEY_NINE)) return .CreateCancelled;

    if (cr.imgPath.len == 0) {
        const defpath = "resources/";
        mem.copy(u8, cr.imgPathBuf[0..], defpath);
        cr.imgPathBuf[defpath.len] = 0; // Must terminate, because passing to C fn.
        cr.imgPath = cr.imgPathBuf[0..defpath.len];
    }

    rl.BeginDrawing();
    rl.ClearBackground(.{.r = 0, .g = 255, .b = 0, .a = 255});

    if (cr.topMsg.len > 0) {
        rl.DrawText(@ptrCast([*c]const u8, &cr.topMsg[0]), 50, 400, 14, .{.r = 255, .g = 0, .b = 0, .a = 255});
    }

    const hitReturn = rl.GuiTextBox(.{.x = 100, .y = 100, .width = 200, .height = 80},
       &cr.imgPathBuf,
       @intCast(c_int, cr.imgPathBuf.len),
        true);
    updateSliceFromCStr(&cr.imgPath, cr.imgPathBuf[0..]);

    if (!checkValidFile(cr.imgPath)) {
        const msg = "Tileset image path doesn't point to an existing image file.";
        assert(msg.len < cr.topMsgBuf.len);
        mem.copy(u8, cr.topMsgBuf[0..], msg);
        cr.topMsgBuf[msg.len] = 0;
        cr.topMsg = cr.topMsgBuf[0..msg.len:0];
    } else {
        cr.topMsg.len = 0;
    }

    rl.EndDrawing();

    return .Running;
}

// Checks for the existance of the file at
// a path expected to be relative to the working directory
// of the program.
fn checkValidFile(fname: []const u8) bool {
    const cr = &GState.create;
    var fl = cr.workDir.openFile(fname, .{.read = true}) catch return false;
    defer fl.close();

    const st = fl.stat() catch return false;
    return true;
}
