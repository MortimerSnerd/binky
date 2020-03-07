const std = @import("std");
const rl = @import("raylib.zig");
const tile = @import("tile.zig");
const rsrc = @import("foolres.zig");
const editor = @import("feditor.zig");

const mem = std.mem;
const fs = std.fs;
const heap = std.heap;
const warn = std.debug.warn;
const panic = std.debug.panic;
const assert = std.debug.assert;
const maxInt = std.math.maxInt;

const WinWidth = 800;
const WinHeight = 600;

//TODO fix binding genration so we can use rl.WHITE.
const WHITE = rl.Color{ .r = 255, .g = 255, .b = 255, .a = 255 };

const Resources = struct {
    dfont: rl.Font,
    bgmap: tile.Set,

    pub fn deinit(self: *Resources) void {
        rl.UnloadFont(self.dfont);
        self.bgmap.deinit();
    }
};

const GameState = struct {
    al: *mem.Allocator,
    level: ?tile.Level,
    res: Resources,
    cam: rl.Camera2D,
};

pub fn main() !void {
    rl.InitWindow(WinWidth, WinHeight, "Outta Luck");
    assert(rl.IsWindowReady());
    defer rl.CloseWindow();

    var gs = GameState {
        .al = heap.c_allocator,
        .level = null,
        .cam = .{
            .offset = .{ .x = WinWidth * 0.5, .y = WinHeight * 0.5 },
            .target = .{ .x = 100, .y = 100 },
            .rotation = 0,
            .zoom = 1,
        },
        .res = Resources{
            .dfont = rl.LoadFont("fonty.ttf"),
            .bgmap = try tile.Set.init(heap.c_allocator, rl.LoadTexture("resources/platformertiles.png"), 32, 32),
        },
    };
    defer gs.res.deinit();

    // Free up Escape key so we can use it for bindings.
    rl.SetExitKey(0);
    rl.SetTargetFPS(60);

    try gameLoop(&gs);
}

const LoopState = enum {
    Running,
    Editing,
};

fn gameLoop(gs: *GameState) !void {
    //DEBUGGERY
    var curstate: LoopState = .Running;

    defer switchState(&curstate, .Running, gs);

    //rl.GuiFont(gs.res.dfont);

    while (!rl.WindowShouldClose() and !controlPressed(rl.KEY_X)) {
        const dT = rl.GetFrameTime();

        switch (curstate) {
            .Running => {
                onePass(gs, dT);
                if (controlPressed(rl.KEY_N)) switchState(&curstate, .Editing, gs);
            },
            .Editing => _ = switch (try editor.handleFrame(dT)) {
                .Finished => switchState(&curstate, .Running, gs),
                .Running => {},
                .CreateCancelled => {
                    // Throw out level data, it's not valid.
                    gs.level = null;
                    switchState(&curstate, .Running, gs);
                },
            },
        }
    }
}

fn controlPressed(key: c_int) bool {
    return rl.IsKeyDown(rl.KEY_LEFT_CONTROL) and rl.IsKeyPressed(key);
}

fn switchState(cur: *LoopState, new: LoopState, gs: *GameState) void {
    switch (cur.*) {
        .Running => {
            switch (new) {
                .Running => {},
                .Editing => {
                    if (gs.level) |*lv| {
                        editor.init(gs.al, lv);
                    } else {
                        // Slightly hinky, but we set up an undefined
                        // level for the editor to deal with.  It will return
                        // an indication to us if the level hasn't been
                        // initialized, so we can re-null it for that case.
                        // TODO: this is ugly.  But it's a end result of needing
                        //   some verified information that the editor prompts for.
                        gs.level = tile.Level.undefLevel();
                        if (gs.level) |*lv| {
                            editor.mkNew(gs.al, lv);
                        }
                    }
                },
            }
        },

        .Editing => switch (new) {
            .Running => editor.deinit(),
            .Editing => {},
        },
    }

    if (cur.* != new) {
        // Clear out any pressed keys in the queue - we don't want presses to carry over
        // from switching states.
        while (rl.GetKeyPressed() > 0) {}
    }

    cur.* = new;
}


fn onePass(gs: *GameState, dT: f32) void {
    const speed: f32 = 80;

    if (rl.IsKeyDown(rl.KEY_A)) gs.cam.target.x -= dT * speed;
    if (rl.IsKeyDown(rl.KEY_D)) gs.cam.target.x += dT * speed;
    if (rl.IsKeyDown(rl.KEY_W)) gs.cam.target.y -= dT * speed;
    if (rl.IsKeyDown(rl.KEY_S)) gs.cam.target.y += dT * speed;

    rl.BeginDrawing();
    rl.BeginMode2D(gs.cam);
    rl.ClearBackground(.{ .r = 0, .g = 0, .b = 255, .a = 255 });
    if (gs.level) |*lv| {
        for (lv.layers) |*lay| {
            lay.draw(&lv.tset, gs.cam.target);
        }
    }
    rl.EndMode2D();
    rl.DrawTextEx(gs.res.dfont, "Eat more cheese 0", .{ .x = 100, .y = 100 }, 30, 6.0, WHITE);

    if (!rl.GuiWindowBox(.{.x = 200, .y = 200, .width = 320, .height = 200}, "Nerd")) {
        const rv = rl.GuiSlider(.{.x = 290, .y = 300, .width = 100, .height = 50}, "Bork", 10, 0, 50, true);
    }

    rl.DrawFPS(10, 10);
    rl.EndDrawing();
}
