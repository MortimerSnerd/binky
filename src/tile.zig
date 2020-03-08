const std = @import("std");
const chunk = @import("chunk.zig");

const fs = std.fs;
const heap = std.heap;
const mem = std.mem;
const rl = @import("raylib.zig");
const warn = std.debug.warn;
const panic = std.debug.panic;
const maxInt = std.math.maxInt;

pub const Layer = struct {
    // Unowned slice of tile blocks.  The blockDefs are likely shared
    // between multiple layers, so an externally managed array will
    // have all of the blocks, and this will be a slice into that array.
    blockDefs: []const Block,

    // Owned slice of block instances.  No reason for these
    // to be shared between multiple layers, so we own this
    // allocation.
    blocks: []const BlockInst,

    // 1.0 for layer player is on, <1 for layers behind.  Must be > 0.
    depthScale: f32,

    const BlockInst = struct {
        block: u16, // Index into blockDefs
        pos: rl.Vector2,
    };

    pub fn draw(self: *Layer, tm: *Set, playerPos: rl.Vector2) void {
        const ds = Block.DrawSpec{.scaleOrigin = playerPos};
        for (self.blocks) |blk| {
            self.blockDefs[blk.block].draw(tm, blk.pos, ds);
        }
    }

    pub fn init(blockDefs: []const Block, depthScale: f32) Layer {
        return Layer{
            .blockDefs = blockDefs,
            .blocks = &[0]BlockInst{},
            .depthScale = depthScale,
        };
    }

    pub fn deinit(self: *Layer) void {
        // eventually free blockinst data we read from a file or something
    }
};

pub const TileIdx = u8;
pub const EmptyTile: TileIdx = maxInt(TileIdx);

pub const Block = struct {
    // Unowned slice of tile indexes.  Rather than having
    // a separate allocation for each block, instead there
    // will one array of TileIdx built up during loading, and
    // blocks will have slices into it.
    tiles: []const TileIdx,

    // Width of the block of tiles.
    width: u16,

    pub fn init(tiles: []const TileIdx, width: usize, height: usize) !Block {
        if (tiles.len > maxInt(u16) or width > maxInt(u16) or height > maxInt(u16)) return error.Overflow;
        if (width == 0 or height == 0) return error.Underflow;

        const tot = width * height;

        if (tot > maxInt(u16)) return error.Overflow;
        if (tot != tiles.len) return error.BadDimensions;

        return Block{
            .tiles = tiles,
            .width = @intCast(u16, width),
        };
    }

    pub const DrawSpec = struct {
        tint: rl.Color = rl.WHITE,
        scale: f32 = 1,
        scaleOrigin: rl.Vector2 = .{ .x = 0, .y = 0 },
    };

    pub fn draw(self: *const Block, tm: *Set, topLeft: rl.Vector2, spec: DrawSpec) void {
        const sctl = scaleAroundOrigin(topLeft, spec.scale, spec.scaleOrigin);
        const tmspec = Set.ImgSpec{ .tint = spec.tint };
        var iter = self.iterator(sctl);
        var pos: rl.Vector2 = undefined;

        while (iter.next(tm, &pos)) |img| {
            if (img == EmptyTile) continue;
            tm.draw(img, pos.x, pos.y, tmspec);
        }
    }

    // Starting at `seekPos`, tries to interpret the bytes as a
    // Block.  Returns null on EOF.  The returned Block
    // references the bytes in `bytes`, so `bytes` has to live as
    // long as the returned Block.
    pub fn deserialize(bytes: []const u8, seekPos: *usize) !?Block {
        if (bytes.len == 0) return null;
        const last = bytes.len;

        if (seekPos.* >= last) return null;
        if (seekPos.*+2 > last) return error.BadFormat;

        const width = @intCast(usize, bytes[seekPos.*]);
        const height = @intCast(usize, bytes[seekPos.*+1]);
        const lastbody = seekPos.* + 2 + width * height;

        if (width == 0 or height == 0) return error.BadFormat;

        seekPos.* += 2;
        const firstbody = seekPos.*;
        if (lastbody > last) return error.BadFormat;
        seekPos.* = lastbody;

        return try Block.init(bytes[firstbody..lastbody], width, height);
    }

    const TileIterator = struct {
        pos: rl.Vector2,
        topLeft: rl.Vector2,
        col: u16,
        idx: usize,
        blk: *const Block,

        pub fn next(self: *TileIterator, tm: *Set, pos: *rl.Vector2) ?TileIdx {
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

    pub fn iterator(self: *const Block, topLeft: rl.Vector2) TileIterator {
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
pub fn scaleAroundOrigin(pos: rl.Vector2, scale: f32, origin: rl.Vector2) rl.Vector2 {
    const rx = pos.x - origin.x;
    const ry = pos.y - origin.y;

    return .{ .x = rx * scale + origin.x, .y = ry * scale + origin.y };
}

// TODO working in pixel coordinates can run into precision issues
//       surprisingly fast.  Look at raylib 2d camera and see how it works,
//       and if it is sufficient, or if we need to track camera position on our
//       own, or some mix.

// Texture with individual tiles of a regular grid.
pub const Set = struct {
    txt: rl.Texture,
    gridWidth: f32,
    gridHeight: f32,
    rects: []const rl.Rectangle,
    al: *mem.Allocator,

    pub const ImgSpec = struct {
        rotation: f32 = 0,
        scale: f32 = 1,
        center: rl.Vector2 = rl.Vector2{ .x = 0.5, .y = 0.5 },
        tint: rl.Color = rl.WHITE,
    };

    // Draw image #`img_index` in the tilemap with `(x, y)` as the top
    // left corner of the image.
    pub fn draw(self: *Set, img_index: usize, x: f32, y: f32, spec: ImgSpec) void {
        if (img_index < self.rects.len) {
            //Note: the destRect of DrawTexturePro really doesn't work like I'd expect.
            // It works as if the x, y is the center of the sprite to be copied.
            // yikes.
            const dstWid = self.gridWidth * spec.scale;
            const dstHt = self.gridHeight * spec.scale;
            const origin = rl.Vector2{.x = dstWid * spec.center.x, .y = dstHt * spec.center.y};

            var destRect = rl.Rectangle{
                .x = x + origin.x,
                .y = y + origin.y,
                .width = self.gridWidth * spec.scale,
                .height = self.gridHeight * spec.scale,
            };

            rl.DrawTexturePro(self.txt, self.rects[img_index], destRect, origin, spec.rotation, spec.tint);
        } else {
            panic("Index {} out of range: 0..{}", .{ img_index, self.rects.len - 1 });
        }
    }

    const Error = error{
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

        return Set{
            .txt = txt,
            .gridWidth = @intToFloat(f32, gridWidth),
            .gridHeight = @intToFloat(f32, gridHeight),
            .rects = rects,
            .al = al,
        };
    }

    pub fn deinit(tm: *Set) void {
        tm.al.free(tm.rects);
    }
};

// All of the pieces for a level.  Loads levels,
// and manages memory for the components that don't
// own their slices, either because the memory is shared
// among several pieces, or to avoid lots of tiny allocations
// in favor of many slices into a big array.
pub const Level = struct {
    al: *mem.Allocator,

    // Allocator used to allocate memory during editing.
    // The expectation is that editor will save the level out
    // into a format of know arrays, that doesn't require
    // the piecemeal allocations here.
    arena: *mem.Allocator,

    // Path to the level file this was read from, or to
    // the file it could be saved to. Owned.
    srcFile: []const u8,

    // Path to the image file for the tilemap.  Owned.
    imgFile: [:0]const u8,

    // One tileset for all of the levels needs ATM.
    tset: Set,

    // Just a single one for now, there will be more later.
    layers: [1]Layer,

    // Backing memory for tile blocks, used by `layers`.
    // If this level has been loaded from a file, then this
    // will be an exactly sized allocation that contains all of the
    // blocks.  In the case where the editor is adding blocks, they
    // will be allocated by `arena`.  It will be up to the level saving
    // code to merge the mix of two memory areas into a single array for
    // later loads.
    layerBlocks: ?[]Block,

    // Block tile array.  For a loaded level, contains all of the
    // tile sequences, referenced by slices in the Block definitions.
    // While editing, some blocks may have slices into memory allocated
    // by `arena`.
    blockTiles: ?[]TileIdx,

    // When editing, these will contain the ArrayLists that back the Layer
    // blockDefs.  Uses the arena allocator.
    editLayerBacking: [1]std.ArrayList(Block),

    // When editing, this contains backs the Block.tiles for new/changed
    // blocks.  Uses the arena allocator.
    editTileBacking: std.ArrayList(TileIdx),

    // Called by the editor to create a new empty level.  `srcFile`
    // must be a valid path for the level file this would be saved to,
    // but the file doesn't need to exist.  imgFile should point to an
    // existing tilemap image.
    //
    // Takes ownership of `srcFile` and `imgFile`.
    pub fn initEmpty(al: *mem.Allocator, arena: *mem.Allocator, srcFile: []const u8, imgFile: [:0]const u8,
        gridDim: u16) !Level {
        if (srcFile.len == 0) return error.BadFileName;

        var noBlocks:[0]Block = undefined;
        var noTiles:[0]TileIdx = undefined;

        return Level{
            .al = al,
            .arena = arena,
            .srcFile = srcFile,
            .imgFile = imgFile,
            .tset = try Set.init(al, rl.LoadTexture(imgFile), gridDim, gridDim),
            .layers = [_]Layer{
                Layer.init(noBlocks[0..0], 1)
            },
            .editLayerBacking = .{
                std.ArrayList(Block).init(arena),
            },
            .editTileBacking = std.ArrayList(TileIdx).init(arena),
            .layerBlocks = null,
            .blockTiles = null,
        };

    }

    // Returns an undefined level structure.
    pub fn undefLevel() Level {
        var rv: Level = undefined;

        return rv;
    }

    pub fn deinit(lv: *Level) void {
        if (lv.layerBlocks) |lb| {
            lv.al.free(lb);
            lv.layerBlocks = null;
        }

        if (lv.blockTiles) |bt| {
            lv.al.free(bt);
            lv.blockTiles = null;
        }

        lv.al.free(lv.srcFile);
        lv.al.free(lv.imgFile);
        lv.arena.deinit();
    }

    // Saves the level to the given file path.
    pub fn save(lv: *Level) !void {
        //TODO: write to temp file, rename when successful.
        var f = try fs.cwd().createFile(lv.srcFile, .{}); defer f.close();
        var fout = f.outStream();
        var wr: chunk.ChunkWriter(fs.File.OutStream.Error) = undefined;

        try wr.init(lv.al, &fout.stream); defer wr.deinit();

        var fst = try wr.startNamedChunk(ChunkTypes, .LevelHeader);
        try wr.writeString(fst, lv.srcFile);
        try wr.writeString(fst, lv.imgFile);
        try wr.endChunk();
    }

    pub fn load(al: *mem.Allocator, arena: *mem.Allocator, srcFile: []const u8) !Level {
        var f = try fs.cwd().openFile(srcFile, .{}); defer f.close();
        var fin = f.inStream();
        var reader = try chunk.ChunkReader(fs.File.InStream.Error).init(al, &fin.stream); defer reader.deinit();
        var imgFile: ?[:0]const u8 = null;
        var rsFile: ?[]const u8 = null;

        defer {
            if (imgFile) |m| al.free(m);
            if (rsFile) |m| al.free(m);
        }

        var cid: u16 = undefined;
        if (try reader.readNextChunk(&cid)) |ins| {
            if (cid == 0) {
                rsFile = try mem.dupe(al, u8, try reader.readString(ins));
                imgFile = try mem.dupeZ(al, u8, try reader.readString(ins));
            } else {
                panic("bad cid {}\n", .{cid});
            }
        } else {
            panic("no ready chunk\n", .{});
        }

        //DEBUGGERY
        if (rsFile) |rs| {
            if (imgFile) |imgf| {
                return Level.initEmpty(al, arena, rs, imgf, 32);
            } else unreachable;
        } else unreachable;
    }
};


const ChunkTypes = enum (u16) {
    LevelHeader,
};
