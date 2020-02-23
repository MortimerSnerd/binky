#include "raylib.h"
#include "physac.h"

Ray GetMouseRayShim(Vector2 const* mousePosition, Camera camera)
{
    return GetMouseRay(*mousePosition, camera);
}
Vector2 GetWorldToScreenShim(Vector3 const* position, Camera camera)
{
    return GetWorldToScreen(*position, camera);
}
Vector2 GetWorldToScreenExShim(Vector3 const* position, Camera camera, int width, int height)
{
    return GetWorldToScreenEx(*position, camera, width, height);
}
Vector2 GetWorldToScreen2DShim(Vector2 const* position, Camera2D camera)
{
    return GetWorldToScreen2D(*position, camera);
}
Vector2 GetScreenToWorld2DShim(Vector2 const* position, Camera2D camera)
{
    return GetScreenToWorld2D(*position, camera);
}
Color ColorFromNormalizedShim(Vector4 const* normalized)
{
    return ColorFromNormalized(*normalized);
}
Color ColorFromHSVShim(Vector3 const* hsv)
{
    return ColorFromHSV(*hsv);
}
void DrawPixelVShim(Vector2 const* position, Color color)
{
    DrawPixelV(*position, color);
}
void DrawLineVShim(Vector2 const* startPos, Vector2 const* endPos, Color color)
{
    DrawLineV(*startPos, *endPos, color);
}
void DrawLineExShim(Vector2 const* startPos, Vector2 const* endPos, float thick, Color color)
{
    DrawLineEx(*startPos, *endPos, thick, color);
}
void DrawLineBezierShim(Vector2 const* startPos, Vector2 const* endPos, float thick, Color color)
{
    DrawLineBezier(*startPos, *endPos, thick, color);
}
void DrawCircleSectorShim(Vector2 const* center, float radius, int startAngle, int endAngle, int segments, Color color)
{
    DrawCircleSector(*center, radius, startAngle, endAngle, segments, color);
}
void DrawCircleSectorLinesShim(Vector2 const* center, float radius, int startAngle, int endAngle, int segments, Color color)
{
    DrawCircleSectorLines(*center, radius, startAngle, endAngle, segments, color);
}
void DrawCircleVShim(Vector2 const* center, float radius, Color color)
{
    DrawCircleV(*center, radius, color);
}
void DrawRingShim(Vector2 const* center, float innerRadius, float outerRadius, int startAngle, int endAngle, int segments, Color color)
{
    DrawRing(*center, innerRadius, outerRadius, startAngle, endAngle, segments, color);
}
void DrawRingLinesShim(Vector2 const* center, float innerRadius, float outerRadius, int startAngle, int endAngle, int segments, Color color)
{
    DrawRingLines(*center, innerRadius, outerRadius, startAngle, endAngle, segments, color);
}
void DrawRectangleVShim(Vector2 const* position, Vector2 const* size, Color color)
{
    DrawRectangleV(*position, *size, color);
}
void DrawRectangleRecShim(Rectangle const* rec, Color color)
{
    DrawRectangleRec(*rec, color);
}
void DrawRectangleProShim(Rectangle const* rec, Vector2 const* origin, float rotation, Color color)
{
    DrawRectanglePro(*rec, *origin, rotation, color);
}
void DrawRectangleGradientExShim(Rectangle const* rec, Color col1, Color col2, Color col3, Color col4)
{
    DrawRectangleGradientEx(*rec, col1, col2, col3, col4);
}
void DrawRectangleLinesExShim(Rectangle const* rec, int lineThick, Color color)
{
    DrawRectangleLinesEx(*rec, lineThick, color);
}
void DrawRectangleRoundedShim(Rectangle const* rec, float roundness, int segments, Color color)
{
    DrawRectangleRounded(*rec, roundness, segments, color);
}
void DrawRectangleRoundedLinesShim(Rectangle const* rec, float roundness, int segments, int lineThick, Color color)
{
    DrawRectangleRoundedLines(*rec, roundness, segments, lineThick, color);
}
void DrawTriangleShim(Vector2 const* v1, Vector2 const* v2, Vector2 const* v3, Color color)
{
    DrawTriangle(*v1, *v2, *v3, color);
}
void DrawTriangleLinesShim(Vector2 const* v1, Vector2 const* v2, Vector2 const* v3, Color color)
{
    DrawTriangleLines(*v1, *v2, *v3, color);
}
void DrawPolyShim(Vector2 const* center, int sides, float radius, float rotation, Color color)
{
    DrawPoly(*center, sides, radius, rotation, color);
}
void DrawPolyLinesShim(Vector2 const* center, int sides, float radius, float rotation, Color color)
{
    DrawPolyLines(*center, sides, radius, rotation, color);
}
bool CheckCollisionRecsShim(Rectangle const* rec1, Rectangle const* rec2)
{
    return CheckCollisionRecs(*rec1, *rec2);
}
bool CheckCollisionCirclesShim(Vector2 const* center1, float radius1, Vector2 const* center2, float radius2)
{
    return CheckCollisionCircles(*center1, radius1, *center2, radius2);
}
bool CheckCollisionCircleRecShim(Vector2 const* center, float radius, Rectangle const* rec)
{
    return CheckCollisionCircleRec(*center, radius, *rec);
}
Rectangle GetCollisionRecShim(Rectangle const* rec1, Rectangle const* rec2)
{
    return GetCollisionRec(*rec1, *rec2);
}
bool CheckCollisionPointRecShim(Vector2 const* point, Rectangle const* rec)
{
    return CheckCollisionPointRec(*point, *rec);
}
bool CheckCollisionPointCircleShim(Vector2 const* point, Vector2 const* center, float radius)
{
    return CheckCollisionPointCircle(*point, *center, radius);
}
bool CheckCollisionPointTriangleShim(Vector2 const* point, Vector2 const* p1, Vector2 const* p2, Vector2 const* p3)
{
    return CheckCollisionPointTriangle(*point, *p1, *p2, *p3);
}
Image ImageFromImageShim(Image image, Rectangle const* rec)
{
    return ImageFromImage(image, *rec);
}
void ImageCropShim(Image* image, Rectangle const* crop)
{
    ImageCrop(image, *crop);
}
void ImageDrawShim(Image* dst, Image src, Rectangle const* srcRec, Rectangle const* dstRec, Color tint)
{
    ImageDraw(dst, src, *srcRec, *dstRec, tint);
}
void ImageDrawRectangleShim(Image* dst, Rectangle const* rec, Color color)
{
    ImageDrawRectangle(dst, *rec, color);
}
void ImageDrawRectangleLinesShim(Image* dst, Rectangle const* rec, int thick, Color color)
{
    ImageDrawRectangleLines(dst, *rec, thick, color);
}
void ImageDrawTextShim(Image* dst, Vector2 const* position, const char* text, int fontSize, Color color)
{
    ImageDrawText(dst, *position, text, fontSize, color);
}
void ImageDrawTextExShim(Image* dst, Vector2 const* position, Font font, const char* text, float fontSize, float spacing, Color color)
{
    ImageDrawTextEx(dst, *position, font, text, fontSize, spacing, color);
}
void DrawTextureVShim(Texture2D texture, Vector2 const* position, Color tint)
{
    DrawTextureV(texture, *position, tint);
}
void DrawTextureExShim(Texture2D texture, Vector2 const* position, float rotation, float scale, Color tint)
{
    DrawTextureEx(texture, *position, rotation, scale, tint);
}
void DrawTextureRecShim(Texture2D texture, Rectangle const* sourceRec, Vector2 const* position, Color tint)
{
    DrawTextureRec(texture, *sourceRec, *position, tint);
}
void DrawTextureQuadShim(Texture2D texture, Vector2 const* tiling, Vector2 const* offset, Rectangle const* quad, Color tint)
{
    DrawTextureQuad(texture, *tiling, *offset, *quad, tint);
}
void DrawTextureProShim(Texture2D texture, Rectangle const* sourceRec, Rectangle const* destRec, Vector2 const* origin, float rotation, Color tint)
{
    DrawTexturePro(texture, *sourceRec, *destRec, *origin, rotation, tint);
}
void DrawTextureNPatchShim(Texture2D texture, NPatchInfo nPatchInfo, Rectangle const* destRec, Vector2 const* origin, float rotation, Color tint)
{
    DrawTextureNPatch(texture, nPatchInfo, *destRec, *origin, rotation, tint);
}
void DrawTextExShim(Font font, const char* text, Vector2 const* position, float fontSize, float spacing, Color tint)
{
    DrawTextEx(font, text, *position, fontSize, spacing, tint);
}
void DrawTextRecShim(Font font, const char* text, Rectangle const* rec, float fontSize, float spacing, bool wordWrap, Color tint)
{
    DrawTextRec(font, text, *rec, fontSize, spacing, wordWrap, tint);
}
void DrawTextRecExShim(Font font, const char* text, Rectangle const* rec, float fontSize, float spacing, bool wordWrap, Color tint, int selectStart, int selectLength, Color selectTint, Color selectBackTint)
{
    DrawTextRecEx(font, text, *rec, fontSize, spacing, wordWrap, tint, selectStart, selectLength, selectTint, selectBackTint);
}
void DrawTextCodepointShim(Font font, int codepoint, Vector2 const* position, float scale, Color tint)
{
    DrawTextCodepoint(font, codepoint, *position, scale, tint);
}
void DrawLine3DShim(Vector3 const* startPos, Vector3 const* endPos, Color color)
{
    DrawLine3D(*startPos, *endPos, color);
}
void DrawPoint3DShim(Vector3 const* position, Color color)
{
    DrawPoint3D(*position, color);
}
void DrawCircle3DShim(Vector3 const* center, float radius, Vector3 const* rotationAxis, float rotationAngle, Color color)
{
    DrawCircle3D(*center, radius, *rotationAxis, rotationAngle, color);
}
void DrawCubeShim(Vector3 const* position, float width, float height, float length, Color color)
{
    DrawCube(*position, width, height, length, color);
}
void DrawCubeVShim(Vector3 const* position, Vector3 const* size, Color color)
{
    DrawCubeV(*position, *size, color);
}
void DrawCubeWiresShim(Vector3 const* position, float width, float height, float length, Color color)
{
    DrawCubeWires(*position, width, height, length, color);
}
void DrawCubeWiresVShim(Vector3 const* position, Vector3 const* size, Color color)
{
    DrawCubeWiresV(*position, *size, color);
}
void DrawCubeTextureShim(Texture2D texture, Vector3 const* position, float width, float height, float length, Color color)
{
    DrawCubeTexture(texture, *position, width, height, length, color);
}
void DrawSphereShim(Vector3 const* centerPos, float radius, Color color)
{
    DrawSphere(*centerPos, radius, color);
}
void DrawSphereExShim(Vector3 const* centerPos, float radius, int rings, int slices, Color color)
{
    DrawSphereEx(*centerPos, radius, rings, slices, color);
}
void DrawSphereWiresShim(Vector3 const* centerPos, float radius, int rings, int slices, Color color)
{
    DrawSphereWires(*centerPos, radius, rings, slices, color);
}
void DrawCylinderShim(Vector3 const* position, float radiusTop, float radiusBottom, float height, int slices, Color color)
{
    DrawCylinder(*position, radiusTop, radiusBottom, height, slices, color);
}
void DrawCylinderWiresShim(Vector3 const* position, float radiusTop, float radiusBottom, float height, int slices, Color color)
{
    DrawCylinderWires(*position, radiusTop, radiusBottom, height, slices, color);
}
void DrawPlaneShim(Vector3 const* centerPos, Vector2 const* size, Color color)
{
    DrawPlane(*centerPos, *size, color);
}
void DrawGizmoShim(Vector3 const* position)
{
    DrawGizmo(*position);
}
Mesh GenMeshHeightmapShim(Image heightmap, Vector3 const* size)
{
    return GenMeshHeightmap(heightmap, *size);
}
Mesh GenMeshCubicmapShim(Image cubicmap, Vector3 const* cubeSize)
{
    return GenMeshCubicmap(cubicmap, *cubeSize);
}
void DrawModelShim(Model model, Vector3 const* position, float scale, Color tint)
{
    DrawModel(model, *position, scale, tint);
}
void DrawModelExShim(Model model, Vector3 const* position, Vector3 const* rotationAxis, float rotationAngle, Vector3 const* scale, Color tint)
{
    DrawModelEx(model, *position, *rotationAxis, rotationAngle, *scale, tint);
}
void DrawModelWiresShim(Model model, Vector3 const* position, float scale, Color tint)
{
    DrawModelWires(model, *position, scale, tint);
}
void DrawModelWiresExShim(Model model, Vector3 const* position, Vector3 const* rotationAxis, float rotationAngle, Vector3 const* scale, Color tint)
{
    DrawModelWiresEx(model, *position, *rotationAxis, rotationAngle, *scale, tint);
}
void DrawBillboardShim(Camera camera, Texture2D texture, Vector3 const* center, float size, Color tint)
{
    DrawBillboard(camera, texture, *center, size, tint);
}
void DrawBillboardRecShim(Camera camera, Texture2D texture, Rectangle const* sourceRec, Vector3 const* center, float size, Color tint)
{
    DrawBillboardRec(camera, texture, *sourceRec, *center, size, tint);
}
bool CheckCollisionSpheresShim(Vector3 const* centerA, float radiusA, Vector3 const* centerB, float radiusB)
{
    return CheckCollisionSpheres(*centerA, radiusA, *centerB, radiusB);
}
bool CheckCollisionBoxSphereShim(BoundingBox box, Vector3 const* center, float radius)
{
    return CheckCollisionBoxSphere(box, *center, radius);
}
bool CheckCollisionRaySphereShim(Ray ray, Vector3 const* center, float radius)
{
    return CheckCollisionRaySphere(ray, *center, radius);
}
bool CheckCollisionRaySphereExShim(Ray ray, Vector3 const* center, float radius, Vector3* collisionPoint)
{
    return CheckCollisionRaySphereEx(ray, *center, radius, collisionPoint);
}
RayHitInfo GetCollisionRayTriangleShim(Ray ray, Vector3 const* p1, Vector3 const* p2, Vector3 const* p3)
{
    return GetCollisionRayTriangle(ray, *p1, *p2, *p3);
}
void SetShapesTextureShim(Texture2D texture, Rectangle const* source)
{
    SetShapesTexture(texture, *source);
}
bool GuiWindowBoxShim(Rectangle const* bounds, const char* text)
{
    return GuiWindowBox(*bounds, text);
}
void GuiGroupBoxShim(Rectangle const* bounds, const char* text)
{
    GuiGroupBox(*bounds, text);
}
void GuiLineShim(Rectangle const* bounds, const char* text)
{
    GuiLine(*bounds, text);
}
void GuiPanelShim(Rectangle const* bounds)
{
    GuiPanel(*bounds);
}
Rectangle GuiScrollPanelShim(Rectangle const* bounds, Rectangle const* content, Vector2* scroll)
{
    return GuiScrollPanel(*bounds, *content, scroll);
}
void GuiLabelShim(Rectangle const* bounds, const char* text)
{
    GuiLabel(*bounds, text);
}
bool GuiButtonShim(Rectangle const* bounds, const char* text)
{
    return GuiButton(*bounds, text);
}
bool GuiLabelButtonShim(Rectangle const* bounds, const char* text)
{
    return GuiLabelButton(*bounds, text);
}
bool GuiImageButtonShim(Rectangle const* bounds, Texture2D texture)
{
    return GuiImageButton(*bounds, texture);
}
bool GuiImageButtonExShim(Rectangle const* bounds, Texture2D texture, Rectangle const* texSource, const char* text)
{
    return GuiImageButtonEx(*bounds, texture, *texSource, text);
}
bool GuiToggleShim(Rectangle const* bounds, const char* text, bool active)
{
    return GuiToggle(*bounds, text, active);
}
int GuiToggleGroupShim(Rectangle const* bounds, const char* text, int active)
{
    return GuiToggleGroup(*bounds, text, active);
}
bool GuiCheckBoxShim(Rectangle const* bounds, const char* text, bool checked)
{
    return GuiCheckBox(*bounds, text, checked);
}
int GuiComboBoxShim(Rectangle const* bounds, const char* text, int active)
{
    return GuiComboBox(*bounds, text, active);
}
bool GuiDropdownBoxShim(Rectangle const* bounds, const char* text, int* active, bool editMode)
{
    return GuiDropdownBox(*bounds, text, active, editMode);
}
bool GuiSpinnerShim(Rectangle const* bounds, int* value, int minValue, int maxValue, bool editMode)
{
    return GuiSpinner(*bounds, value, minValue, maxValue, editMode);
}
bool GuiValueBoxShim(Rectangle const* bounds, int* value, int minValue, int maxValue, bool editMode)
{
    return GuiValueBox(*bounds, value, minValue, maxValue, editMode);
}
bool GuiTextBoxShim(Rectangle const* bounds, char* text, int textSize, bool editMode)
{
    return GuiTextBox(*bounds, text, textSize, editMode);
}
bool GuiTextBoxMultiShim(Rectangle const* bounds, char* text, int textSize, bool editMode)
{
    return GuiTextBoxMulti(*bounds, text, textSize, editMode);
}
float GuiSliderShim(Rectangle const* bounds, const char* text, float value, float minValue, float maxValue, bool showValue)
{
    return GuiSlider(*bounds, text, value, minValue, maxValue, showValue);
}
float GuiSliderBarShim(Rectangle const* bounds, const char* text, float value, float minValue, float maxValue, bool showValue)
{
    return GuiSliderBar(*bounds, text, value, minValue, maxValue, showValue);
}
float GuiProgressBarShim(Rectangle const* bounds, const char* text, float value, float minValue, float maxValue, bool showValue)
{
    return GuiProgressBar(*bounds, text, value, minValue, maxValue, showValue);
}
void GuiStatusBarShim(Rectangle const* bounds, const char* text)
{
    GuiStatusBar(*bounds, text);
}
void GuiDummyRecShim(Rectangle const* bounds, const char* text)
{
    GuiDummyRec(*bounds, text);
}
int GuiScrollBarShim(Rectangle const* bounds, int value, int minValue, int maxValue)
{
    return GuiScrollBar(*bounds, value, minValue, maxValue);
}
Vector2 GuiGridShim(Rectangle const* bounds, float spacing, int subdivs)
{
    return GuiGrid(*bounds, spacing, subdivs);
}
bool GuiListViewShim(Rectangle const* bounds, const char* text, int* active, int* scrollIndex, bool editMode)
{
    return GuiListView(*bounds, text, active, scrollIndex, editMode);
}
bool GuiListViewExShim(Rectangle const* bounds, const char** text, int count, int* enabled, int* active, int* focus, int* scrollIndex, bool editMode)
{
    return GuiListViewEx(*bounds, text, count, enabled, active, focus, scrollIndex, editMode);
}
int GuiMessageBoxShim(Rectangle const* bounds, const char* windowTitle, const char* message, const char* buttons)
{
    return GuiMessageBox(*bounds, windowTitle, message, buttons);
}
int GuiTextInputBoxShim(Rectangle const* bounds, const char* windowTitle, const char* message, char* text, const char* buttons)
{
    return GuiTextInputBox(*bounds, windowTitle, message, text, buttons);
}
Color GuiColorPickerShim(Rectangle const* bounds, Color color)
{
    return GuiColorPicker(*bounds, color);
}
PhysicsBody CreatePhysicsBodyCircleShim(Vector2 const* pos, float radius, float density)
{
    return CreatePhysicsBodyCircle(*pos, radius, density);
}
PhysicsBody CreatePhysicsBodyRectangleShim(Vector2 const* pos, float width, float height, float density)
{
    return CreatePhysicsBodyRectangle(*pos, width, height, density);
}
PhysicsBody CreatePhysicsBodyPolygonShim(Vector2 const* pos, float radius, int sides, float density)
{
    return CreatePhysicsBodyPolygon(*pos, radius, sides, density);
}
void PhysicsAddForceShim(PhysicsBody body, Vector2 const* force)
{
    PhysicsAddForce(body, *force);
}
void PhysicsShatterShim(PhysicsBody body, Vector2 const* position, float force)
{
    PhysicsShatter(body, *position, force);
}
