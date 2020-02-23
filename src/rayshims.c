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
void DrawRectangleProShim(Rectangle rec, Vector2 const* origin, float rotation, Color color)
{
    DrawRectanglePro(rec, *origin, rotation, color);
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
bool CheckCollisionCirclesShim(Vector2 const* center1, float radius1, Vector2 const* center2, float radius2)
{
    return CheckCollisionCircles(*center1, radius1, *center2, radius2);
}
bool CheckCollisionCircleRecShim(Vector2 const* center, float radius, Rectangle rec)
{
    return CheckCollisionCircleRec(*center, radius, rec);
}
bool CheckCollisionPointRecShim(Vector2 const* point, Rectangle rec)
{
    return CheckCollisionPointRec(*point, rec);
}
bool CheckCollisionPointCircleShim(Vector2 const* point, Vector2 const* center, float radius)
{
    return CheckCollisionPointCircle(*point, *center, radius);
}
bool CheckCollisionPointTriangleShim(Vector2 const* point, Vector2 const* p1, Vector2 const* p2, Vector2 const* p3)
{
    return CheckCollisionPointTriangle(*point, *p1, *p2, *p3);
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
void DrawTextureRecShim(Texture2D texture, Rectangle sourceRec, Vector2 const* position, Color tint)
{
    DrawTextureRec(texture, sourceRec, *position, tint);
}
void DrawTextureQuadShim(Texture2D texture, Vector2 const* tiling, Vector2 const* offset, Rectangle quad, Color tint)
{
    DrawTextureQuad(texture, *tiling, *offset, quad, tint);
}
void DrawTextureProShim(Texture2D texture, Rectangle sourceRec, Rectangle destRec, Vector2 const* origin, float rotation, Color tint)
{
    DrawTexturePro(texture, sourceRec, destRec, *origin, rotation, tint);
}
void DrawTextureNPatchShim(Texture2D texture, NPatchInfo nPatchInfo, Rectangle destRec, Vector2 const* origin, float rotation, Color tint)
{
    DrawTextureNPatch(texture, nPatchInfo, destRec, *origin, rotation, tint);
}
void DrawTextExShim(Font font, const char* text, Vector2 const* position, float fontSize, float spacing, Color tint)
{
    DrawTextEx(font, text, *position, fontSize, spacing, tint);
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
void DrawBillboardRecShim(Camera camera, Texture2D texture, Rectangle sourceRec, Vector3 const* center, float size, Color tint)
{
    DrawBillboardRec(camera, texture, sourceRec, *center, size, tint);
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
