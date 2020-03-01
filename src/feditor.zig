// Simple level editing.
const std = @import("std");
const tile = @import("tile.zig");
const rl = @import("raylib.zig");

const mem = std.mem;

const State = struct {
    al: *mem.Allocator,

    state: StateName,

    // Unowned pointers to the level data
    // we're working on.
    tset: *tile.Set,
    layer1: *tile.Layer,

    pub fn deinit(st: *State) void {
    }

    const StateName = enum {
        Editing,
        CreatingNew,
    };
};

var GState: State = undefined;

fn init0(al: *mem.Allocator, tset: *tile.Set, layer1: *tile.Layer, start: State.StateName) void {
    GState = State{
        .al = al,
        .state = start,
        .tset = tset,
        .layer1 = layer1,
    };
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
            if (rl.IsKeyPressed(rl.KEY_NINE)) return .CreateCancelled;
            rl.BeginDrawing();
            rl.ClearBackground(.{.r = 0, .g = 255, .b = 0, .a = 255});
            rl.EndDrawing();
        },
    }

    return .Running;
}
