const std = @import("std");
const mem = std.mem;
const heap = std.heap;
const rl = @import("raylib.zig");
const warn = std.debug.warn;
const assert = std.debug.assert;

const WinWidth = 800;
const WinHeight = 600;
const WHITE = rl.Color{ .r = 255, .g = 255, .b = 255, .a = 255 };

const Resources = struct {
    dfont: rl.Font,
    bgmap: TileMap,

    pub fn deinit(self: *Resources) void {
        rl.UnloadFont(self.dfont);
        self.bgmap.deinit();
    }
};

pub fn main() !void {
    rl.InitWindow(WinWidth, WinHeight, "Outta Luck");
    assert(rl.IsWindowReady());
    defer rl.CloseWindow();

    var res = Resources{
        .dfont = rl.LoadFont("fonty.ttf"),
        .bgmap = try TileMap.init(heap.c_allocator, rl.LoadTexture("resources/platformertiles.png"), 32, 32),
    };
    defer res.deinit();

    rl.SetTargetFPS(60);
    gameLoop(&res);
}

fn gameLoop(res: *Resources) void {
    while (!rl.WindowShouldClose()) {
        rl.BeginDrawing();
        rl.ClearBackground(.{ .r = 0, .g = 0, .b = 255, .a = 255 });
        var idx: usize = 0;
        while (idx < 10) : (idx += 1) {
            res.bgmap.draw(idx, @intToFloat(f32, idx) * 32 * 3, 200, .{ .scale = 3 });
        }
        rl.DrawTextEx(res.dfont, "Eat more cheese 0", .{ .x = 100, .y = 100 }, 30, 6.0, WHITE);
        rl.DrawFPS(10, 10);
        rl.EndDrawing();
    }
}

// Texture with individual tiles of a regular grid.
const TileMap = struct {
    txt: rl.Texture,
    gridWidth: f32,
    gridHeight: f32,
    rects: []const rl.Rectangle,
    al: *mem.Allocator,

    const Error = mem.Allocator.Error || error{
        InvalidTexture,
        BadGridDims,
    };

    const ImgSpec = struct {
        rotation: f32 = 0,
        scale: f32 = 1,
        center: rl.Vector2 = rl.Vector2{ .x = 0.5, .y = 0.5 },
        tint: rl.Color = WHITE,
    };

    // Draw image #`img_index` in the tilemap with `(x, y)` as the top
    // left corner of the image.
    pub fn draw(self: *TileMap, img_index: usize, x: f32, y: f32, spec: ImgSpec) void {
        if (img_index < self.rects.len) {
            var destRect = rl.Rectangle{
                .x = x,
                .y = y,
                .width = self.gridWidth * spec.scale,
                .height = self.gridHeight * spec.scale,
            };
            rl.DrawTexturePro(self.txt, self.rects[img_index], destRect, rl.Vector2{ .x = self.gridWidth * spec.center.x, .y = self.gridHeight * spec.center.y }, spec.rotation, spec.tint);
        }
    }

    pub fn init(al: *mem.Allocator, txt: rl.Texture, gridWidth: u16, gridHeight: u16) Error!@This() {
        if (gridWidth == 0 or gridHeight == 0) return Error.BadGridDims;
        if (txt.width <= 0 or txt.height <= 0) return Error.InvalidTexture;

        const twid = @intCast(u16, txt.width);
        const tht = @intCast(u16, txt.height);

        if (twid % gridWidth != 0 or tht % gridHeight != 0) return Error.BadGridDims;

        const nx = twid / gridWidth;
        const ny = tht / gridHeight;
        var rects = try al.alloc(rl.Rectangle, nx * ny);

        var x: u16 = 0;
        var y: u16 = 0;
        var idx: usize = 0;

        while (y < ny) : (y += 1) {
            while (x < nx) : (x += 1) {
                rects[idx] = rl.Rectangle{
                    .x = @intToFloat(f32, x * gridWidth),
                    .y = @intToFloat(f32, y * gridHeight),
                    .width = @intToFloat(f32, gridWidth),
                    .height = @intToFloat(f32, gridHeight),
                };
                idx += 1;
            }
        }

        return TileMap{
            .txt = txt,
            .gridWidth = @intToFloat(f32, gridWidth),
            .gridHeight = @intToFloat(f32, gridHeight),
            .rects = rects,
            .al = al,
        };
    }

    pub fn deinit(tm: *TileMap) void {
        tm.al.free(tm.rects);
    }
};
