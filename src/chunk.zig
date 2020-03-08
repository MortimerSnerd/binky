// Chunked file format support.
const std = @import("std");

const Allocator = std.mem.Allocator;
const Check = std.hash.Crc32;
const InStream = std.io.InStream;
const maxInt = std.math.maxInt;
const mem = std.mem;
const OutStream = std.io.OutStream;
const panic = std.debug.panic;
const SliceOutStream = std.io.SliceOutStream;

const Chunk = packed struct {
    // Chunk id.  Meaningful to clients, means nothing to us.
    id: u16,

    // A checksum using `Check` on the data in the chunk.
    check: u32,

    // Length of the chunk, not counting this chunk header.
    // Could be zero if the given chunk id is some sort of sentinel.
    len: u32,
};


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
            if (self.chunkStarted) panic("ChunkWriter: Deinit with unfinished chunk");
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
