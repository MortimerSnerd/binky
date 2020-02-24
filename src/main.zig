const std = @import("std");
const warn = std.debug.warn;
const rl = @import("raylib.zig");
const assert = std.debug.assert;

const WHITE = rl.Color{ .r = 255, .g = 255, .b = 255, .a = 255 };
const LIGHTGRAY = rl.Color{ .r = 200, .g = 200, .b = 200, .a = 255 };
const MAROON = rl.Color{ .r = 90, .g = 33, .b = 55, .a = 255 };
const BLUE = rl.Color{ .r = 0, .g = 0, .b = 255, .a = 255 };

const TxWidth = 200;
const TxHeight = 100;
var TxData: [TxWidth * TxHeight]rl.Color = undefined;

const WinWidth = 800;
const WinHeight = 400;

var Rng = std.rand.DefaultPrng.init(42);

pub fn main() void {
    rl.InitWindow(WinWidth, WinHeight, "Outta Luck");
    assert(rl.IsWindowReady());
    defer rl.CloseWindow();

    setupTx();
    var bgimg = rl.LoadImageEx(&TxData, TxWidth, TxHeight);
    defer rl.UnloadImage(bgimg);
    var bgtx = rl.LoadTextureFromImage(bgimg);
    defer rl.UnloadTexture(bgtx);
    const destRect = rl.Rectangle{ .x = 0, .y = 0, .width = WinWidth, .height = WinHeight };
    const srcRect = rl.Rectangle{ .x = 0, .y = 0, .width = TxWidth, .height = TxHeight };

    rl.SetTargetFPS(60);
    while (!rl.WindowShouldClose()) {
        updateTx(&bgtx);
        rl.BeginDrawing();
        rl.ClearBackground(WHITE);
        rl.DrawTexture(bgtx, 0, 0, WHITE);
        rl.DrawTexturePro(bgtx, srcRect, destRect, .{ .x = 0, .y = 0 }, 0, WHITE);
        rl.EndDrawing();
    }
}

inline fn txIdx(x: u32, y: u32) u32 {
    return x + y * TxWidth;
}

fn setupTx() void {
    for (TxData[0..]) |*c, i| {
        c.* = .{ .r = 0, .g = 0, .b = 255, .a = 255 };
    }

    var c: usize = 50;
    while (c > 0) : (c -= 1) {
        const x = Rng.random.uintLessThanBiased(u32, TxWidth);
        const y = Rng.random.uintLessThanBiased(u32, TxHeight);
        const i = txIdx(x, y);

        TxData[i] = .{ .r = 0, .g = 255, .b = 255, .a = 255 };
    }
}

// N, NE, E, SE, S, SW, W, NW.
const DirectionOffset = [8]i32{
    -TxWidth, -TxWidth + 1, 1, TxWidth + 1, TxWidth, TxWidth - 1, -1, -TxWidth - 1,
};

fn updateTx(tx: *rl.Texture2D) void {
    const maxI = TxWidth * TxHeight;
    var i: usize = 0;

    while (i < maxI) : (i += 1) {
        if (TxData[i].g == 255) {
            const dir = Rng.random.intRangeLessThanBiased(u8, 0, 8);
            const idx = @intCast(i32, i) + DirectionOffset[dir];

            if (idx >= 0 and idx < maxI) {
                const uidx = @intCast(usize, idx);
                if (TxData[uidx].g == 0 and TxData[uidx].r < 200) {
                    TxData[uidx] = TxData[i];
                    TxData[i] = .{ .r = 255, .g = 0, .b = 255, .a = 255 };
                }
            }
        } else if (TxData[i].r > 0) {
            TxData[i].r -= 1;
        }
    }

    rl.UpdateTexture(tx.*, &TxData);
}
