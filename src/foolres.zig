const std = @import("std");
const tile = @import("tile.zig");

// Probably temporary module until I can edit tile blocks.
pub const Dirt = struct {
    pub const imgFile = "resources/platformertiles.png";
    pub const gridWidth: f32 = 32;
    pub const gridHeight: f32 = 32;

    pub const BlockDefs = [_]tile.Block {
       tile.Block.init(&[_]u8{1, 2, 2, 1}, 2, 2) catch unreachable,
       tile.Block.init(&[_]u8{
           0, 1, 2,
           8, 9, 10,
           16, 17, 18}, 3, 3) catch unreachable,
        tile.Block.init(&[_]u8{3}, 1, 1) catch unreachable,
    };

    pub const N = struct {
        pub const H4 = 0;
        pub const Chunk = 1;
        pub const Moon = 2;
    };

};
