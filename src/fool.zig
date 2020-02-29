const std = @import("std");
const mem = std.mem;
const heap = std.heap;
const rl = @import("raylib.zig");
const warn = std.debug.warn;
const panic = std.debug.panic;
const assert = std.debug.assert;
const maxInt = std.math.maxInt;

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
    const ts = [_]u8 {0, 2, 16, 18};
    var tb = TileBlock.init(ts[0..], 2, 2) catch unreachable;

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
        tb.draw(&res.bgmap, .{.x = 100, .y = 100}, .{.scaleOrigin = res.cam.target, .scale = 0.5});
        tb.draw(&res.bgmap, .{.x = 100, .y = 100}, .{.scaleOrigin = res.cam.target});
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
const TileIdx = u8;
const TileBlock = struct {
    // Unowned slice of tile indexes.
    tiles: []const TileIdx,

    // Width of the block of tiles.
    width: u16,

    pub fn init(tiles: []const TileIdx, width: usize, height: usize) !TileBlock {
        if (tiles.len > maxInt(u16) or width > maxInt(u16) or height > maxInt(u16)) return error.Overflow;
        if (width == 0 or height == 0) return error.Underflow;

        const tot = width * height;

        if (tot > maxInt(u16)) return error.Overflow;
        if (tot != tiles.len) return error.BadDimensions;

        return TileBlock{
            .tiles = tiles,
            .width = @intCast(u16, width),
        };
    }

    const DrawSpec = struct {
        tint: rl.Color = WHITE,
        scale: f32 = 1,
        scaleOrigin: rl.Vector2 = .{.x = 0, .y = 0},
    };

    pub fn draw(self: *TileBlock, tm: *TileMap, topLeft: rl.Vector2, spec: DrawSpec) void {
        const sctl = scaleAroundOrigin(topLeft, spec.scale, spec.scaleOrigin);
        const tmspec = TileMap.ImgSpec{.tint = spec.tint};
        var iter = self.iterator(sctl);
        var pos: rl.Vector2 = undefined;

        while (iter.next(tm, &pos)) |img| {
            tm.draw(img, pos.x, pos.y, tmspec);
        }
    }

    const TileIterator = struct {
        pos: rl.Vector2,
        topLeft: rl.Vector2,
        col: u16,
        idx: usize,
        blk: *TileBlock,

        pub fn next(self: *TileIterator, tm: *TileMap, pos: *rl.Vector2) ?TileIdx {
            if (self.idx < self.blk.tiles.len) {
               pos.* = self.pos;
               const rv = self.blk.tiles[self.idx];

                self.idx += 1;
                self.col += 1;
                if (self.col == self.blk.width) {
                    self.col = 0;
                    self.pos.x = self.topLeft.x;
                    self.pos.y += tm.gridHeight;
                } else {
                    self.pos.x += tm.gridWidth;
                }

                return rv;
            } else {
                return null;
            }
        }
    };

    pub fn iterator(self: *TileBlock, topLeft: rl.Vector2) TileIterator {
        return TileIterator{
            .pos = topLeft,
            .topLeft = topLeft,
            .col = 0,
            .idx = 0,
            .blk = self,
        };
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
        } else {
            panic("Index {} out of range: 0..{}", .{img_index, self.rects.len-1});
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

        var y: u16 = 0;
        var idx: usize = 0;

        while (y < ny) : (y += 1) {
            var x: u16 = 0;
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
