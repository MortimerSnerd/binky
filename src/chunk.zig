// Chunked file format support.
const std = @import("std");

const Allocator = std.mem.Allocator;
const assert = std.debug.assert;
const Check = std.hash.Crc32;
const InStream = std.io.InStream;
const maxInt = std.math.maxInt;
const mem = std.mem;
const OutStream = std.io.OutStream;
const panic = std.debug.panic;
const SliceOutStream = std.io.SliceOutStream;
const SliceInStream = std.io.SliceInStream;
const warn = std.debug.warn;

const Chunk = packed struct {
    // Chunk id.  Meaningful to clients, means nothing to us.
    id: u16,

    // A checksum using `Check` on the data in the chunk.
    check: u32,

    // Length of the chunk, not counting this chunk header.
    // Could be zero if the given chunk id is some sort of sentinel.
    len: u32,
};


// Support for writing files made of chunks.
// Basic flow:
//    var w = ChunkWriter(..).init(...);
//    var cs = try w.startChunk(0x12);  // Chunk id 0x12
//    try cs.write(...);
//    try cs.write(...);
//    try w.endChunk(); // Actually flushes the chunk to the underlying stream.
pub fn ChunkWriter(comptime StreamError: type) type {
    return struct {
        const Self = @This();

        // For simplicity, there's a fixed max chunk size. This can change
        // once things are more stable.
        const MaxChunk = 256 * 1024;

        al: *Allocator,
        outs: *OutStream(StreamError),
        chunkStarted: bool,
        dataOut: SliceOutStream,
        ckOut: CheckedOutStream(SliceOutStream.Error),
        writeBuffer: []u8,
        curId: u16,


        // Note - without being able to refer to the result location, don't think I can
        // initialize the depedendency between ckOut and dataOut. So we pass in pointer
        // to a writer to initialize, to do it manually. Will have to be doubly careful
        // not to leave out any new struct members, since we won't be warned like we
        // would if we were using a struct literal.
        pub fn init(self: *Self, al: *Allocator, outs: *OutStream(StreamError)) !void {
            const buf = try al.alloc(u8, MaxChunk);
            self.al = al;
            self.outs = outs;
            self.chunkStarted = false;
            self.dataOut = SliceOutStream.init(buf);
            self.ckOut = undefined;
            self.writeBuffer = buf;
            self.ckOut = CheckedOutStream(OutStream(SliceOutStream.Error).Error).init(&self.dataOut.stream);
            self.curId = 0;
        }

        pub fn deinit(self: *Self) void {
            if (self.chunkStarted) panic("ChunkWriter: Deinit with unfinished chunk", .{});
            self.al.free(self.writeBuffer);
        }

        pub fn startChunk(self: *Self, id: u16) !*OutStream(SliceOutStream.Error) {
            if (self.chunkStarted) return error.ChunkAlreadyStarted;
            self.chunkStarted=true;
            self.curId = id;
            self.dataOut.reset();
            self.ckOut.resetChecksum();

            return &self.ckOut.stream;
        }

        pub fn startNamedChunk(self: *Self, comptime Names: type, id: Names) !*OutStream(SliceOutStream.Error) {
            return self.startChunk(@enumToInt(id));
        }

        pub fn endChunk(self: *Self) !void {
            if (!self.chunkStarted) return error.ChunkNotStarted;
            if (self.ckOut.bytes_written > maxInt(u32)) return error.ChunkTooBig;

            var header = Chunk{
                .id = self.curId,
                .check = self.ckOut.cksum(),
                .len = @intCast(u32, self.ckOut.bytes_written),
            };
            try self.outs.write(mem.asBytes(&header));
            try self.outs.write(self.dataOut.getWritten());
            self.chunkStarted=false;
        }

        // Writes a counted string that has a max length of 65535 bytes
        // to `outs`.  `outs` needs to be the stream returned by `startChunk`.
        pub fn writeString(self: *Self, outs: *OutStream(SliceOutStream.Error), str: []const u8) !void {
            assert(outs == &self.ckOut.stream);
            assert(str.len < maxInt(u16));
            try outs.writeIntNative(u16, @intCast(u16, str.len));
            try outs.write(str);
        }

    };
}

pub fn ChunkReader(comptime StreamError: type) type {
    return struct {
        const Self = @This();
        const InitBufSz = 256 * 1024;

        al: *Allocator,
        ins: *InStream(StreamError),
        readBuf: []u8,
        readStr: SliceInStream,

        pub fn init(al: *Allocator, ins: *InStream(StreamError)) !Self {
            return Self{
                .al = al,
                .ins = ins,
                .readBuf = try al.alloc(u8, InitBufSz),
                .readStr = undefined,
            };
        }

        pub fn deinit(self: *Self) void {
            self.al.free(self.readBuf);
        }

        // Returns a byte slice into the readBuf containing the data of this chunk,
        // or null if EOF was reached.
        fn readNextChunkIntern(self: *Self, cid: *u16) !?[]const u8 {
            var header: Chunk = undefined;
            var hbuf = mem.asBytes(&header);
            var numRead: usize = 0;

            while (numRead < hbuf.len) {
                const actual = try self.ins.read(hbuf[numRead..]);

                if (actual == 0) return null;  //EOF
                numRead += actual;
            }

            cid.* = header.id;
            if (self.readBuf.len < header.len) {
                self.readBuf = try self.al.realloc(self.readBuf, header.len);
            }

            numRead = 0;
            while (numRead < header.len) {
                const actual = try self.ins.read(self.readBuf[numRead..]);
                if (actual == 0) return error.UnexpectedEOF;

                numRead += actual;
            }

            var check = Check.init();

            check.update(self.readBuf[0..numRead]);
            if (check.final() != header.check) return error.BadChecksum;

            return self.readBuf[0..numRead];
        }

        // If there's another chunk in the stream, return the id via `cid`,
        // and return an input stream that can read the chunk data.
        pub fn readNextChunk(self: *Self, cid: *u16) !?*InStream(SliceInStream.Error) {
            if (try readNextChunkIntern(self, cid)) |sl| {
                self.readStr = SliceInStream.init(sl);
                return &self.readStr.stream;
            } else {
                return null;
            }
        }

        // Reads a counted string from `ins` and returns the slice for the string.
        // This slice is only valid until the next call to readNextChunk.
        pub fn readString(self: *Self, ins: *InStream(SliceInStream.Error)) ![]const u8 {
            assert(ins == &self.readStr.stream);
            const ssize: usize = try ins.readIntNative(u16);

            //Nastiness: we use our knowledge of the SliceInStream implementation
            // to just extract the slice into our buffer.
            if (ssize + self.readStr.pos >= self.readBuf.len) return error.BufferTooSmall;
            const rv = self.readBuf[self.readStr.pos..self.readStr.pos+ssize];
            self.readStr.pos += ssize;
            return rv;
        }
    };
}

// A OutStream that wraps another outstream, and keeps a running
// checksum on what's been written.
pub fn CheckedOutStream(comptime OutStreamError: type) type {
    return struct {
        const Self = @This();
        pub const Stream = OutStream(Error);
        pub const Error = OutStreamError;

        stream: Stream,
        bytes_written: u64,
        child_stream: *Stream,
        check: Check,

        pub fn init(child_stream: *Stream) Self {
            return Self{
                .stream = Stream{.writeFn = writeFn},
                .bytes_written = 0,
                .child_stream = child_stream,
                .check = Check.init(),
            };
        }

        pub fn resetChecksum(self: *Self) void {
            self.check = Check.init();
        }

        pub fn cksum(self: *Self) u32 {
            return self.check.final();
        }

        fn writeFn(out_stream: *Stream, bytes: []const u8) OutStreamError!usize {
            const self = @fieldParentPtr(Self, "stream", out_stream);
            try self.child_stream.write(bytes);
            self.bytes_written += bytes.len;
            self.check.update(bytes);
            return bytes.len;
        }
    };
}

