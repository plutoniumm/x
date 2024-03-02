const std = @import("std");

const G: f64 = 9.81;
const L1: f64 = 1.0;
const L2: f64 = 1.0;
const M1: f64 = 1.0;
const M2: f64 = 1.0;

const M = M1 + M2;
const L = L1 + L2;

fn sq(x: f64) f64 {
    return x * x;
}

fn grads(state: *[4]f64, dt: f64) void {
    var dydx: [4]f64 = undefined;

    dydx[0] = state[1];

    const d = state[2] - state[0];

    const s = @sin(d);
    const c = @cos(d);

    const den1 = M * L1 - M2 * L1 * sq(c);
    const den2 = (L2 / L1) * den1;

    dydx[1] = ((M2 * L1 * sq(state[1]) * s * c) + (M2 * G * @sin(state[2]) * c) + (M2 * L2 * sq(state[3]) * s - M * G * @sin(state[0]))) / den1;

    dydx[2] = state[3];

    dydx[3] = ((M * G * @sin(state[0]) - M2 * L2 * sq(state[3]) * s) * c - M * L1 * sq(state[1]) * s - M * G * @sin(state[2])) / den2;

    state[0] += dydx[0] * dt;
    state[1] += dydx[1] * dt;
    state[2] += dydx[2] * dt;
    state[3] += dydx[3] * dt;
}

fn inted(x: f64) i32 {
    return @intFromFloat(@round(x));
}

pub fn main() !void {
    const dt: f64 = 0.01;
    const time: f64 = 60.0;

    const alloc = std.heap.c_allocator;
    var args = try std.process.argsWithAllocator(alloc);
    defer args.deinit();
    _ = args.skip();

    var param: f64 = 0.0;
    while (args.next()) |arg| {
        param = try std.fmt.parseFloat(f64, arg);
    }

    const th1: f64 = param;
    const th2: f64 = param;
    var y = [4]f64{ th1, 0.0, th2, 0.0 };

    var i: u16 = 0;
    while (i < (time / dt)) {
        grads(&y, dt);
        i += 1;
    }

    const angles = [2]i32{ inted(y[0]), inted(y[2]) };
    std.debug.print("{}\n", .{angles[0] + angles[1]});
}
