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
    cam: rl.Camera2D,

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
        .cam = .{
            .offset = .{.x = WinWidth * 0.5, .y = WinHeight * 0.5},
            .target = .{.x = 400, .y = 400},
            .rotation = 0,
            .zoom = 1,
        },
    };
    defer res.deinit();

    rl.SetTargetFPS(60);
    gameLoop(&res);
}

fn gameLoop(res: *Resources) void {
    //DEBUGGERY
    const ts = [_]u8 {1, 1, 1, 2};
    var fs = FloorSection.init(ts[0..], .{.x = 10, .y = 10});  //testes
    var xs = FloorSection.init(ts[0..], .{.x = 10, .y = 10});  //testes

    while (!rl.WindowShouldClose()) {
        const dT = rl.GetFrameTime();
        const speed: f32 = 80;

        if (rl.IsKeyDown(rl.KEY_A)) res.cam.target.x -= dT * speed;
        if (rl.IsKeyDown(rl.KEY_D)) res.cam.target.x += dT * speed;
        if (rl.IsKeyDown(rl.KEY_W)) res.cam.target.y -= dT * speed;
        if (rl.IsKeyDown(rl.KEY_S)) res.cam.target.y += dT * speed;

        rl.BeginDrawing();
        rl.BeginMode2D(res.cam);
        rl.ClearBackground(.{ .r = 0, .g = 0, .b = 255, .a = 255 });
        xs.draw(&res.bgmap, .{.r = 100, .g = 100, .b = 100, .a = 255}, 0.5, res.cam.target);
        fs.draw(&res.bgmap, WHITE, 1.0, res.cam.target);
        rl.EndMode2D();
        rl.DrawTextEx(res.dfont, "Eat more cheese 0", .{ .x = 100, .y = 100 }, 30, 6.0, WHITE);
        rl.DrawFPS(10, 10);
        rl.EndDrawing();
    }
}

// TODO working in pixel coordinates can run into precision issues
//       surprisingly fast.  Look at raylib 2d camera and see how it works,
//       and if it is sufficient, or if we need to track camera position on our
//       own, or some mix.

// Horizontal floor section.
const FloorSection = struct {
    // unowned series of tile indices.
    tiles: []const u8,

    // Top left corner, in tile coordinates, not pixels.
    topLeft: rl.Vector2,

    pub fn init(tiles: [] const u8, pos: rl.Vector2) FloorSection {
        return .{.tiles = tiles, .topLeft = pos };
    }

    pub fn draw(self: *FloorSection, tm: *TileMap, tint: rl.Color, scale: f32, ppos: rl.Vector2) void {
        const spec = TileMap.ImgSpec{.tint = tint};
        var i: usize = 0;
        const tl = rl.Vector2{.x = self.topLeft.x * tm.gridWidth, .y = self.topLeft.y * tm.gridHeight};
        var cpos = scaleAroundOrigin(tl, scale, ppos);

        while (i < self.tiles.len) : (i += 1) {
            tm.draw(self.tiles[i], cpos.x, cpos.y, spec);
            cpos.x += tm.gridWidth;
        }
    }
};

// Scales (x, y) as if `origin` was the origin of the coordinate system.
fn scaleAroundOrigin(pos: rl.Vector2, scale: f32,  origin: rl.Vector2) rl.Vector2 {
    const rx = pos.x - origin.x;
    const ry = pos.y - origin.y;

    return .{.x = rx * scale + origin.x, .y = ry * scale + origin.y};
}

// Texture with individual tiles of a regular grid.
const TileMap = struct {
    txt: rl.Texture,
    gridWidth: f32,
    gridHeight: f32,
    rects: []const rl.Rectangle,
    al: *mem.Allocator,

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

            rl.DrawTexturePro(self.txt, self.rects[img_index], destRect,
                              rl.Vector2{ .x = self.gridWidth * spec.center.x, .y = self.gridHeight * spec.center.y },
                              spec.rotation, spec.tint);
        }
    }

    const Error = error {
        InvalidTexture,
        BadGridDims,
    };

    pub fn init(al: *mem.Allocator, txt: rl.Texture, gridWidth: u16, gridHeight: u16) !@This() {
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
