const std = @import("std");
const warn = std.debug.warn;
const rl = @import("raylib.zig");
const assert = std.debug.assert;

const WHITE = rl.Color{.r=255, .g = 255, .b = 255, .a = 255};
const LIGHTGRAY = rl.Color{.r=200, .g = 200, .b = 200, .a = 255};
const MAROON= rl.Color{.r=90, .g = 33, .b = 55, .a = 255};
const BLUE = rl.Color{.r=0, .g = 0, .b = 255, .a = 255};

pub fn main() void {
  rl.InitWindow(800, 450, "Outta Luck");
  assert(rl.IsWindowReady());
  defer rl.CloseWindow();

  rl.InitAudioDevice();
  assert(rl.IsAudioDeviceReady());
  defer(rl.CloseAudioDevice());

  var mus = rl.LoadMusicStream("bork.mp3");
  defer rl.UnloadMusicStream(mus);
  rl.SetMusicVolume(mus, 0.5);
  rl.PlayMusicStream(mus);
  assert(rl.IsMusicPlaying(mus));

  var fonty = rl.LoadFont("vendor/raylib/examples/text/resources/fonts/mecha.png");
  var ballPos = rl.Vector2{.x = 400, .y = 200};
  const bspeed: f32 = 40;

  while (!rl.WindowShouldClose()) {
    rl.UpdateMusicStream(mus);
    const dt = rl.GetFrameTime();

    if (rl.IsKeyDown(rl.KEY_RIGHT)) ballPos.x += 2 * dt * bspeed;
    if (rl.IsKeyDown(rl.KEY_LEFT))  ballPos.x -= 2 * dt * bspeed;
    if (rl.IsKeyDown(rl.KEY_DOWN))  ballPos.y += 2 * dt * bspeed;
    if (rl.IsKeyDown(rl.KEY_UP))    ballPos.y -= 2 * dt * bspeed;
    if (rl.IsKeyPressed(rl.KEY_SPACE)) warn("SQUIK {}\n", .{rl.GetMousePosition()});
    rl.BeginDrawing();
    rl.ClearBackground(WHITE);
    rl.DrawTextEx(fonty, "Congrats! You're an asshat.", rl.Vector2{.x = 190, .y = 200}, 20, 1, BLUE);
    rl.DrawCircleV(ballPos, 50, MAROON);
    rl.EndDrawing();
  }
}
