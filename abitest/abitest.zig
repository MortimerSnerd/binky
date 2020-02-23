// Not meant to be run, but just compiled to see if there
// any functions that can't be used because of Zig's temporary
// holes in the ABI support.   (the biggest culprit right now is passing
// structs <= 16bytes by value.
//
// TODO If there is a ABI problem, the compiler will fail with a
//    "TODO" error mentioning the ABI problem.  At the moment, the
//    abitest won't link, possibly because I misunderstand the pkg support,
//    but also maybe because the support isn't fully baked.  Revisit once
//    the package system is more in place.
const std = @import("std");
const warn = std.debug.warn;
const rl = @import("raylib");

pub fn main() void {
    warn("This file isn't really executable, it's just a compile test.\nPrepare to explode.\n", .{});

    var rect: rl.Rectangle = undefined;
    var tlc: rl.TraceLogCallback = undefined;
    var rtext: rl.RenderTexture2D = undefined;
    var cam2: rl.Camera2D = undefined;
    var cam3: rl.Camera3D = undefined;
    var v2: rl.Vector2 = undefined;
    var color: rl.Color = undefined;
    const string = "bork";
    var image: rl.Image = undefined;
    var txt: rl.Texture2D = undefined;

    rl.DrawCircleV(v2, 1.0, color);
    rl.InitWindow(100, 100, "test");
    _ = rl.WindowShouldClose();
    rl.CloseWindow();
    _ = rl.IsWindowReady();
    _ = rl.IsWindowMinimized();
    _ = rl.IsWindowResized();
    _ = rl.IsWindowHidden();
    _ = rl.IsCursorHidden();
    _ = rl.IsFileDropped();
    _ = rl.IsVrSimulatorReady();
    _ = rl.IsAudioDeviceReady();
    _ = rl.IsPhysicsEnabled();
    _ = rl.WindowShouldClose();
    _ = rl.IsWindowReady();
    _ = rl.IsWindowMinimized();
    _ = rl.IsWindowResized();
    _ = rl.IsWindowHidden();
    _ = rl.IsCursorHidden();
    _ = rl.IsFileDropped();
    _ = rl.IsVrSimulatorReady();
    _ = rl.IsAudioDeviceReady();
    _ = rl.IsPhysicsEnabled();
    rl.ToggleFullscreen();
    rl.UnhideWindow();
    rl.HideWindow();
    rl.ShowCursor();
    rl.HideCursor();
    rl.EnableCursor();
    rl.DisableCursor();
    rl.BeginDrawing();
    rl.EndDrawing();
    rl.EndMode2D();
    rl.EndMode3D();
    rl.EndTextureMode();
    rl.EndScissorMode();
    rl.ClearDirectoryFiles();
    rl.ClearDroppedFiles();
    rl.EndShaderMode();
    rl.EndBlendMode();
    rl.InitVrSimulator();
    rl.CloseVrSimulator();
    rl.ToggleVrMode();
    rl.BeginVrDrawing();
    rl.EndVrDrawing();
    rl.InitAudioDevice();
    rl.CloseAudioDevice();
    rl.StopSoundMulti();
    rl.GuiEnable();
    rl.GuiDisable();
    rl.GuiLock();
    rl.GuiUnlock();
    rl.GuiLoadStyleDefault();
    rl.GuiUpdateStyleComplete();
    rl.InitPhysics();
    rl.RunPhysicsStep();
    rl.ResetPhysics();
    rl.ClosePhysics();
    rl.CloseWindow();
    rl.ToggleFullscreen();
    rl.UnhideWindow();
    rl.HideWindow();
    rl.ShowCursor();
    rl.HideCursor();
    rl.EnableCursor();
    rl.DisableCursor();
    rl.BeginDrawing();
    rl.EndDrawing();
    rl.EndMode2D();
    rl.EndMode3D();
    rl.EndTextureMode();
    rl.EndScissorMode();
    rl.ClearDirectoryFiles();
    rl.ClearDroppedFiles();
    rl.EndShaderMode();
    rl.EndBlendMode();
    rl.InitVrSimulator();
    rl.CloseVrSimulator();
    rl.ToggleVrMode();
    rl.BeginVrDrawing();
    rl.EndVrDrawing();
    rl.InitAudioDevice();
    rl.CloseAudioDevice();
    rl.StopSoundMulti();
    rl.GuiEnable();
    rl.GuiDisable();
    rl.GuiLock();
    rl.GuiUnlock();
    rl.GuiLoadStyleDefault();
    rl.GuiUpdateStyleComplete();
    rl.InitPhysics();
    rl.RunPhysicsStep();
    rl.ResetPhysics();
    rl.ClosePhysics();
    rl.SetWindowIcon(image);
    rl.SetWindowTitle(string);
    rl.SetWindowPosition(1, 1);
    rl.SetWindowMonitor(1);
    rl.SetWindowMinSize(1, 1);
    rl.SetWindowSize(1, 1);
    rl.SetClipboardText(string);
    rl.ClearBackground(color);
    rl.BeginMode2D(cam2);
    rl.BeginMode3D(cam3);
    rl.BeginTextureMode(rtext);
    rl.BeginScissorMode(1, 1, 1, 1);
    rl.SetTargetFPS(1);
    rl.SetConfigFlags(1);
    rl.SetTraceLogLevel(1);
    rl.SetTraceLogExit(1);
    rl.SetTraceLogCallback(tlc);
    rl.TakeScreenshot(string);
    rl.StorageSaveValue(1, 1);
    rl.OpenURL(string);
    rl.SetExitKey(1);
    rl.SetMousePosition(1, 1);
    rl.SetMouseOffset(1, 1);
    rl.SetMouseScale(1.0, 1.0);
    rl.SetGesturesEnabled(1);
    rl.SetCameraMode(cam3, 1);
    rl.UpdateCamera(&cam3);
    rl.SetCameraPanControl(1);
    rl.SetCameraAltControl(1);
    rl.SetCameraSmoothZoomControl(1);
    rl.SetCameraMoveControls(1, 1, 1, 1, 1, 1);
    rl.DrawPixel(1, 1, color);
    rl.DrawLine(1, 1, 1, 1, color);
    rl.DrawLineStrip(&v2, 1, color);
    rl.DrawCircle(1, 1, 1.0, color);
    rl.DrawCircleGradient(1, 1, 1.0, color, color);
    rl.DrawCircleLines(1, 1, 1.0, color);
    rl.DrawEllipse(1, 1, 1.0, 1.0, color);
    rl.DrawEllipseLines(1, 1, 1.0, 1.0, color);
    rl.DrawRectangle(1, 1, 1, 1, color);
    rl.DrawRectangleRec(rect, color);
    rl.DrawRectangleGradientV(1, 1, 1, 1, color, color);
    rl.DrawRectangleGradientH(1, 1, 1, 1, color, color);
    rl.DrawRectangleGradientEx(rect, color, color, color, color);
    rl.DrawRectangleLines(1, 1, 1, 1, color);
    rl.DrawRectangleLinesEx(rect, 1, color);
    rl.DrawRectangleRounded(rect, 1.0, 1, color);
    rl.DrawRectangleRoundedLines(rect, 1.0, 1, 1, color);
    rl.DrawTriangleFan(&v2, 1, color);
    rl.DrawTriangleStrip(&v2, 1, color);
    rl.ExportImage(image, string);
    rl.ExportImageAsCode(image, string);
    rl.UnloadImage(image);
    rl.UnloadTexture(txt);
    rl.UnloadRenderTexture(rtext);

//     rl.UpdateTexture(txt, pixels: ?*const c_void)
//     rl.ImageToPOT(image: [*c]Image, color)
//     rl.ImageFormat(image: [*c]Image, 1)
//     rl.ImageAlphaMask(image: [*c]Image, image)
//     rl.ImageAlphaClear(image: [*c]Image, color, 1.0)
//     rl.ImageAlphaCrop(image: [*c]Image, 1.0)
//     rl.ImageAlphaPremultiply(image: [*c]Image)
//     rl.ImageCrop(image: [*c]Image, rect)
//     rl.ImageResize(image: [*c]Image, 1, 1)
//     rl.ImageResizeNN(image: [*c]Image, 1, 1)
//     rl.ImageResizeCanvas(image: [*c]Image, 1, 1, 1, 1, color)
//     rl.ImageMipmaps(image: [*c]Image)
//     rl.ImageDither(image: [*c]Image, 1, 1, 1, 1)
//     rl.ImageDraw(dst: [*c]Image, image, rect, rect, color)
//     rl.ImageDrawRectangle(dst: [*c]Image, rect, color)
//     rl.ImageDrawRectangleLines(dst: [*c]Image, rect, 1, color)
//     rl.ImageFlipVertical(image: [*c]Image)
//     rl.ImageFlipHorizontal(image: [*c]Image)
//     rl.ImageRotateCW(image: [*c]Image)
//     rl.ImageRotateCCW(image: [*c]Image)
//     rl.ImageColorTint(image: [*c]Image, color)
//     rl.ImageColorInvert(image: [*c]Image)
//     rl.ImageColorGrayscale(image: [*c]Image)
//     rl.ImageColorContrast(image: [*c]Image, 1.0)
//     rl.ImageColorBrightness(image: [*c]Image, 1)
//     rl.ImageColorReplace(image: [*c]Image, color, color)
//     rl.GenTextureMipmaps(texture: [*c]Texture2D)
//     rl.SetTextureFilter(txt, 1)
//     rl.SetTextureWrap(txt, 1)
//     rl.DrawTexture(txt, 1, 1, color)
//     rl.UnloadFont(font: Font)
//     rl.DrawFPS(1, 1)
//     rl.DrawText(string, 1, 1, 1, color)
//     rl.DrawTextRec(font: Font, string, rect, 1.0, 1.0, wordWrap: bool, color)
//     rl.DrawTextRecEx(font: Font, string, rect, 1.0, 1.0, wordWrap: bool, color, 1, 1, color, color)
//     rl.TextAppend(text: [*c]u8, string, position: [*c]c_int)
//     rl.DrawRay(ray: Ray, color)
//     rl.DrawGrid(1, 1.0)
//     rl.UnloadModel(model: Model)
//     rl.ExportMesh(mesh: Mesh, string)
//     rl.UnloadMesh(mesh: Mesh)
//     rl.UnloadMaterial(material: Material)
//     rl.SetMaterialTexture(material: [*c]Material, 1, txt)
//     rl.SetModelMeshMaterial(model: [*c]Model, 1, 1)
//     rl.UpdateModelAnimation(model: Model, anim: ModelAnimation, 1)
//     rl.UnloadModelAnimation(anim: ModelAnimation)
//     rl.MeshTangents(mesh: [*c]Mesh)
//     rl.MeshBinormals(mesh: [*c]Mesh)
//     rl.DrawBoundingBox(box: BoundingBox, color)
//     rl.UnloadShader(shader: Shader)
//     rl.SetShapesTexture(txt, rect)
//     rl.SetShaderValue(shader: Shader, 1, value: ?*const c_void, 1)
//     rl.SetShaderValueV(shader: Shader, 1, value: ?*const c_void, 1, 1)
//     rl.SetShaderValueMatrix(shader: Shader, 1, mat: Matrix)
//     rl.SetShaderValueTexture(shader: Shader, 1, txt)
//     rl.SetMatrixProjection(proj: Matrix)
//     rl.SetMatrixModelview(view: Matrix)
//     rl.BeginShaderMode(shader: Shader)
//     rl.BeginBlendMode(1)
//     rl.UpdateVrTracking(camera: [*c]Camera)
//     rl.SetVrConfiguration(info: VrDeviceInfo, distortion: Shader)
//     rl.SetMasterVolume(1.0)
//     rl.UpdateSound(sound: Sound, data: ?*const c_void, 1)
//     rl.UnloadWave(wave: Wave)
//     rl.UnloadSound(sound: Sound)
//     rl.ExportWave(wave: Wave, string)
//     rl.ExportWaveAsCode(wave: Wave, string)
//     rl.PlaySound(sound: Sound)
//     rl.StopSound(sound: Sound)
//     rl.PauseSound(sound: Sound)
//     rl.ResumeSound(sound: Sound)
//     rl.PlaySoundMulti(sound: Sound)
//     rl.SetSoundVolume(sound: Sound, 1.0)
//     rl.SetSoundPitch(sound: Sound, 1.0)
//     rl.WaveFormat(wave: [*c]Wave, 1, 1, 1)
//     rl.WaveCrop(wave: [*c]Wave, 1, 1)
//     rl.UnloadMusicStream(music: Music)
//     rl.PlayMusicStream(music: Music)
//     rl.UpdateMusicStream(music: Music)
//     rl.StopMusicStream(music: Music)
//     rl.PauseMusicStream(music: Music)
//     rl.ResumeMusicStream(music: Music)
//     rl.SetMusicVolume(music: Music, 1.0)
//     rl.SetMusicPitch(music: Music, 1.0)
//     rl.SetMusicLoopCount(music: Music, 1)
//     rl.UpdateAudioStream(stream: AudioStream, data: ?*const c_void, 1)
//     rl.CloseAudioStream(stream: AudioStream)
//     rl.PlayAudioStream(stream: AudioStream)
//     rl.PauseAudioStream(stream: AudioStream)
//     rl.ResumeAudioStream(stream: AudioStream)
//     rl.StopAudioStream(stream: AudioStream)
//     rl.SetAudioStreamVolume(stream: AudioStream, 1.0)
//     rl.SetAudioStreamPitch(stream: AudioStream, 1.0)
//     rl.SetAudioStreamBufferSizeDefault(1)
//     rl.GuiState(1)
//     rl.GuiFont(font: Font)
//     rl.GuiFade(1.0)
//     rl.GuiSetStyle(1, 1, 1)
//     rl.GuiGroupBox(rect, string)
//     rl.GuiLine(rect, string)
//     rl.GuiPanel(rect)
//     rl.GuiLabel(rect, string)
//     rl.GuiStatusBar(rect, string)
//     rl.GuiDummyRec(rect, string)
//     rl.GuiLoadStyle(string)
//     rl.GuiLoadStyleProps(props: [*c]const c_int, 1)
//     rl.SetPhysicsTimeStep(delta: f64)
//     rl.SetPhysicsGravity(1.0, 1.0)
//     rl.PhysicsAddTorque(body: PhysicsBody, 1.0)
//     rl.SetPhysicsBodyRotation(body: PhysicsBody, 1.0)
//     rl.DestroyPhysicsBody(body: PhysicsBody)
//     rl.InitWindow(1, 1, string)
//     rl.SetWindowIcon(image)
//     rl.SetWindowTitle(string)
//     rl.SetWindowPosition(1, 1)
//     rl.SetWindowMonitor(1)
//     rl.SetWindowMinSize(1, 1)
//     rl.SetWindowSize(1, 1)
//     rl.SetClipboardText(string)
//     rl.ClearBackground(color)
//     rl.BeginMode2D(cam2)
//     rl.BeginMode3D(cam3)
//     rl.BeginTextureMode(rtext)
//     rl.BeginScissorMode(1, 1, 1, 1)
//     rl.SetTargetFPS(1)
//     rl.SetConfigFlags(1)
//     rl.SetTraceLogLevel(1)
//     rl.SetTraceLogExit(1)
//     rl.SetTraceLogCallback(tlc)
//     rl.TraceLog(1, string, ...)
//     rl.TakeScreenshot(string)
//     rl.StorageSaveValue(1, 1)
//     rl.OpenURL(string)
//     rl.SetExitKey(1)
//     rl.SetMousePosition(1, 1)
//     rl.SetMouseOffset(1, 1)
//     rl.SetMouseScale(1.0, 1.0)
//     rl.SetGesturesEnabled(1)
//     rl.SetCameraMode(cam3, 1)
//     rl.UpdateCamera(camera: [*c]Camera)
//     rl.SetCameraPanControl(1)
//     rl.SetCameraAltControl(1)
//     rl.SetCameraSmoothZoomControl(1)
//     rl.SetCameraMoveControls(1, 1, 1, 1, 1, 1)
//     rl.DrawPixel(1, 1, color)
//     rl.DrawLine(1, 1, 1, 1, color)
//     rl.DrawLineStrip(points: [*c]Vector2, 1, color)
//     rl.DrawCircle(1, 1, 1.0, color)
//     rl.DrawCircleGradient(1, 1, 1.0, color, color)
//     rl.DrawCircleLines(1, 1, 1.0, color)
//     rl.DrawEllipse(1, 1, 1.0, 1.0, color)
//     rl.DrawEllipseLines(1, 1, 1.0, 1.0, color)
//     rl.DrawRectangle(1, 1, 1, 1, color)
//     rl.DrawRectangleRec(rect, color)
//     rl.DrawRectangleGradientV(1, 1, 1, 1, color, color)
//     rl.DrawRectangleGradientH(1, 1, 1, 1, color, color)
//     rl.DrawRectangleGradientEx(rect, color, color, color, color)
//     rl.DrawRectangleLines(1, 1, 1, 1, color)
//     rl.DrawRectangleLinesEx(rect, 1, color)
//     rl.DrawRectangleRounded(rect, 1.0, 1, color)
//     rl.DrawRectangleRoundedLines(rect, 1.0, 1, 1, color)
//     rl.DrawTriangleFan(points: [*c]Vector2, 1, color)
//     rl.DrawTriangleStrip(points: [*c]Vector2, 1, color)
//     rl.ExportImage(image, string)
//     rl.ExportImageAsCode(image, string)
//     rl.UnloadImage(image)
//     rl.UnloadTexture(txt)
//     rl.UnloadRenderTexture(rtext)
//     rl.UpdateTexture(txt, pixels: ?*const c_void)
//     rl.ImageToPOT(image: [*c]Image, color)
//     rl.ImageFormat(image: [*c]Image, 1)
//     rl.ImageAlphaMask(image: [*c]Image, image)
//     rl.ImageAlphaClear(image: [*c]Image, color, 1.0)
//     rl.ImageAlphaCrop(image: [*c]Image, 1.0)
//     rl.ImageAlphaPremultiply(image: [*c]Image)
//     rl.ImageCrop(image: [*c]Image, rect)
//     rl.ImageResize(image: [*c]Image, 1, 1)
//     rl.ImageResizeNN(image: [*c]Image, 1, 1)
//     rl.ImageResizeCanvas(image: [*c]Image, 1, 1, 1, 1, color)
//     rl.ImageMipmaps(image: [*c]Image)
//     rl.ImageDither(image: [*c]Image, 1, 1, 1, 1)
//     rl.ImageDraw(dst: [*c]Image, image, rect, rect, color)
//     rl.ImageDrawRectangle(dst: [*c]Image, rect, color)
//     rl.ImageDrawRectangleLines(dst: [*c]Image, rect, 1, color)
//     rl.ImageFlipVertical(image: [*c]Image)
//     rl.ImageFlipHorizontal(image: [*c]Image)
//     rl.ImageRotateCW(image: [*c]Image)
//     rl.ImageRotateCCW(image: [*c]Image)
//     rl.ImageColorTint(image: [*c]Image, color)
//     rl.ImageColorInvert(image: [*c]Image)
//     rl.ImageColorGrayscale(image: [*c]Image)
//     rl.ImageColorContrast(image: [*c]Image, 1.0)
//     rl.ImageColorBrightness(image: [*c]Image, 1)
//     rl.ImageColorReplace(image: [*c]Image, color, color)
//     rl.GenTextureMipmaps(texture: [*c]Texture2D)
//     rl.SetTextureFilter(txt, 1)
//     rl.SetTextureWrap(txt, 1)
//     rl.DrawTexture(txt, 1, 1, color)
//     rl.UnloadFont(font: Font)
//     rl.DrawFPS(1, 1)
//     rl.DrawText(string, 1, 1, 1, color)
//     rl.DrawTextRec(font: Font, string, rect, 1.0, 1.0, wordWrap: bool, color)
//     rl.DrawTextRecEx(font: Font, string, rect, 1.0, 1.0, wordWrap: bool, color, 1, 1, color, color)
//     rl.TextAppend(text: [*c]u8, string, position: [*c]c_int)
//     rl.DrawRay(ray: Ray, color)
//     rl.DrawGrid(1, 1.0)
//     rl.UnloadModel(model: Model)
//     rl.ExportMesh(mesh: Mesh, string)
//     rl.UnloadMesh(mesh: Mesh)
//     rl.UnloadMaterial(material: Material)
//     rl.SetMaterialTexture(material: [*c]Material, 1, txt)
//     rl.SetModelMeshMaterial(model: [*c]Model, 1, 1)
//     rl.UpdateModelAnimation(model: Model, anim: ModelAnimation, 1)
//     rl.UnloadModelAnimation(anim: ModelAnimation)
//     rl.MeshTangents(mesh: [*c]Mesh)
//     rl.MeshBinormals(mesh: [*c]Mesh)
//     rl.DrawBoundingBox(box: BoundingBox, color)
//     rl.UnloadShader(shader: Shader)
//     rl.SetShapesTexture(txt, rect)
//     rl.SetShaderValue(shader: Shader, 1, value: ?*const c_void, 1)
//     rl.SetShaderValueV(shader: Shader, 1, value: ?*const c_void, 1, 1)
//     rl.SetShaderValueMatrix(shader: Shader, 1, mat: Matrix)
//     rl.SetShaderValueTexture(shader: Shader, 1, txt)
//     rl.SetMatrixProjection(proj: Matrix)
//     rl.SetMatrixModelview(view: Matrix)
//     rl.BeginShaderMode(shader: Shader)
//     rl.BeginBlendMode(1)
//     rl.UpdateVrTracking(camera: [*c]Camera)
//     rl.SetVrConfiguration(info: VrDeviceInfo, distortion: Shader)
//     rl.SetMasterVolume(1.0)
//     rl.UpdateSound(sound: Sound, data: ?*const c_void, 1)
//     rl.UnloadWave(wave: Wave)
//     rl.UnloadSound(sound: Sound)
//     rl.ExportWave(wave: Wave, string)
//     rl.ExportWaveAsCode(wave: Wave, string)
//     rl.PlaySound(sound: Sound)
//     rl.StopSound(sound: Sound)
//     rl.PauseSound(sound: Sound)
//     rl.ResumeSound(sound: Sound)
//     rl.PlaySoundMulti(sound: Sound)
//     rl.SetSoundVolume(sound: Sound, 1.0)
//     rl.SetSoundPitch(sound: Sound, 1.0)
//     rl.WaveFormat(wave: [*c]Wave, 1, 1, 1)
//     rl.WaveCrop(wave: [*c]Wave, 1, 1)
//     rl.UnloadMusicStream(music: Music)
//     rl.PlayMusicStream(music: Music)
//     rl.UpdateMusicStream(music: Music)
//     rl.StopMusicStream(music: Music)
//     rl.PauseMusicStream(music: Music)
//     rl.ResumeMusicStream(music: Music)
//     rl.SetMusicVolume(music: Music, 1.0)
//     rl.SetMusicPitch(music: Music, 1.0)
//     rl.SetMusicLoopCount(music: Music, 1)
//     rl.UpdateAudioStream(stream: AudioStream, data: ?*const c_void, 1)
//     rl.CloseAudioStream(stream: AudioStream)
//     rl.PlayAudioStream(stream: AudioStream)
//     rl.PauseAudioStream(stream: AudioStream)
//     rl.ResumeAudioStream(stream: AudioStream)
//     rl.StopAudioStream(stream: AudioStream)
//     rl.SetAudioStreamVolume(stream: AudioStream, 1.0)
//     rl.SetAudioStreamPitch(stream: AudioStream, 1.0)
//     rl.SetAudioStreamBufferSizeDefault(1)
//     rl.GuiState(1)
//     rl.GuiFont(font: Font)
//     rl.GuiFade(1.0)
//     rl.GuiSetStyle(1, 1, 1)
//     rl.GuiGroupBox(rect, string)
//     rl.GuiLine(rect, string)
//     rl.GuiPanel(rect)
//     rl.GuiLabel(rect, string)
//     rl.GuiStatusBar(rect, string)
//     rl.GuiDummyRec(rect, string)
//     rl.GuiLoadStyle(string)
//     rl.GuiLoadStyleProps(props: [*c]const c_int, 1)
//     rl.SetPhysicsTimeStep(delta: f64)
//     rl.SetPhysicsGravity(1.0, 1.0)
//     rl.PhysicsAddTorque(body: PhysicsBody, 1.0)
//     rl.SetPhysicsBodyRotation(body: PhysicsBody, 1.0)
//     rl.DestroyPhysicsBody(body: PhysicsBody)


//     rl.GetWindowHandle() ?*c_void;
//     rl.GetMonitorName(1) [*c]const u8;
//     rl.GetClipboardText() [*c]const u8;
//     rl.GetMouseRay(mousePosition: * const Vector2, cam3)  Ray;
//     rl.GetWorldToScreen(position: * const Vector3, cam3)  Vector2;
//     rl.GetWorldToScreenEx(position: * const Vector3, cam3, 1, 1)  Vector2;
//     rl.GetWorldToScreen2D(position: * const Vector2, cam2)  Vector2;
//     rl.GetScreenToWorld2D(position: * const Vector2, cam2)  Vector2;
//     rl.ColorFromNormalized(normalized: * const Vector4)  Color;
//     rl.ColorFromHSV(hsv: * const Vector3)  Color;
//     rl.GetExtension(string) [*c]const u8;
//     rl.GetFileName(string) [*c]const u8;
//     rl.GetFileNameWithoutExt(string) [*c]const u8;
//     rl.GetDirectoryPath(string) [*c]const u8;
//     rl.GetPrevDirectoryPath(string) [*c]const u8;
//     rl.GetWorkingDirectory() [*c]const u8;
//     rl.GetDirectoryFiles(string, count: [*c]c_int) [*c][*c]u8;
//     rl.GetDroppedFiles(count: [*c]c_int) [*c][*c]u8;
//     rl.CompressData(data: [*c]u8, 1, compDataLength: [*c]c_int) [*c]u8;
//     rl.DecompressData(compData: [*c]u8, 1, dataLength: [*c]c_int) [*c]u8;
//     rl.GetGamepadName(1) [*c]const u8;
//     rl.DrawPixelV(position: * const Vector2, color)  void;
//     rl.DrawLineV(startPos: * const Vector2, endPos: * const Vector2, color)  void;
//     rl.DrawLineEx(startPos: * const Vector2, endPos: * const Vector2, 1.0, color)  void;
//     rl.DrawLineBezier(startPos: * const Vector2, endPos: * const Vector2, 1.0, color)  void;
//     rl.DrawCircleSector(center: * const Vector2, 1.0, 1, 1, 1, color)  void;
//     rl.DrawCircleSectorLines(center: * const Vector2, 1.0, 1, 1, 1, color)  void;
//     rl.DrawCircleV(center: * const Vector2, 1.0, color)  void;
//     rl.DrawRing(center: * const Vector2, 1.0, 1.0, 1, 1, 1, color)  void;
//     rl.DrawRingLines(center: * const Vector2, 1.0, 1.0, 1, 1, 1, color)  void;
//     rl.DrawRectangleV(position: * const Vector2, size: * const Vector2, color)  void;
//     rl.DrawRectanglePro(rect, origin: * const Vector2, 1.0, color)  void;
//     rl.DrawTriangle(v1: * const Vector2, v2: * const Vector2, v3: * const Vector2, color)  void;
//     rl.DrawTriangleLines(v1: * const Vector2, v2: * const Vector2, v3: * const Vector2, color)  void;
//     rl.DrawPoly(center: * const Vector2, 1, 1.0, 1.0, color)  void;
//     rl.DrawPolyLines(center: * const Vector2, 1, 1.0, 1.0, color)  void;
//     rl.CheckCollisionCircles(center1: * const Vector2, radius1: f32, center2: * const Vector2, radius2: f32)  bool;
//     rl.CheckCollisionCircleRec(center: * const Vector2, 1.0, rect)  bool;
//     rl.CheckCollisionPointRec(point: * const Vector2, rect)  bool;
//     rl.CheckCollisionPointCircle(point: * const Vector2, center: * const Vector2, 1.0)  bool;
//     rl.CheckCollisionPointTriangle(point: * const Vector2, p1: * const Vector2, p2: * const Vector2, p3: * const Vector2)  bool;
//     rl.GetImageData(image) [*c]Color;
//     rl.GetImageDataNormalized(image) [*c]Vector4;
//     rl.ImageExtractPalette(image, 1, extractCount: [*c]c_int) [*c]Color;
//     rl.ImageDrawText(dst: [*c]Image, position: * const Vector2, string, 1, color)  void;
//     rl.ImageDrawTextEx(dst: [*c]Image, position: * const Vector2, font: Font, string, 1.0, 1.0, color)  void;
//     rl.DrawTextureV(txt, position: * const Vector2, color)  void;
//     rl.DrawTextureEx(txt, position: * const Vector2, 1.0, 1.0, color)  void;
//     rl.DrawTextureRec(txt, rect, position: * const Vector2, color)  void;
//     rl.DrawTextureQuad(txt, tiling: * const Vector2, offset: * const Vector2, rect, color)  void;
//     rl.DrawTexturePro(txt, rect, rect, origin: * const Vector2, 1.0, color)  void;
//     rl.DrawTextureNPatch(txt, nPatchInfo: NPatchInfo, rect, origin: * const Vector2, 1.0, color)  void;
//     rl.LoadFontData(string, 1, fontChars: [*c]c_int, 1, 1) [*c]CharInfo;
//     rl.DrawTextEx(font: Font, string, position: * const Vector2, 1.0, 1.0, color)  void;
//     rl.DrawTextCodepoint(font: Font, 1, position: * const Vector2, 1.0, color)  void;
//     rl.TextFormat(string, ...) [*c]const u8;
//     rl.TextSubtext(string, 1, 1) [*c]const u8;
//     rl.TextReplace(text: [*c]u8, string, string) [*c]u8;
//     rl.TextInsert(string, string, 1) [*c]u8;
//     rl.TextJoin(textList: [*c][*c]const u8, 1, string) [*c]const u8;
//     rl.TextSplit(string, delimiter: u8, count: [*c]c_int) [*c][*c]const u8;
//     rl.TextToUpper(string) [*c]const u8;
//     rl.TextToLower(string) [*c]const u8;
//     rl.TextToPascal(string) [*c]const u8;
//     rl.TextToUtf8(codepoints: [*c]c_int, 1) [*c]u8;
//     rl.GetCodepoints(string, count: [*c]c_int) [*c]c_int;
//     rl.CodepointToUtf8(1, byteLength: [*c]c_int) [*c]const u8;
//     rl.DrawLine3D(startPos: * const Vector3, endPos: * const Vector3, color)  void;
//     rl.DrawPoint3D(position: * const Vector3, color)  void;
//     rl.DrawCircle3D(center: * const Vector3, 1.0, rotationAxis: * const Vector3, 1.0, color)  void;
//     rl.DrawCube(position: * const Vector3, 1.0, 1.0, 1.0, color)  void;
//     rl.DrawCubeV(position: * const Vector3, size: * const Vector3, color)  void;
//     rl.DrawCubeWires(position: * const Vector3, 1.0, 1.0, 1.0, color)  void;
//     rl.DrawCubeWiresV(position: * const Vector3, size: * const Vector3, color)  void;
//     rl.DrawCubeTexture(txt, position: * const Vector3, 1.0, 1.0, 1.0, color)  void;
//     rl.DrawSphere(centerPos: * const Vector3, 1.0, color)  void;
//     rl.DrawSphereEx(centerPos: * const Vector3, 1.0, 1, 1, color)  void;
//     rl.DrawSphereWires(centerPos: * const Vector3, 1.0, 1, 1, color)  void;
//     rl.DrawCylinder(position: * const Vector3, 1.0, 1.0, 1.0, 1, color)  void;
//     rl.DrawCylinderWires(position: * const Vector3, 1.0, 1.0, 1.0, 1, color)  void;
//     rl.DrawPlane(centerPos: * const Vector3, size: * const Vector2, color)  void;
//     rl.DrawGizmo(position: * const Vector3)  void;
//     rl.LoadMeshes(string, meshCount: [*c]c_int) [*c]Mesh;
//     rl.LoadMaterials(string, materialCount: [*c]c_int) [*c]Material;
//     rl.LoadModelAnimations(string, animsCount: [*c]c_int) [*c]ModelAnimation;
//     rl.GenMeshHeightmap(image, size: * const Vector3)  Mesh;
//     rl.GenMeshCubicmap(image, cubeSize: * const Vector3)  Mesh;
//     rl.DrawModel(model: Model, position: * const Vector3, 1.0, color)  void;
//     rl.DrawModelEx(model: Model, position: * const Vector3, rotationAxis: * const Vector3, 1.0, scale: * const Vector3, color)  void;
//     rl.DrawModelWires(model: Model, position: * const Vector3, 1.0, color)  void;
//     rl.DrawModelWiresEx(model: Model, position: * const Vector3, rotationAxis: * const Vector3, 1.0, scale: * const Vector3, color)  void;
//     rl.DrawBillboard(cam3, txt, center: * const Vector3, 1.0, color)  void;
//     rl.DrawBillboardRec(cam3, txt, rect, center: * const Vector3, 1.0, color)  void;
//     rl.CheckCollisionSpheres(centerA: * const Vector3, 1.0, centerB: * const Vector3, 1.0)  bool;
//     rl.CheckCollisionBoxSphere(box: BoundingBox, center: * const Vector3, 1.0)  bool;
//     rl.CheckCollisionRaySphere(ray: Ray, center: * const Vector3, 1.0)  bool;
//     rl.CheckCollisionRaySphereEx(ray: Ray, center: * const Vector3, 1.0, collisionPoint: [*c]Vector3)  bool;
//     rl.GetCollisionRayTriangle(ray: Ray, p1: * const Vector3, p2: * const Vector3, p3: * const Vector3)  RayHitInfo;
//     rl.LoadText(string) [*c]u8;
//     rl.GetWaveData(wave: Wave) [*c]f32;
//     rl.GuiIconText(1, string) [*c]const u8;
//     rl.CreatePhysicsBodyCircle(pos: * const Vector2, 1.0, 1.0)  PhysicsBody;
//     rl.CreatePhysicsBodyRectangle(pos: * const Vector2, 1.0, 1.0, 1.0)  PhysicsBody;
//     rl.CreatePhysicsBodyPolygon(pos: * const Vector2, 1.0, 1, 1.0)  PhysicsBody;
//     rl.PhysicsAddForce(body: PhysicsBody, force: * const Vector2)  void;
//     rl.PhysicsShatter(body: PhysicsBody, position: * const Vector2, 1.0)  void;
//     rl.GetWindowHandle() ?*c_void;
//     rl.GetMonitorName(1) [*c]const u8;
//     rl.GetClipboardText() [*c]const u8;
//     rl.GetMouseRay(mousePosition: * const Vector2, cam3)  Ray;
//     rl.GetWorldToScreen(position: * const Vector3, cam3)  Vector2;
//     rl.GetWorldToScreenEx(position: * const Vector3, cam3, 1, 1)  Vector2;
//     rl.GetWorldToScreen2D(position: * const Vector2, cam2)  Vector2;
//     rl.GetScreenToWorld2D(position: * const Vector2, cam2)  Vector2;
//     rl.ColorFromNormalized(normalized: * const Vector4)  Color;
//     rl.ColorFromHSV(hsv: * const Vector3)  Color;
//     rl.GetExtension(string) [*c]const u8;
//     rl.GetFileName(string) [*c]const u8;
//     rl.GetFileNameWithoutExt(string) [*c]const u8;
//     rl.GetDirectoryPath(string) [*c]const u8;
//     rl.GetPrevDirectoryPath(string) [*c]const u8;
//     rl.GetWorkingDirectory() [*c]const u8;
//     rl.GetDirectoryFiles(string, count: [*c]c_int) [*c][*c]u8;
//     rl.GetDroppedFiles(count: [*c]c_int) [*c][*c]u8;
//     rl.CompressData(data: [*c]u8, 1, compDataLength: [*c]c_int) [*c]u8;
//     rl.DecompressData(compData: [*c]u8, 1, dataLength: [*c]c_int) [*c]u8;
//     rl.GetGamepadName(1) [*c]const u8;
//     rl.DrawPixelV(position: * const Vector2, color)  void;
//     rl.DrawLineV(startPos: * const Vector2, endPos: * const Vector2, color)  void;
//     rl.DrawLineEx(startPos: * const Vector2, endPos: * const Vector2, 1.0, color)  void;
//     rl.DrawLineBezier(startPos: * const Vector2, endPos: * const Vector2, 1.0, color)  void;
//     rl.DrawCircleSector(center: * const Vector2, 1.0, 1, 1, 1, color)  void;
//     rl.DrawCircleSectorLines(center: * const Vector2, 1.0, 1, 1, 1, color)  void;
//     rl.DrawRing(center: * const Vector2, 1.0, 1.0, 1, 1, 1, color)  void;
//     rl.DrawRingLines(center: * const Vector2, 1.0, 1.0, 1, 1, 1, color)  void;
//     rl.DrawRectangleV(position: * const Vector2, size: * const Vector2, color)  void;
//     rl.DrawRectanglePro(rect, origin: * const Vector2, 1.0, color)  void;
//     rl.DrawTriangle(v1: * const Vector2, v2: * const Vector2, v3: * const Vector2, color)  void;
//     rl.DrawTriangleLines(v1: * const Vector2, v2: * const Vector2, v3: * const Vector2, color)  void;
//     rl.DrawPoly(center: * const Vector2, 1, 1.0, 1.0, color)  void;
//     rl.DrawPolyLines(center: * const Vector2, 1, 1.0, 1.0, color)  void;
//     rl.CheckCollisionCircles(center1: * const Vector2, radius1: f32, center2: * const Vector2, radius2: f32)  bool;
//     rl.CheckCollisionCircleRec(center: * const Vector2, 1.0, rect)  bool;
//     rl.CheckCollisionPointRec(point: * const Vector2, rect)  bool;
//     rl.CheckCollisionPointCircle(point: * const Vector2, center: * const Vector2, 1.0)  bool;
//     rl.CheckCollisionPointTriangle(point: * const Vector2, p1: * const Vector2, p2: * const Vector2, p3: * const Vector2)  bool;
//     rl.GetImageData(image) [*c]Color;
//     rl.GetImageDataNormalized(image) [*c]Vector4;
//     rl.ImageExtractPalette(image, 1, extractCount: [*c]c_int) [*c]Color;
//     rl.ImageDrawText(dst: [*c]Image, position: * const Vector2, string, 1, color)  void;
//     rl.ImageDrawTextEx(dst: [*c]Image, position: * const Vector2, font: Font, string, 1.0, 1.0, color)  void;
//     rl.DrawTextureV(txt, position: * const Vector2, color)  void;
//     rl.DrawTextureEx(txt, position: * const Vector2, 1.0, 1.0, color)  void;
//     rl.DrawTextureRec(txt, rect, position: * const Vector2, color)  void;
//     rl.DrawTextureQuad(txt, tiling: * const Vector2, offset: * const Vector2, rect, color)  void;
//     rl.DrawTexturePro(txt, rect, rect, origin: * const Vector2, 1.0, color)  void;
//     rl.DrawTextureNPatch(txt, nPatchInfo: NPatchInfo, rect, origin: * const Vector2, 1.0, color)  void;
//     rl.LoadFontData(string, 1, fontChars: [*c]c_int, 1, 1) [*c]CharInfo;
//     rl.DrawTextEx(font: Font, string, position: * const Vector2, 1.0, 1.0, color)  void;
//     rl.DrawTextCodepoint(font: Font, 1, position: * const Vector2, 1.0, color)  void;
//     rl.TextFormat(string, ...) [*c]const u8;
//     rl.TextSubtext(string, 1, 1) [*c]const u8;
//     rl.TextReplace(text: [*c]u8, string, string) [*c]u8;
//     rl.TextInsert(string, string, 1) [*c]u8;
//     rl.TextJoin(textList: [*c][*c]const u8, 1, string) [*c]const u8;
//     rl.TextSplit(string, delimiter: u8, count: [*c]c_int) [*c][*c]const u8;
//     rl.TextToUpper(string) [*c]const u8;
//     rl.TextToLower(string) [*c]const u8;
//     rl.TextToPascal(string) [*c]const u8;
//     rl.TextToUtf8(codepoints: [*c]c_int, 1) [*c]u8;
//     rl.GetCodepoints(string, count: [*c]c_int) [*c]c_int;
//     rl.CodepointToUtf8(1, byteLength: [*c]c_int) [*c]const u8;
//     rl.DrawLine3D(startPos: * const Vector3, endPos: * const Vector3, color)  void;
//     rl.DrawPoint3D(position: * const Vector3, color)  void;
//     rl.DrawCircle3D(center: * const Vector3, 1.0, rotationAxis: * const Vector3, 1.0, color)  void;
//     rl.DrawCube(position: * const Vector3, 1.0, 1.0, 1.0, color)  void;
//     rl.DrawCubeV(position: * const Vector3, size: * const Vector3, color)  void;
//     rl.DrawCubeWires(position: * const Vector3, 1.0, 1.0, 1.0, color)  void;
//     rl.DrawCubeWiresV(position: * const Vector3, size: * const Vector3, color)  void;
//     rl.DrawCubeTexture(txt, position: * const Vector3, 1.0, 1.0, 1.0, color)  void;
//     rl.DrawSphere(centerPos: * const Vector3, 1.0, color)  void;
//     rl.DrawSphereEx(centerPos: * const Vector3, 1.0, 1, 1, color)  void;
//     rl.DrawSphereWires(centerPos: * const Vector3, 1.0, 1, 1, color)  void;
//     rl.DrawCylinder(position: * const Vector3, 1.0, 1.0, 1.0, 1, color)  void;
//     rl.DrawCylinderWires(position: * const Vector3, 1.0, 1.0, 1.0, 1, color)  void;
//     rl.DrawPlane(centerPos: * const Vector3, size: * const Vector2, color)  void;
//     rl.DrawGizmo(position: * const Vector3)  void;
//     rl.LoadMeshes(string, meshCount: [*c]c_int) [*c]Mesh;
//     rl.LoadMaterials(string, materialCount: [*c]c_int) [*c]Material;
//     rl.LoadModelAnimations(string, animsCount: [*c]c_int) [*c]ModelAnimation;
//     rl.GenMeshHeightmap(image, size: * const Vector3)  Mesh;
//     rl.GenMeshCubicmap(image, cubeSize: * const Vector3)  Mesh;
//     rl.DrawModel(model: Model, position: * const Vector3, 1.0, color)  void;
//     rl.DrawModelEx(model: Model, position: * const Vector3, rotationAxis: * const Vector3, 1.0, scale: * const Vector3, color)  void;
//     rl.DrawModelWires(model: Model, position: * const Vector3, 1.0, color)  void;
//     rl.DrawModelWiresEx(model: Model, position: * const Vector3, rotationAxis: * const Vector3, 1.0, scale: * const Vector3, color)  void;
//     rl.DrawBillboard(cam3, txt, center: * const Vector3, 1.0, color)  void;
//     rl.DrawBillboardRec(cam3, txt, rect, center: * const Vector3, 1.0, color)  void;
//     rl.CheckCollisionSpheres(centerA: * const Vector3, 1.0, centerB: * const Vector3, 1.0)  bool;
//     rl.CheckCollisionBoxSphere(box: BoundingBox, center: * const Vector3, 1.0)  bool;
//     rl.CheckCollisionRaySphere(ray: Ray, center: * const Vector3, 1.0)  bool;
//     rl.CheckCollisionRaySphereEx(ray: Ray, center: * const Vector3, 1.0, collisionPoint: [*c]Vector3)  bool;
//     rl.GetCollisionRayTriangle(ray: Ray, p1: * const Vector3, p2: * const Vector3, p3: * const Vector3)  RayHitInfo;
//     rl.LoadText(string) [*c]u8;
//     rl.GetWaveData(wave: Wave) [*c]f32;
//     rl.GuiIconText(1, string) [*c]const u8;
//     rl.CreatePhysicsBodyCircle(pos: * const Vector2, 1.0, 1.0)  PhysicsBody;
//     rl.CreatePhysicsBodyRectangle(pos: * const Vector2, 1.0, 1.0, 1.0)  PhysicsBody;
//     rl.CreatePhysicsBodyPolygon(pos: * const Vector2, 1.0, 1, 1.0)  PhysicsBody;
//     rl.PhysicsAddForce(body: PhysicsBody, force: * const Vector2)  void;
//     rl.PhysicsShatter(body: PhysicsBody, position: * const Vector2, 1.0)  void;
//     rl.GetScreenWidth() c_int;
//     rl.GetScreenHeight() c_int;
//     rl.GetMonitorCount() c_int;
//     rl.GetMonitorWidth(1) c_int;
//     rl.GetMonitorHeight(1) c_int;
//     rl.GetMonitorPhysicalWidth(1) c_int;
//     rl.GetMonitorPhysicalHeight(1) c_int;
//     rl.GetWindowPosition() Vector2;
//     rl.GetCameraMatrix(cam3) Matrix;
//     rl.GetCameraMatrix2D(cam2) Matrix;
//     rl.GetFPS() c_int;
//     rl.GetFrameTime() f32;
//     rl.GetTime() f64;
//     rl.ColorToInt(color) c_int;
//     rl.ColorNormalize(color) Vector4;
//     rl.ColorToHSV(color) Vector3;
//     rl.GetColor(1) Color;
//     rl.Fade(color, 1.0) Color;
//     rl.GetRandomValue(1, 1) c_int;
//     rl.GetFileModTime(string) c_long;
//     rl.StorageLoadValue(1) c_int;
//     rl.GetKeyPressed() c_int;
//     rl.GetGamepadButtonPressed() c_int;
//     rl.GetGamepadAxisCount(1) c_int;
//     rl.GetGamepadAxisMovement(1, 1) f32;
//     rl.GetMouseX() c_int;
//     rl.GetMouseY() c_int;
//     rl.GetMousePosition() Vector2;
//     rl.GetMouseWheelMove() c_int;
//     rl.GetTouchX() c_int;
//     rl.GetTouchY() c_int;
//     rl.GetTouchPosition(1) Vector2;
//     rl.GetGestureDetected() c_int;
//     rl.GetTouchPointsCount() c_int;
//     rl.GetGestureHoldDuration() f32;
//     rl.GetGestureDragVector() Vector2;
//     rl.GetGestureDragAngle() f32;
//     rl.GetGesturePinchVector() Vector2;
//     rl.GetGesturePinchAngle() f32;
//     rl.GetCollisionRec(rect, rect) Rectangle;
//     rl.LoadImage(string) Image;
//     rl.LoadImageEx(pixels: [*c]Color, 1, 1) Image;
//     rl.LoadImagePro(data: ?*c_void, 1, 1, 1) Image;
//     rl.LoadImageRaw(string, 1, 1, 1, 1) Image;
//     rl.LoadTexture(string) Texture2D;
//     rl.LoadTextureFromImage(image) Texture2D;
//     rl.LoadTextureCubemap(image, 1) TextureCubemap;
//     rl.LoadRenderTexture(1, 1) RenderTexture2D;
//     rl.GetImageAlphaBorder(image, 1.0) Rectangle;
//     rl.GetPixelDataSize(1, 1, 1) c_int;
//     rl.GetTextureData(txt) Image;
//     rl.GetScreenData() Image;
//     rl.ImageCopy(image) Image;
//     rl.ImageFromImage(image, rect) Image;
//     rl.ImageText(string, 1, color) Image;
//     rl.ImageTextEx(font: Font, string, 1.0, 1.0, color) Image;
//     rl.GenImageColor(1, 1, color) Image;
//     rl.GenImageGradientV(1, 1, color, color) Image;
//     rl.GenImageGradientH(1, 1, color, color) Image;
//     rl.GenImageGradientRadial(1, 1, 1.0, color, color) Image;
//     rl.GenImageChecked(1, 1, 1, 1, color, color) Image;
//     rl.GenImageWhiteNoise(1, 1, 1.0) Image;
//     rl.GenImagePerlinNoise(1, 1, 1, 1, 1.0) Image;
//     rl.GenImageCellular(1, 1, 1) Image;
//     rl.GetFontDefault() Font;
//     rl.LoadFont(string) Font;
//     rl.LoadFontEx(string, 1, fontChars: [*c]c_int, 1) Font;
//     rl.LoadFontFromImage(image, color, 1) Font;
//     rl.GenImageFontAtlas(chars: [*c]const CharInfo, recs: [*c][*c]Rectangle, 1, 1, 1, 1) Image;
//     rl.MeasureText(string, 1) c_int;
//     rl.MeasureTextEx(font: Font, string, 1.0, 1.0) Vector2;
//     rl.GetGlyphIndex(font: Font, 1) c_int;
//     rl.TextCopy(dst: [*c]u8, string) c_int;
//     rl.TextLength(string) c_uint;
//     rl.TextFindIndex(string, string) c_int;
//     rl.TextToInteger(string) c_int;
//     rl.GetCodepointsCount(string) c_int;
//     rl.GetNextCodepoint(string, bytesProcessed: [*c]c_int) c_int;
//     rl.LoadModel(string) Model;
//     rl.LoadModelFromMesh(mesh: Mesh) Model;
//     rl.LoadMaterialDefault() Material;
//     rl.GenMeshPoly(1, 1.0) Mesh;
//     rl.GenMeshPlane(1.0, 1.0, 1, 1) Mesh;
//     rl.GenMeshCube(1.0, 1.0, 1.0) Mesh;
//     rl.GenMeshSphere(1.0, 1, 1) Mesh;
//     rl.GenMeshHemiSphere(1.0, 1, 1) Mesh;
//     rl.GenMeshCylinder(1.0, 1.0, 1) Mesh;
//     rl.GenMeshTorus(1.0, 1.0, 1, 1) Mesh;
//     rl.GenMeshKnot(1.0, 1.0, 1, 1) Mesh;
//     rl.MeshBoundingBox(mesh: Mesh) BoundingBox;
//     rl.GetCollisionRayModel(ray: Ray, model: Model) RayHitInfo;
//     rl.GetCollisionRayGround(ray: Ray, 1.0) RayHitInfo;
//     rl.LoadShader(string, string) Shader;
//     rl.LoadShaderCode(string, string) Shader;
//     rl.GetShaderDefault() Shader;
//     rl.GetTextureDefault() Texture2D;
//     rl.GetShapesTexture() Texture2D;
//     rl.GetShapesTextureRec() Rectangle;
//     rl.GetShaderLocation(shader: Shader, string) c_int;
//     rl.GetMatrixModelview() Matrix;
//     rl.GetMatrixProjection() Matrix;
//     rl.GenTextureCubemap(shader: Shader, txt, 1) Texture2D;
//     rl.GenTextureIrradiance(shader: Shader, txt, 1) Texture2D;
//     rl.GenTexturePrefilter(shader: Shader, txt, 1) Texture2D;
//     rl.GenTextureBRDF(shader: Shader, 1) Texture2D;
//     rl.LoadWave(string) Wave;
//     rl.LoadSound(string) Sound;
//     rl.LoadSoundFromWave(wave: Wave) Sound;
//     rl.GetSoundsPlaying() c_int;
//     rl.WaveCopy(wave: Wave) Wave;
//     rl.LoadMusicStream(string) Music;
//     rl.GetMusicTimeLength(music: Music) f32;
//     rl.GetMusicTimePlayed(music: Music) f32;
//     rl.InitAudioStream(1, 1, 1) AudioStream;
//     rl.GuiGetStyle(1, 1) c_int;
//     rl.GuiScrollPanel(rect, rect, scroll: [*c]Vector2) Rectangle;
//     rl.GuiToggleGroup(rect, string, 1) c_int;
//     rl.GuiComboBox(rect, string, 1) c_int;
//     rl.GuiSlider(rect, string, 1.0, 1.0, 1.0, showValue: bool) f32;
//     rl.GuiSliderBar(rect, string, 1.0, 1.0, 1.0, showValue: bool) f32;
//     rl.GuiProgressBar(rect, string, 1.0, 1.0, 1.0, showValue: bool) f32;
//     rl.GuiScrollBar(rect, 1, 1, 1) c_int;
//     rl.GuiGrid(rect, 1.0, 1) Vector2;
//     rl.GuiMessageBox(rect, string, string, string) c_int;
//     rl.GuiTextInputBox(rect, string, string, text: [*c]u8, string) c_int;
//     rl.GuiColorPicker(rect, color) Color;
//     rl.GetPhysicsBodiesCount() c_int;
//     rl.GetPhysicsBody(1) PhysicsBody;
//     rl.GetPhysicsShapeType(1) c_int;
//     rl.GetPhysicsShapeVerticesCount(1) c_int;
//     rl.GetPhysicsShapeVertex(body: PhysicsBody, 1) Vector2;
//     rl.GetScreenWidth() c_int;
//     rl.GetScreenHeight() c_int;
//     rl.GetMonitorCount() c_int;
//     rl.GetMonitorWidth(1) c_int;
//     rl.GetMonitorHeight(1) c_int;
//     rl.GetMonitorPhysicalWidth(1) c_int;
//     rl.GetMonitorPhysicalHeight(1) c_int;
//     rl.GetWindowPosition() Vector2;
//     rl.GetCameraMatrix(cam3) Matrix;
//     rl.GetCameraMatrix2D(cam2) Matrix;
//     rl.GetFPS() c_int;
//     rl.GetFrameTime() f32;
//     rl.GetTime() f64;
//     rl.ColorToInt(color) c_int;
//     rl.ColorNormalize(color) Vector4;
//     rl.ColorToHSV(color) Vector3;
//     rl.GetColor(1) Color;
//     rl.Fade(color, 1.0) Color;
//     rl.GetRandomValue(1, 1) c_int;
//     rl.GetFileModTime(string) c_long;
//     rl.StorageLoadValue(1) c_int;
//     rl.GetKeyPressed() c_int;
//     rl.GetGamepadButtonPressed() c_int;
//     rl.GetGamepadAxisCount(1) c_int;
//     rl.GetGamepadAxisMovement(1, 1) f32;
//     rl.GetMouseX() c_int;
//     rl.GetMouseY() c_int;
//     rl.GetMousePosition() Vector2;
//     rl.GetMouseWheelMove() c_int;
//     rl.GetTouchX() c_int;
//     rl.GetTouchY() c_int;
//     rl.GetTouchPosition(1) Vector2;
//     rl.GetGestureDetected() c_int;
//     rl.GetTouchPointsCount() c_int;
//     rl.GetGestureHoldDuration() f32;
//     rl.GetGestureDragVector() Vector2;
//     rl.GetGestureDragAngle() f32;
//     rl.GetGesturePinchVector() Vector2;
//     rl.GetGesturePinchAngle() f32;
//     rl.GetCollisionRec(rect, rect) Rectangle;
//     rl.LoadImage(string) Image;
//     rl.LoadImageEx(pixels: [*c]Color, 1, 1) Image;
//     rl.LoadImagePro(data: ?*c_void, 1, 1, 1) Image;
//     rl.LoadImageRaw(string, 1, 1, 1, 1) Image;
//     rl.LoadTexture(string) Texture2D;
//     rl.LoadTextureFromImage(image) Texture2D;
//     rl.LoadTextureCubemap(image, 1) TextureCubemap;
//     rl.LoadRenderTexture(1, 1) RenderTexture2D;
//     rl.GetImageAlphaBorder(image, 1.0) Rectangle;
//     rl.GetPixelDataSize(1, 1, 1) c_int;
//     rl.GetTextureData(txt) Image;
//     rl.GetScreenData() Image;
//     rl.ImageCopy(image) Image;
//     rl.ImageFromImage(image, rect) Image;
//     rl.ImageText(string, 1, color) Image;
//     rl.ImageTextEx(font: Font, string, 1.0, 1.0, color) Image;
//     rl.GenImageColor(1, 1, color) Image;
//     rl.GenImageGradientV(1, 1, color, color) Image;
//     rl.GenImageGradientH(1, 1, color, color) Image;
//     rl.GenImageGradientRadial(1, 1, 1.0, color, color) Image;
//     rl.GenImageChecked(1, 1, 1, 1, color, color) Image;
//     rl.GenImageWhiteNoise(1, 1, 1.0) Image;
//     rl.GenImagePerlinNoise(1, 1, 1, 1, 1.0) Image;
//     rl.GenImageCellular(1, 1, 1) Image;
//     rl.GetFontDefault() Font;
//     rl.LoadFont(string) Font;
//     rl.LoadFontEx(string, 1, fontChars: [*c]c_int, 1) Font;
//     rl.LoadFontFromImage(image, color, 1) Font;
//     rl.GenImageFontAtlas(chars: [*c]const CharInfo, recs: [*c][*c]Rectangle, 1, 1, 1, 1) Image;
//     rl.MeasureText(string, 1) c_int;
//     rl.MeasureTextEx(font: Font, string, 1.0, 1.0) Vector2;
//     rl.GetGlyphIndex(font: Font, 1) c_int;
//     rl.TextCopy(dst: [*c]u8, string) c_int;
//     rl.TextLength(string) c_uint;
//     rl.TextFindIndex(string, string) c_int;
//     rl.TextToInteger(string) c_int;
//     rl.GetCodepointsCount(string) c_int;
//     rl.GetNextCodepoint(string, bytesProcessed: [*c]c_int) c_int;
//     rl.LoadModel(string) Model;
//     rl.LoadModelFromMesh(mesh: Mesh) Model;
//     rl.LoadMaterialDefault() Material;
//     rl.GenMeshPoly(1, 1.0) Mesh;
//     rl.GenMeshPlane(1.0, 1.0, 1, 1) Mesh;
//     rl.GenMeshCube(1.0, 1.0, 1.0) Mesh;
//     rl.GenMeshSphere(1.0, 1, 1) Mesh;
//     rl.GenMeshHemiSphere(1.0, 1, 1) Mesh;
//     rl.GenMeshCylinder(1.0, 1.0, 1) Mesh;
//     rl.GenMeshTorus(1.0, 1.0, 1, 1) Mesh;
//     rl.GenMeshKnot(1.0, 1.0, 1, 1) Mesh;
//     rl.MeshBoundingBox(mesh: Mesh) BoundingBox;
//     rl.GetCollisionRayModel(ray: Ray, model: Model) RayHitInfo;
//     rl.GetCollisionRayGround(ray: Ray, 1.0) RayHitInfo;
//     rl.LoadShader(string, string) Shader;
//     rl.LoadShaderCode(string, string) Shader;
//     rl.GetShaderDefault() Shader;
//     rl.GetTextureDefault() Texture2D;
//     rl.GetShapesTexture() Texture2D;
//     rl.GetShapesTextureRec() Rectangle;
//     rl.GetShaderLocation(shader: Shader, string) c_int;
//     rl.GetMatrixModelview() Matrix;
//     rl.GetMatrixProjection() Matrix;
//     rl.GenTextureCubemap(shader: Shader, txt, 1) Texture2D;
//     rl.GenTextureIrradiance(shader: Shader, txt, 1) Texture2D;
//     rl.GenTexturePrefilter(shader: Shader, txt, 1) Texture2D;
//     rl.GenTextureBRDF(shader: Shader, 1) Texture2D;
//     rl.LoadWave(string) Wave;
//     rl.LoadSound(string) Sound;
//     rl.LoadSoundFromWave(wave: Wave) Sound;
//     rl.GetSoundsPlaying() c_int;
//     rl.WaveCopy(wave: Wave) Wave;
//     rl.LoadMusicStream(string) Music;
//     rl.GetMusicTimeLength(music: Music) f32;
//     rl.GetMusicTimePlayed(music: Music) f32;
//     rl.InitAudioStream(1, 1, 1) AudioStream;
//     rl.GuiGetStyle(1, 1) c_int;
//     rl.GuiScrollPanel(rect, rect, scroll: [*c]Vector2) Rectangle;
//     rl.GuiToggleGroup(rect, string, 1) c_int;
//     rl.GuiComboBox(rect, string, 1) c_int;
//     rl.GuiSlider(rect, string, 1.0, 1.0, 1.0, showValue: bool) f32;
//     rl.GuiSliderBar(rect, string, 1.0, 1.0, 1.0, showValue: bool) f32;
//     rl.GuiProgressBar(rect, string, 1.0, 1.0, 1.0, showValue: bool) f32;
//     rl.GuiScrollBar(rect, 1, 1, 1) c_int;
//     rl.GuiGrid(rect, 1.0, 1) Vector2;
//     rl.GuiMessageBox(rect, string, string, string) c_int;
//     rl.GuiTextInputBox(rect, string, string, text: [*c]u8, string) c_int;
//     rl.GuiColorPicker(rect, color) Color;
//     rl.GetPhysicsBodiesCount() c_int;
//     rl.GetPhysicsBody(1) PhysicsBody;
//     rl.GetPhysicsShapeType(1) c_int;
//     rl.GetPhysicsShapeVerticesCount(1) c_int;
//     rl.GetPhysicsShapeVertex(body: PhysicsBody, 1) Vector2;
}

//     rl.TraceLog(1, string, ...)
