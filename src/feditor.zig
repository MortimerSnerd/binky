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

    // When state == EditingBlock, this contains the
    // tile data.
    blockTiles: ?[MaxBlockDim*MaxBlockDim] tile.TileIdx,

    // Buffer for status and key help message.
    statusBuf: [256]u8 = [_]u8{0} ** 256,

    // Slice into a constant string literal, or into `statusBuf`.
    statusMsg: [:0] const u8,

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

// Just a place to put key action functions.
const Actions = struct {
    fn cancelCreate(dT: f32) FrameResponse {
            return .CreateCancelled;
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
        .blockTiles = null,
        .state = .InitialInvalid,
        .statusMsg = "",
        .level = @intToPtr(*tile.Level, 0x1000),
        .create = CreatingState{
            .workDir = fs.cwd(),
        },
    };
}


fn init0(al: *mem.Allocator, level: *tile.Level, start: State.StateName) void {
    GState = State{
        .al = al,
        .arena = heap.ArenaAllocator.init(al),
        .blockTiles = null,
        .state = start,
        .statusMsg = "",
        .level = level,
        .create = CreatingState{
            .workDir = fs.cwd(),
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
            if (rl.IsKeyPressed(rl.KEY_NINE)) return .Finished;
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
    const fsize = 16;
    updateStatus(&GState);
    rl.DrawText(GState.statusMsg, 10, rl.GetScreenHeight()-fsize, fsize, .{.r = 255, .g = 255, .b = 255, .a = 255});
    return rv;
}

// Updates a slice from the buffer backing the slice after a C call
// may have modfied the null terminated string in the buffer.
fn updateSliceFromCStr(slice: *[] const u8, buf: []u8) void {
    const sl = mem.len(u8, @ptrCast([*:0] const u8, &buf[0]));

    slice.* = buf[0..sl];
}

fn handleCreatingNew(dT: f32)  !FrameResponse {
    const cr = &GState.create;

    if (cr.imgPath.len == 0) {
        const defpath = "resources/";
        mem.copy(u8, cr.imgPathBuf[0..], defpath);
        cr.imgPathBuf[defpath.len] = 0; // Must terminate, because passing to C fn.
        cr.imgPath = cr.imgPathBuf[0..defpath.len:0];
    }

    rl.BeginDrawing();
    rl.ClearBackground(.{.r = 0, .g = 0, .b = 0, .a = 255});

    // Draw the UI
    const fntSz:f32 = 16;
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
                st.blockTiles = [_]tile.TileIdx{tile.EmptyTile} ** (MaxBlockDim * MaxBlockDim);
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
                unreachable;
            },
            .CreatingNew => unreachable,
            .EditingBlock => return,
            .InitialInvalid => unreachable,
        },

        .InitialInvalid => unreachable  // state transition handled implicitly by init0()
    }
}

fn handleEditingBlock(dT: f32) FrameResponse {
    return .Running;
}

fn updateStatus(st: *State) void {
    const sl = switch (st.state) {
        .InitialInvalid => "ARRRRGH"[0..],

        .Editing => blk: {
            const keyhelp = "Escape[Quit]";
            break :blk fmt.bufPrint(st.statusBuf[0..], "FILE {} {}",
                                       .{st.level.srcFile, keyhelp}) catch unreachable;
        },

        .EditingBlock => blk: {
            const keyhelp= "9[Cancel Edit]";
            break :blk fmt.bufPrint(st.statusBuf[0..], "BLOCK {} {}",
                                       .{st.level.srcFile, keyhelp}) catch unreachable;
        },

        .CreatingNew => blk: {
            const keyhelp= "9[Cancel Create]";
            //errr, that is a bad key binding
            break :blk fmt.bufPrint(st.statusBuf[0..], "NEW {}",
                                       .{keyhelp}) catch unreachable;
        },
    };
    st.statusMsg = st.statusBuf[0..sl.len:0];
    st.statusBuf[st.statusMsg.len] = 0;
}

