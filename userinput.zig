const std = @import("std");
const allocator = std.heap.page_allocator;

pub fn main() !void {
    var input = std.io.getStdIn().reader();
    const print = std.debug.print;

    print("{s}", .{"Enter your Name: "});

    var name = try input.readUntilDelimiterAlloc(allocator, '\n', std.math.maxInt(usize));
    defer allocator.free(name);
    print("Hello! {s}", .{name});
}
