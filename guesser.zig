const std = @import("std");
const allocator = std.heap.page_allocator;

pub fn main() !void {
    // var seed: u64 = undefined;
    //    try std.os.getrandom(std.mem.asBytes(&seed));
    //
    //    var prng = std.rand.DefaultPrng.init(seed);
    //    const rand = &prng.random;
    //
    //    const target_number = rand.intRangeAtMost(u8, 1, 100);

    const target_number = 10;

    while (true) {
        const stdin = std.io.getStdIn().reader();
        const stdout = std.io.getStdOut().writer();

        const bare_line = try stdin.readUntilDelimiterAlloc(
            allocator,
            '\n',
            8192,
        );
        defer allocator.free(bare_line);

        const guess = std.fmt.parseInt(u8, bare_line, 10) catch |err| switch (err) {
            error.Overflow => {
                try stdout.writeAll("Please enter a small positive number\n");
                continue;
            },
            error.InvalidCharacter => {
                try stdout.writeAll("Please enter a valid number\n");
                continue;
            },
        };
        if (guess < target_number) try stdout.writeAll("Too Small!\n");
        if (guess > target_number) try stdout.writeAll("Too Big!\n");
        if (guess == target_number) {
            try stdout.writeAll("Correct!\n");
            break;
        }
    }
}
