// Simple level editing.
const std = @import("std");
const tile = @import("tile.zig");
const rl = @import("raylib.zig");

const assert = std.debug.assert;
const fmt = std.fmt;
const fs = std.fs;
const heap = std.heap;
const mem = std.mem;
const warn = std.debug.warn;

// Largest block can be MaxBlockDim x MaxBlockDim
pub const MaxBlockDim = 16;

const State = struct {
    al: *mem.Allocator,

    // Used to editor allocations for the level
    arena: heap.ArenaAllocator,

    state: StateName,

    // Unowned pointer to the level data
    // we're working on.
    level: *tile.Level,

    // Buffer for status and key help message.
    statusBuf: [256]u8 = [_]u8{0} ** 256,

    // Slice into a constant string literal, or into `statusBuf`.
    statusMsg: [:0] const u8,

    blockEdit: EditingBlockState,
    create: CreatingState,

    pub fn deinit(st: *State) void {
        st.arena.deinit();
    }

    const StateName = enum {
        Editing,
        CreatingNew,
        EditingBlock,

        // See GState definition comment, this is an initial workaround state that exists before a call to init0().
        InitialInvalid,
    };
};

const EditingBlockState = struct {
    // When state == EditingBlock, this contains the
    // tile data.
    blockTiles: [MaxBlockDim*MaxBlockDim] tile.TileIdx,

    // True if the block editing state was cancelled, and blockTiles should
    // not be saved.
    cancelled: bool,

    // Tile that be painted to a grid on a mouse click.
    curTile: u8,
};

const CreatingState = struct {
    // Any error message displayed at the top of the screen.
    topMsg: [:0]const u8 = "",

    // Path to png file for tileset.
    imgPath: [:0]const u8 = "",
    imgPathBuf: [fs.MAX_PATH_BYTES]u8 = [_]u8{0} ** fs.MAX_PATH_BYTES,

    // Base name used to create level and tile block
    // files.
    baseName: [:0]const u8 = "",
    baseNameBuf: [64]u8 = [_]u8{0} ** 64,

    // index of text buffer that has focus.
    focus: usize = 0,

    // Grid dimensions, assume grids are square.
    gridDim: u16 = 32,

    workDir: fs.Dir,

    // Set up our buffers.
    pub fn init(cs: *CreatingState) void {
        cs.imgPath = cs.imgPathBuf[0..0:0];
        cs.baseName = cs.baseNameBuf[0..0:0];
    }

};

// Due to https://github.com/ziglang/zig/issues/2622, I can't define a global
// State here, and initialize it undefined.  So we build out an equally invalid
// instantiation here manually, which init0 will overwrite.
var GState: State = undefInit();

fn undefInit() State {
   return State{
        .al = heap.c_allocator,
        .arena = undefined,
        .state = .InitialInvalid,
        .statusMsg = "",
        .level = @intToPtr(*tile.Level, 0x1000),
        .create = CreatingState{
            .workDir = fs.cwd(),
        },
        .blockEdit = EditingBlockState{
            .blockTiles = undefined,
            .cancelled = false,
            .curTile = 0,
        },
    };
}


fn init0(al: *mem.Allocator, level: *tile.Level, start: State.StateName) void {
    GState = State{
        .al = al,
        .arena = heap.ArenaAllocator.init(al),
        .state = start,
        .statusMsg = "",
        .level = level,
        .create = CreatingState{
            .workDir = fs.cwd(),
        },
        .blockEdit = EditingBlockState{
            .blockTiles = undefined,
            .cancelled = false,
            .curTile = 0,
        },
    };
    GState.create.init();
}

// Must be called before calling any other
// functions.  Call deinit() when done.
pub fn init(al: *mem.Allocator, level: *tile.Level) void {
    return init0(al, level, .Editing);
}

// Should be called to have the editor create a new level.
// Pointers to assets for this call should be to undefined
// structs, that the editor will initialize.  If the editor
// can not initialize the level data, handleFrame will return
// CreateCancelled, so the caller will know to throw out the level
// data without attempting to use or deinit() it.
pub fn mkNew(al: *mem.Allocator, level: *tile.Level) void {
    return init0(al, level, .CreatingNew);
}

pub fn deinit() void {
    GState.deinit();

    // Part of GState workaround, see GState def for details.
    GState = undefInit();
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

pub fn handleFrame(dT: f32) !FrameResponse {
    const rv = switch (GState.state) {
        .InitialInvalid => unreachable,
        .EditingBlock => handleEditingBlock(dT),
        .Editing => blk: {
            if (rl.IsKeyPressed(rl.KEY_ESCAPE)) {
                try GState.level.save();
                break :blk .Finished;
            }

            if (controlPressed(rl.KEY_B)) {
                switchState(&GState, .EditingBlock);
                break :blk FrameResponse.Running;
            }

            rl.BeginDrawing();
            rl.ClearBackground(.{.r = 0, .g = 0, .b = 0, .a = 255});
            rl.EndDrawing();
            break :blk .Running;
        },

        .CreatingNew => blk: {
            break :blk try handleCreatingNew(dT);
        },
    };

    // Draw status at bottom always.
    const fsize = 10;
    updateStatus(&GState);
    rl.DrawText(GState.statusMsg, 10, rl.GetScreenHeight()-fsize, fsize, .{.r = 255, .g = 255, .b = 255, .a = 255});
    return rv;
}

pub fn controlPressed(key: c_int) bool {
    return rl.IsKeyDown(rl.KEY_LEFT_CONTROL) and rl.IsKeyPressed(key);
}


// Updates a slice from the buffer backing the slice after a C call
// may have modfied the null terminated string in the buffer.
fn updateSliceFromCStr(slice: *[] const u8, buf: []u8) void {
    const sl = mem.len(@ptrCast([*:0] const u8, &buf[0]));

    slice.* = buf[0..sl];
}

fn handleCreatingNew(dT: f32)  !FrameResponse {
    const cr = &GState.create;

    if (rl.IsKeyPressed(rl.KEY_ESCAPE)) {
        return .CreateCancelled;
    }

    if (cr.imgPath.len == 0) {
        const defpath = "resources/";
        mem.copy(u8, cr.imgPathBuf[0..], defpath);
        cr.imgPathBuf[defpath.len] = 0; // Must terminate, because passing to C fn.
        cr.imgPath = cr.imgPathBuf[0..defpath.len:0];
    }

    rl.BeginDrawing();
    rl.ClearBackground(.{.r = 0, .g = 0, .b = 0, .a = 255});

    // Draw the UI
    const fntSz:f32 = 20;
    const vspace:f32 = 4;
    const labwidth:f32 = fntSz * 10;
    const lmargin:f32 = 40;
    var liney: f32 = 100;
    var retHit = false;

    if (cr.topMsg.len > 0) {
        rl.DrawText(@ptrCast([*c]const u8, &cr.topMsg[0]), 50, 50, fntSz, .{.r = 255, .g = 0, .b = 0, .a = 255});
    }

    rl.GuiLabel(.{.x = lmargin, .y = liney, .width = labwidth, .height = fntSz + vspace}, "Tileset image path:");
    retHit =  rl.GuiTextBox(.{.x = lmargin + labwidth, .y = liney, .width = fntSz * 20, .height = fntSz + vspace},
       &cr.imgPathBuf,
       @intCast(c_int, cr.imgPathBuf.len),
        cr.focus % 2 == 0) or retHit;
    liney += vspace*2 + fntSz;

    rl.GuiLabel(.{.x = lmargin, .y = liney, .width = labwidth, .height = fntSz + vspace}, "Base name for new level/set:");
    retHit = rl.GuiTextBox(.{.x = lmargin + labwidth, .y = liney, .width = fntSz*20, .height = fntSz + vspace},
        &cr.baseNameBuf,
        @intCast(c_int, cr.baseNameBuf.len),
        cr.focus % 2 == 1) or retHit;
    liney += vspace*2 + fntSz;

    const ok = rl.GuiButton(.{.x = lmargin, .y = liney, .width = fntSz*5, .height = fntSz+vspace}, "OK");
    const canceled = rl.GuiButton(.{.x = lmargin + fntSz*5 + 10, .y = liney, .width = fntSz*5, .height = fntSz+vspace}, "Cancel");

    // The GuiTextBox call can modify the text in the imgPathBuf.
    updateSliceFromCStr(&cr.imgPath, cr.imgPathBuf[0..]);
    updateSliceFromCStr(&cr.baseName, cr.baseNameBuf[0..]);

    if (retHit) {
        cr.focus += 1;
    }

    // TODO: we're beating the crap out the fs doing these file checks every frame,
    // but not sure it's worth keeping up when the strings change to do
    // better.
    if (!checkValidFile(cr.imgPath)) {
        cr.topMsg = "Tileset image path doesn't point to an existing image file.";
    } else if (cr.baseName.len == 0) {
        cr.topMsg = "No basename supplied.";
    } else if (cr.baseName.len > 0) {
        var buf: [fs.MAX_PATH_BYTES]u8 = undefined;
        const bfn = try blockFileName(buf[0..], cr.baseName);

        if (fileExists(bfn)) {
            cr.topMsg = "Already a file in resources with the given base name.";
        } else {
            cr.topMsg.len = 0;
        }
    } else {
        cr.topMsg.len = 0;
    }

    if (cr.topMsg.len == 0 and ok) {
        try createLvl();
        switchState(&GState, .Editing);
        return .Running;
    }

    if (canceled) {
       return .CreateCancelled;
    }

    rl.EndDrawing();

    return .Running;
}

// Checks for the existance of the file at
// a path expected to be relative to the working directory
// of the program.
//TODO: is there really no way exposed in the fs.Dir/File api
// to test if something is a file or directory, or am I missing
// something?
fn checkValidFile(fname: []const u8) bool {
    const cr = &GState.create;
    var fl = cr.workDir.openFile(fname, .{.read = true}) catch return false;
    defer fl.close();

    const st = fl.stat() catch return false;
    return true;
}

// This is ugly.
fn fileExists(fname: []const u8) bool {
    var fl = GState.create.workDir.openFile(fname, .{.read = true}) catch return false;
    fl.close();
    return true;
}


fn blockFileName(buf: []u8, basename: []const u8) ![]const u8 {
    return fmt.bufPrint(buf, "resources/{}.blk", .{basename});
}

// Creates a blank level based on the information in
// GState.create.
fn createLvl() !void {
    var buf: [fs.MAX_PATH_BYTES]u8 = undefined;
    const bname = try blockFileName(buf[0..], GState.create.baseName);
    const srcFile = try mem.dupe(GState.al, u8, bname);
    const imgFile = try mem.dupeZ(GState.al, u8, GState.create.imgPath);

    GState.level.* = try tile.Level.initEmpty(GState.al, &GState.arena.allocator, srcFile, imgFile, GState.create.gridDim);
}

fn switchState(st: *State, newState: State.StateName) void {
    switch (st.state) {
        .Editing => switch (newState) {
            .Editing => return,
            .CreatingNew => unreachable,
            .EditingBlock => {
                // Clear the tiles we show in the editor.
                st.blockEdit.blockTiles = [_]tile.TileIdx{tile.EmptyTile} ** (MaxBlockDim * MaxBlockDim);
                st.blockEdit.cancelled = false;
                st.state = newState;
            },
            .InitialInvalid => unreachable,
        },

        .CreatingNew => switch (newState) {
            .Editing => {
                // Level is initialized, nothing to see here.
                st.state = newState;
            },
            .CreatingNew => return,
            .EditingBlock => unreachable,
            .InitialInvalid => unreachable,
        },

        .EditingBlock => switch(newState) {
            .Editing => {
                // do things here to add the block to the level.
                //TODO need flag to say whether the block edit was cancelled.
                // if not cancelled, create a new block from the data and
                // add it to the Level.
                st.state = newState;
            },
            .CreatingNew => unreachable,
            .EditingBlock => return,
            .InitialInvalid => unreachable,
        },

        .InitialInvalid => unreachable  // state transition handled implicitly by init0()
    }

    // Clear out any pressed keys in the queue - we don't want presses to carry over
    // from switching states.
    while (rl.GetKeyPressed() > 0) {}
}

fn handleEditingBlock(dT: f32) FrameResponse {
    if (rl.IsKeyPressed(rl.KEY_ESCAPE)) {
        GState.blockEdit.cancelled = true;
        switchState(&GState, .Editing);
        // Go ahead an continue the frame,
        // the next frame will reflect the change.
    }

    const mpos = rl.GetMousePosition();
    const mouGrid = gridCoords(mpos);

    rl.BeginDrawing();
    rl.ClearBackground(.{.r = 0, .g = 0, .b = 0, .a = 255});

    const gridWidth = GState.level.tset.gridWidth;
    const gridHeight = GState.level.tset.gridHeight;

    // Draw the block tiles.
    var sy: f32 = 0;
    var ty: usize = 0;
    var idx: usize = 0;
    var spec = tile.Set.ImgSpec{};

    while (ty < MaxBlockDim) : ({ty += 1; sy += gridHeight;}) {
        var tx: usize = 0;
        var sx: f32 = 0;
        while (tx < MaxBlockDim) : ({tx += 1; sx += gridWidth; idx += 1;}) {
            const img = GState.blockEdit.blockTiles[idx];
            if (img != tile.EmptyTile) {
                GState.level.tset.draw(img, sx, sy, spec);
            }
        }
    }

    // Draw the current palette tile.
    const sw = rl.GetScreenWidth();
    const scale = 2;
    const fsize = 10;
    GState.level.tset.draw(GState.blockEdit.curTile, @intToFloat(f32, sw) - gridWidth*scale, 30,
                           .{.scale = scale});
    rl.DrawText("Current", sw - 64, 30 + @floatToInt(c_int, gridHeight)*scale + fsize, fsize, rl.WHITE);

    if (mouGrid) |mg| {
        // Highlight the mouse grid position, if mouse is over
        // grid.
        const x = mg.x * gridWidth;
        const y = mg.y * gridHeight;
        const ex = x + gridWidth;
        const ey = y + gridHeight;
        var pts = [5]rl.Vector2{
            .{.x = x, .y = y},
            .{ .x = ex, .y = y},
            .{ .x = ex, .y = ey},
            .{ .x = x, .y = ey},
            .{ .x = x, .y = y},
        };
        rl.DrawLineStrip(&pts[0], pts.len, .{.r = 0, .g = 255, .b = 0, .a = 255});

        // Need to set a tile?
        if (rl.IsMouseButtonPressed(0)) {
            GState.blockEdit.blockTiles[editBlockIdx(mg)] = GState.blockEdit.curTile;
        } else if (rl.IsMouseButtonPressed(1)) {
            GState.blockEdit.blockTiles[editBlockIdx(mg)] = tile.EmptyTile;
        }
    }

    rl.EndDrawing();

    return .Running;
}

// Returns index into blockTiles for a mouse grid coordinate.
fn editBlockIdx(mgrid: rl.Vector2) usize {
    return @floatToInt(usize, mgrid.y) * MaxBlockDim + @floatToInt(usize, mgrid.x);
}

const V2i = struct {
    x: u32,
    y: u32,
};

fn gridCoords(p: rl.Vector2) ?rl.Vector2 {
    const x = p.x / GState.level.tset.gridWidth;
    const y = p.y / GState.level.tset.gridHeight;
    const gx = @floor(x);
    const gy = @floor(y);

    if (gx >= 0 and gy >= 0 and gx < MaxBlockDim and gy < MaxBlockDim) {
        return rl.Vector2{.x = gx, .y = gy};
    } else {
        return null;
    }
}

fn updateStatus(st: *State) void {
    const sl = switch (st.state) {
        .InitialInvalid => "ARRRRGH"[0..],

        .Editing => blk: {
            const keyhelp = "Escape[Cancel Edit] Ctrl-B[Edit Block] Ctrl-X[Quit]";
            break :blk fmt.bufPrint(st.statusBuf[0..], "FILE {} {}",
                                       .{st.level.srcFile, keyhelp}) catch unreachable;
        },

        .EditingBlock => blk: {
            const keyhelp= "Escape[Cancel Edit]";
            break :blk fmt.bufPrint(st.statusBuf[0..], "BLOCK {} {}",
                                       .{st.level.srcFile, keyhelp}) catch unreachable;
        },

        .CreatingNew => blk: {
            const keyhelp= "Escape[Cancel Create]";
            break :blk fmt.bufPrint(st.statusBuf[0..], "NEW {}",
                                       .{keyhelp}) catch unreachable;
        },
    };
    st.statusBuf[sl.len] = 0;
    st.statusMsg = st.statusBuf[0..sl.len:0];
}

