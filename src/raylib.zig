pub const va_list = __builtin_va_list;
pub const struct_Vector2 = extern struct {
    x: f32,
    y: f32,
};
pub const Vector2 = struct_Vector2;
pub const struct_Vector3 = extern struct {
    x: f32,
    y: f32,
    z: f32,
};
pub const Vector3 = struct_Vector3;
pub const struct_Vector4 = extern struct {
    x: f32,
    y: f32,
    z: f32,
    w: f32,
};
pub const Vector4 = struct_Vector4;
pub const Quaternion = Vector4;
pub const struct_Matrix = extern struct {
    m0: f32,
    m4: f32,
    m8: f32,
    m12: f32,
    m1: f32,
    m5: f32,
    m9: f32,
    m13: f32,
    m2: f32,
    m6: f32,
    m10: f32,
    m14: f32,
    m3: f32,
    m7: f32,
    m11: f32,
    m15: f32,
};
pub const Matrix = struct_Matrix;
pub const struct_Color = extern struct {
    r: u8,
    g: u8,
    b: u8,
    a: u8,
};
pub const Color = struct_Color;
pub const struct_Rectangle = extern struct {
    x: f32,
    y: f32,
    width: f32,
    height: f32,
};
pub const Rectangle = struct_Rectangle;
pub const struct_Image = extern struct {
    data: ?*c_void,
    width: c_int,
    height: c_int,
    mipmaps: c_int,
    format: c_int,
};
pub const Image = struct_Image;
pub const struct_Texture2D = extern struct {
    id: c_uint,
    width: c_int,
    height: c_int,
    mipmaps: c_int,
    format: c_int,
};
pub const Texture2D = struct_Texture2D;
pub const Texture = Texture2D;
pub const TextureCubemap = Texture2D;
pub const struct_RenderTexture2D = extern struct {
    id: c_uint,
    texture: Texture2D,
    depth: Texture2D,
    depthTexture: bool,
};
pub const RenderTexture2D = struct_RenderTexture2D;
pub const RenderTexture = RenderTexture2D;
pub const struct_NPatchInfo = extern struct {
    sourceRec: Rectangle,
    left: c_int,
    top: c_int,
    right: c_int,
    bottom: c_int,
    type: c_int,
};
pub const NPatchInfo = struct_NPatchInfo;
pub const struct_CharInfo = extern struct {
    value: c_int,
    offsetX: c_int,
    offsetY: c_int,
    advanceX: c_int,
    image: Image,
};
pub const CharInfo = struct_CharInfo;
pub const struct_Font = extern struct {
    baseSize: c_int,
    charsCount: c_int,
    texture: Texture2D,
    recs: [*c]Rectangle,
    chars: [*c]CharInfo,
};
pub const Font = struct_Font;
pub const struct_Camera3D = extern struct {
    position: Vector3,
    target: Vector3,
    up: Vector3,
    fovy: f32,
    type: c_int,
};
pub const Camera3D = struct_Camera3D;
pub const Camera = Camera3D;
pub const struct_Camera2D = extern struct {
    offset: Vector2,
    target: Vector2,
    rotation: f32,
    zoom: f32,
};
pub const Camera2D = struct_Camera2D;
pub const struct_Mesh = extern struct {
    vertexCount: c_int,
    triangleCount: c_int,
    vertices: [*c]f32,
    texcoords: [*c]f32,
    texcoords2: [*c]f32,
    normals: [*c]f32,
    tangents: [*c]f32,
    colors: [*c]u8,
    indices: [*c]c_ushort,
    animVertices: [*c]f32,
    animNormals: [*c]f32,
    boneIds: [*c]c_int,
    boneWeights: [*c]f32,
    vaoId: c_uint,
    vboId: [*c]c_uint,
};
pub const Mesh = struct_Mesh;
pub const struct_Shader = extern struct {
    id: c_uint,
    locs: [*c]c_int,
};
pub const Shader = struct_Shader;
pub const struct_MaterialMap = extern struct {
    texture: Texture2D,
    color: Color,
    value: f32,
};
pub const MaterialMap = struct_MaterialMap;
pub const struct_Material = extern struct {
    shader: Shader,
    maps: [*c]MaterialMap,
    params: [*c]f32,
};
pub const Material = struct_Material;
pub const struct_Transform = extern struct {
    translation: Vector3,
    rotation: Quaternion,
    scale: Vector3,
};
pub const Transform = struct_Transform;
pub const struct_BoneInfo = extern struct {
    name: [32]u8,
    parent: c_int,
};
pub const BoneInfo = struct_BoneInfo;
pub const struct_Model = extern struct {
    transform: Matrix,
    meshCount: c_int,
    meshes: [*c]Mesh,
    materialCount: c_int,
    materials: [*c]Material,
    meshMaterial: [*c]c_int,
    boneCount: c_int,
    bones: [*c]BoneInfo,
    bindPose: [*c]Transform,
};
pub const Model = struct_Model;
pub const struct_ModelAnimation = extern struct {
    boneCount: c_int,
    bones: [*c]BoneInfo,
    frameCount: c_int,
    framePoses: [*c][*c]Transform,
};
pub const ModelAnimation = struct_ModelAnimation;
pub const struct_Ray = extern struct {
    position: Vector3,
    direction: Vector3,
};
pub const Ray = struct_Ray;
pub const struct_RayHitInfo = extern struct {
    hit: bool,
    distance: f32,
    position: Vector3,
    normal: Vector3,
};
pub const RayHitInfo = struct_RayHitInfo;
pub const struct_BoundingBox = extern struct {
    min: Vector3,
    max: Vector3,
};
pub const BoundingBox = struct_BoundingBox;
pub const struct_Wave = extern struct {
    sampleCount: c_uint,
    sampleRate: c_uint,
    sampleSize: c_uint,
    channels: c_uint,
    data: ?*c_void,
};
pub const Wave = struct_Wave;
pub const struct_rAudioBuffer = @OpaqueType();
pub const rAudioBuffer = struct_rAudioBuffer;
pub const struct_AudioStream = extern struct {
    sampleRate: c_uint,
    sampleSize: c_uint,
    channels: c_uint,
    buffer: ?*rAudioBuffer,
};
pub const AudioStream = struct_AudioStream;
pub const struct_Sound = extern struct {
    sampleCount: c_uint,
    stream: AudioStream,
};
pub const Sound = struct_Sound;
pub const struct_Music = extern struct {
    ctxType: c_int,
    ctxData: ?*c_void,
    sampleCount: c_uint,
    loopCount: c_uint,
    stream: AudioStream,
};
pub const Music = struct_Music;
pub const struct_VrDeviceInfo = extern struct {
    hResolution: c_int,
    vResolution: c_int,
    hScreenSize: f32,
    vScreenSize: f32,
    vScreenCenter: f32,
    eyeToScreenDistance: f32,
    lensSeparationDistance: f32,
    interpupillaryDistance: f32,
    lensDistortionValues: [4]f32,
    chromaAbCorrection: [4]f32,
};
pub const VrDeviceInfo = struct_VrDeviceInfo;
pub const FLAG_RESERVED = @enumToInt(enum_unnamed_1.FLAG_RESERVED);
pub const FLAG_FULLSCREEN_MODE = @enumToInt(enum_unnamed_1.FLAG_FULLSCREEN_MODE);
pub const FLAG_WINDOW_RESIZABLE = @enumToInt(enum_unnamed_1.FLAG_WINDOW_RESIZABLE);
pub const FLAG_WINDOW_UNDECORATED = @enumToInt(enum_unnamed_1.FLAG_WINDOW_UNDECORATED);
pub const FLAG_WINDOW_TRANSPARENT = @enumToInt(enum_unnamed_1.FLAG_WINDOW_TRANSPARENT);
pub const FLAG_WINDOW_HIDDEN = @enumToInt(enum_unnamed_1.FLAG_WINDOW_HIDDEN);
pub const FLAG_WINDOW_ALWAYS_RUN = @enumToInt(enum_unnamed_1.FLAG_WINDOW_ALWAYS_RUN);
pub const FLAG_MSAA_4X_HINT = @enumToInt(enum_unnamed_1.FLAG_MSAA_4X_HINT);
pub const FLAG_VSYNC_HINT = @enumToInt(enum_unnamed_1.FLAG_VSYNC_HINT);
const enum_unnamed_1 = extern enum(c_int) {
    FLAG_RESERVED = 1,
    FLAG_FULLSCREEN_MODE = 2,
    FLAG_WINDOW_RESIZABLE = 4,
    FLAG_WINDOW_UNDECORATED = 8,
    FLAG_WINDOW_TRANSPARENT = 16,
    FLAG_WINDOW_HIDDEN = 128,
    FLAG_WINDOW_ALWAYS_RUN = 256,
    FLAG_MSAA_4X_HINT = 32,
    FLAG_VSYNC_HINT = 64,
    _,
};
pub const ConfigFlag = enum_unnamed_1;
pub const LOG_ALL = @enumToInt(enum_unnamed_2.LOG_ALL);
pub const LOG_TRACE = @enumToInt(enum_unnamed_2.LOG_TRACE);
pub const LOG_DEBUG = @enumToInt(enum_unnamed_2.LOG_DEBUG);
pub const LOG_INFO = @enumToInt(enum_unnamed_2.LOG_INFO);
pub const LOG_WARNING = @enumToInt(enum_unnamed_2.LOG_WARNING);
pub const LOG_ERROR = @enumToInt(enum_unnamed_2.LOG_ERROR);
pub const LOG_FATAL = @enumToInt(enum_unnamed_2.LOG_FATAL);
pub const LOG_NONE = @enumToInt(enum_unnamed_2.LOG_NONE);
const enum_unnamed_2 = extern enum(c_int) {
    LOG_ALL = 0,
    LOG_TRACE = 1,
    LOG_DEBUG = 2,
    LOG_INFO = 3,
    LOG_WARNING = 4,
    LOG_ERROR = 5,
    LOG_FATAL = 6,
    LOG_NONE = 7,
    _,
};
pub const TraceLogType = enum_unnamed_2;
pub const KEY_APOSTROPHE = @enumToInt(enum_unnamed_3.KEY_APOSTROPHE);
pub const KEY_COMMA = @enumToInt(enum_unnamed_3.KEY_COMMA);
pub const KEY_MINUS = @enumToInt(enum_unnamed_3.KEY_MINUS);
pub const KEY_PERIOD = @enumToInt(enum_unnamed_3.KEY_PERIOD);
pub const KEY_SLASH = @enumToInt(enum_unnamed_3.KEY_SLASH);
pub const KEY_ZERO = @enumToInt(enum_unnamed_3.KEY_ZERO);
pub const KEY_ONE = @enumToInt(enum_unnamed_3.KEY_ONE);
pub const KEY_TWO = @enumToInt(enum_unnamed_3.KEY_TWO);
pub const KEY_THREE = @enumToInt(enum_unnamed_3.KEY_THREE);
pub const KEY_FOUR = @enumToInt(enum_unnamed_3.KEY_FOUR);
pub const KEY_FIVE = @enumToInt(enum_unnamed_3.KEY_FIVE);
pub const KEY_SIX = @enumToInt(enum_unnamed_3.KEY_SIX);
pub const KEY_SEVEN = @enumToInt(enum_unnamed_3.KEY_SEVEN);
pub const KEY_EIGHT = @enumToInt(enum_unnamed_3.KEY_EIGHT);
pub const KEY_NINE = @enumToInt(enum_unnamed_3.KEY_NINE);
pub const KEY_SEMICOLON = @enumToInt(enum_unnamed_3.KEY_SEMICOLON);
pub const KEY_EQUAL = @enumToInt(enum_unnamed_3.KEY_EQUAL);
pub const KEY_A = @enumToInt(enum_unnamed_3.KEY_A);
pub const KEY_B = @enumToInt(enum_unnamed_3.KEY_B);
pub const KEY_C = @enumToInt(enum_unnamed_3.KEY_C);
pub const KEY_D = @enumToInt(enum_unnamed_3.KEY_D);
pub const KEY_E = @enumToInt(enum_unnamed_3.KEY_E);
pub const KEY_F = @enumToInt(enum_unnamed_3.KEY_F);
pub const KEY_G = @enumToInt(enum_unnamed_3.KEY_G);
pub const KEY_H = @enumToInt(enum_unnamed_3.KEY_H);
pub const KEY_I = @enumToInt(enum_unnamed_3.KEY_I);
pub const KEY_J = @enumToInt(enum_unnamed_3.KEY_J);
pub const KEY_K = @enumToInt(enum_unnamed_3.KEY_K);
pub const KEY_L = @enumToInt(enum_unnamed_3.KEY_L);
pub const KEY_M = @enumToInt(enum_unnamed_3.KEY_M);
pub const KEY_N = @enumToInt(enum_unnamed_3.KEY_N);
pub const KEY_O = @enumToInt(enum_unnamed_3.KEY_O);
pub const KEY_P = @enumToInt(enum_unnamed_3.KEY_P);
pub const KEY_Q = @enumToInt(enum_unnamed_3.KEY_Q);
pub const KEY_R = @enumToInt(enum_unnamed_3.KEY_R);
pub const KEY_S = @enumToInt(enum_unnamed_3.KEY_S);
pub const KEY_T = @enumToInt(enum_unnamed_3.KEY_T);
pub const KEY_U = @enumToInt(enum_unnamed_3.KEY_U);
pub const KEY_V = @enumToInt(enum_unnamed_3.KEY_V);
pub const KEY_W = @enumToInt(enum_unnamed_3.KEY_W);
pub const KEY_X = @enumToInt(enum_unnamed_3.KEY_X);
pub const KEY_Y = @enumToInt(enum_unnamed_3.KEY_Y);
pub const KEY_Z = @enumToInt(enum_unnamed_3.KEY_Z);
pub const KEY_SPACE = @enumToInt(enum_unnamed_3.KEY_SPACE);
pub const KEY_ESCAPE = @enumToInt(enum_unnamed_3.KEY_ESCAPE);
pub const KEY_ENTER = @enumToInt(enum_unnamed_3.KEY_ENTER);
pub const KEY_TAB = @enumToInt(enum_unnamed_3.KEY_TAB);
pub const KEY_BACKSPACE = @enumToInt(enum_unnamed_3.KEY_BACKSPACE);
pub const KEY_INSERT = @enumToInt(enum_unnamed_3.KEY_INSERT);
pub const KEY_DELETE = @enumToInt(enum_unnamed_3.KEY_DELETE);
pub const KEY_RIGHT = @enumToInt(enum_unnamed_3.KEY_RIGHT);
pub const KEY_LEFT = @enumToInt(enum_unnamed_3.KEY_LEFT);
pub const KEY_DOWN = @enumToInt(enum_unnamed_3.KEY_DOWN);
pub const KEY_UP = @enumToInt(enum_unnamed_3.KEY_UP);
pub const KEY_PAGE_UP = @enumToInt(enum_unnamed_3.KEY_PAGE_UP);
pub const KEY_PAGE_DOWN = @enumToInt(enum_unnamed_3.KEY_PAGE_DOWN);
pub const KEY_HOME = @enumToInt(enum_unnamed_3.KEY_HOME);
pub const KEY_END = @enumToInt(enum_unnamed_3.KEY_END);
pub const KEY_CAPS_LOCK = @enumToInt(enum_unnamed_3.KEY_CAPS_LOCK);
pub const KEY_SCROLL_LOCK = @enumToInt(enum_unnamed_3.KEY_SCROLL_LOCK);
pub const KEY_NUM_LOCK = @enumToInt(enum_unnamed_3.KEY_NUM_LOCK);
pub const KEY_PRINT_SCREEN = @enumToInt(enum_unnamed_3.KEY_PRINT_SCREEN);
pub const KEY_PAUSE = @enumToInt(enum_unnamed_3.KEY_PAUSE);
pub const KEY_F1 = @enumToInt(enum_unnamed_3.KEY_F1);
pub const KEY_F2 = @enumToInt(enum_unnamed_3.KEY_F2);
pub const KEY_F3 = @enumToInt(enum_unnamed_3.KEY_F3);
pub const KEY_F4 = @enumToInt(enum_unnamed_3.KEY_F4);
pub const KEY_F5 = @enumToInt(enum_unnamed_3.KEY_F5);
pub const KEY_F6 = @enumToInt(enum_unnamed_3.KEY_F6);
pub const KEY_F7 = @enumToInt(enum_unnamed_3.KEY_F7);
pub const KEY_F8 = @enumToInt(enum_unnamed_3.KEY_F8);
pub const KEY_F9 = @enumToInt(enum_unnamed_3.KEY_F9);
pub const KEY_F10 = @enumToInt(enum_unnamed_3.KEY_F10);
pub const KEY_F11 = @enumToInt(enum_unnamed_3.KEY_F11);
pub const KEY_F12 = @enumToInt(enum_unnamed_3.KEY_F12);
pub const KEY_LEFT_SHIFT = @enumToInt(enum_unnamed_3.KEY_LEFT_SHIFT);
pub const KEY_LEFT_CONTROL = @enumToInt(enum_unnamed_3.KEY_LEFT_CONTROL);
pub const KEY_LEFT_ALT = @enumToInt(enum_unnamed_3.KEY_LEFT_ALT);
pub const KEY_LEFT_SUPER = @enumToInt(enum_unnamed_3.KEY_LEFT_SUPER);
pub const KEY_RIGHT_SHIFT = @enumToInt(enum_unnamed_3.KEY_RIGHT_SHIFT);
pub const KEY_RIGHT_CONTROL = @enumToInt(enum_unnamed_3.KEY_RIGHT_CONTROL);
pub const KEY_RIGHT_ALT = @enumToInt(enum_unnamed_3.KEY_RIGHT_ALT);
pub const KEY_RIGHT_SUPER = @enumToInt(enum_unnamed_3.KEY_RIGHT_SUPER);
pub const KEY_KB_MENU = @enumToInt(enum_unnamed_3.KEY_KB_MENU);
pub const KEY_LEFT_BRACKET = @enumToInt(enum_unnamed_3.KEY_LEFT_BRACKET);
pub const KEY_BACKSLASH = @enumToInt(enum_unnamed_3.KEY_BACKSLASH);
pub const KEY_RIGHT_BRACKET = @enumToInt(enum_unnamed_3.KEY_RIGHT_BRACKET);
pub const KEY_GRAVE = @enumToInt(enum_unnamed_3.KEY_GRAVE);
pub const KEY_KP_0 = @enumToInt(enum_unnamed_3.KEY_KP_0);
pub const KEY_KP_1 = @enumToInt(enum_unnamed_3.KEY_KP_1);
pub const KEY_KP_2 = @enumToInt(enum_unnamed_3.KEY_KP_2);
pub const KEY_KP_3 = @enumToInt(enum_unnamed_3.KEY_KP_3);
pub const KEY_KP_4 = @enumToInt(enum_unnamed_3.KEY_KP_4);
pub const KEY_KP_5 = @enumToInt(enum_unnamed_3.KEY_KP_5);
pub const KEY_KP_6 = @enumToInt(enum_unnamed_3.KEY_KP_6);
pub const KEY_KP_7 = @enumToInt(enum_unnamed_3.KEY_KP_7);
pub const KEY_KP_8 = @enumToInt(enum_unnamed_3.KEY_KP_8);
pub const KEY_KP_9 = @enumToInt(enum_unnamed_3.KEY_KP_9);
pub const KEY_KP_DECIMAL = @enumToInt(enum_unnamed_3.KEY_KP_DECIMAL);
pub const KEY_KP_DIVIDE = @enumToInt(enum_unnamed_3.KEY_KP_DIVIDE);
pub const KEY_KP_MULTIPLY = @enumToInt(enum_unnamed_3.KEY_KP_MULTIPLY);
pub const KEY_KP_SUBTRACT = @enumToInt(enum_unnamed_3.KEY_KP_SUBTRACT);
pub const KEY_KP_ADD = @enumToInt(enum_unnamed_3.KEY_KP_ADD);
pub const KEY_KP_ENTER = @enumToInt(enum_unnamed_3.KEY_KP_ENTER);
pub const KEY_KP_EQUAL = @enumToInt(enum_unnamed_3.KEY_KP_EQUAL);
const enum_unnamed_3 = extern enum(c_int) {
    KEY_APOSTROPHE = 39,
    KEY_COMMA = 44,
    KEY_MINUS = 45,
    KEY_PERIOD = 46,
    KEY_SLASH = 47,
    KEY_ZERO = 48,
    KEY_ONE = 49,
    KEY_TWO = 50,
    KEY_THREE = 51,
    KEY_FOUR = 52,
    KEY_FIVE = 53,
    KEY_SIX = 54,
    KEY_SEVEN = 55,
    KEY_EIGHT = 56,
    KEY_NINE = 57,
    KEY_SEMICOLON = 59,
    KEY_EQUAL = 61,
    KEY_A = 65,
    KEY_B = 66,
    KEY_C = 67,
    KEY_D = 68,
    KEY_E = 69,
    KEY_F = 70,
    KEY_G = 71,
    KEY_H = 72,
    KEY_I = 73,
    KEY_J = 74,
    KEY_K = 75,
    KEY_L = 76,
    KEY_M = 77,
    KEY_N = 78,
    KEY_O = 79,
    KEY_P = 80,
    KEY_Q = 81,
    KEY_R = 82,
    KEY_S = 83,
    KEY_T = 84,
    KEY_U = 85,
    KEY_V = 86,
    KEY_W = 87,
    KEY_X = 88,
    KEY_Y = 89,
    KEY_Z = 90,
    KEY_SPACE = 32,
    KEY_ESCAPE = 256,
    KEY_ENTER = 257,
    KEY_TAB = 258,
    KEY_BACKSPACE = 259,
    KEY_INSERT = 260,
    KEY_DELETE = 261,
    KEY_RIGHT = 262,
    KEY_LEFT = 263,
    KEY_DOWN = 264,
    KEY_UP = 265,
    KEY_PAGE_UP = 266,
    KEY_PAGE_DOWN = 267,
    KEY_HOME = 268,
    KEY_END = 269,
    KEY_CAPS_LOCK = 280,
    KEY_SCROLL_LOCK = 281,
    KEY_NUM_LOCK = 282,
    KEY_PRINT_SCREEN = 283,
    KEY_PAUSE = 284,
    KEY_F1 = 290,
    KEY_F2 = 291,
    KEY_F3 = 292,
    KEY_F4 = 293,
    KEY_F5 = 294,
    KEY_F6 = 295,
    KEY_F7 = 296,
    KEY_F8 = 297,
    KEY_F9 = 298,
    KEY_F10 = 299,
    KEY_F11 = 300,
    KEY_F12 = 301,
    KEY_LEFT_SHIFT = 340,
    KEY_LEFT_CONTROL = 341,
    KEY_LEFT_ALT = 342,
    KEY_LEFT_SUPER = 343,
    KEY_RIGHT_SHIFT = 344,
    KEY_RIGHT_CONTROL = 345,
    KEY_RIGHT_ALT = 346,
    KEY_RIGHT_SUPER = 347,
    KEY_KB_MENU = 348,
    KEY_LEFT_BRACKET = 91,
    KEY_BACKSLASH = 92,
    KEY_RIGHT_BRACKET = 93,
    KEY_GRAVE = 96,
    KEY_KP_0 = 320,
    KEY_KP_1 = 321,
    KEY_KP_2 = 322,
    KEY_KP_3 = 323,
    KEY_KP_4 = 324,
    KEY_KP_5 = 325,
    KEY_KP_6 = 326,
    KEY_KP_7 = 327,
    KEY_KP_8 = 328,
    KEY_KP_9 = 329,
    KEY_KP_DECIMAL = 330,
    KEY_KP_DIVIDE = 331,
    KEY_KP_MULTIPLY = 332,
    KEY_KP_SUBTRACT = 333,
    KEY_KP_ADD = 334,
    KEY_KP_ENTER = 335,
    KEY_KP_EQUAL = 336,
    _,
};
pub const KeyboardKey = enum_unnamed_3;
pub const KEY_BACK = @enumToInt(enum_unnamed_4.KEY_BACK);
pub const KEY_MENU = @enumToInt(enum_unnamed_4.KEY_MENU);
pub const KEY_VOLUME_UP = @enumToInt(enum_unnamed_4.KEY_VOLUME_UP);
pub const KEY_VOLUME_DOWN = @enumToInt(enum_unnamed_4.KEY_VOLUME_DOWN);
const enum_unnamed_4 = extern enum(c_int) {
    KEY_BACK = 4,
    KEY_MENU = 82,
    KEY_VOLUME_UP = 24,
    KEY_VOLUME_DOWN = 25,
    _,
};
pub const AndroidButton = enum_unnamed_4;
pub const MOUSE_LEFT_BUTTON = @enumToInt(enum_unnamed_5.MOUSE_LEFT_BUTTON);
pub const MOUSE_RIGHT_BUTTON = @enumToInt(enum_unnamed_5.MOUSE_RIGHT_BUTTON);
pub const MOUSE_MIDDLE_BUTTON = @enumToInt(enum_unnamed_5.MOUSE_MIDDLE_BUTTON);
const enum_unnamed_5 = extern enum(c_int) {
    MOUSE_LEFT_BUTTON = 0,
    MOUSE_RIGHT_BUTTON = 1,
    MOUSE_MIDDLE_BUTTON = 2,
    _,
};
pub const MouseButton = enum_unnamed_5;
pub const GAMEPAD_PLAYER1 = @enumToInt(enum_unnamed_6.GAMEPAD_PLAYER1);
pub const GAMEPAD_PLAYER2 = @enumToInt(enum_unnamed_6.GAMEPAD_PLAYER2);
pub const GAMEPAD_PLAYER3 = @enumToInt(enum_unnamed_6.GAMEPAD_PLAYER3);
pub const GAMEPAD_PLAYER4 = @enumToInt(enum_unnamed_6.GAMEPAD_PLAYER4);
const enum_unnamed_6 = extern enum(c_int) {
    GAMEPAD_PLAYER1 = 0,
    GAMEPAD_PLAYER2 = 1,
    GAMEPAD_PLAYER3 = 2,
    GAMEPAD_PLAYER4 = 3,
    _,
};
pub const GamepadNumber = enum_unnamed_6;
pub const GAMEPAD_BUTTON_UNKNOWN = @enumToInt(enum_unnamed_7.GAMEPAD_BUTTON_UNKNOWN);
pub const GAMEPAD_BUTTON_LEFT_FACE_UP = @enumToInt(enum_unnamed_7.GAMEPAD_BUTTON_LEFT_FACE_UP);
pub const GAMEPAD_BUTTON_LEFT_FACE_RIGHT = @enumToInt(enum_unnamed_7.GAMEPAD_BUTTON_LEFT_FACE_RIGHT);
pub const GAMEPAD_BUTTON_LEFT_FACE_DOWN = @enumToInt(enum_unnamed_7.GAMEPAD_BUTTON_LEFT_FACE_DOWN);
pub const GAMEPAD_BUTTON_LEFT_FACE_LEFT = @enumToInt(enum_unnamed_7.GAMEPAD_BUTTON_LEFT_FACE_LEFT);
pub const GAMEPAD_BUTTON_RIGHT_FACE_UP = @enumToInt(enum_unnamed_7.GAMEPAD_BUTTON_RIGHT_FACE_UP);
pub const GAMEPAD_BUTTON_RIGHT_FACE_RIGHT = @enumToInt(enum_unnamed_7.GAMEPAD_BUTTON_RIGHT_FACE_RIGHT);
pub const GAMEPAD_BUTTON_RIGHT_FACE_DOWN = @enumToInt(enum_unnamed_7.GAMEPAD_BUTTON_RIGHT_FACE_DOWN);
pub const GAMEPAD_BUTTON_RIGHT_FACE_LEFT = @enumToInt(enum_unnamed_7.GAMEPAD_BUTTON_RIGHT_FACE_LEFT);
pub const GAMEPAD_BUTTON_LEFT_TRIGGER_1 = @enumToInt(enum_unnamed_7.GAMEPAD_BUTTON_LEFT_TRIGGER_1);
pub const GAMEPAD_BUTTON_LEFT_TRIGGER_2 = @enumToInt(enum_unnamed_7.GAMEPAD_BUTTON_LEFT_TRIGGER_2);
pub const GAMEPAD_BUTTON_RIGHT_TRIGGER_1 = @enumToInt(enum_unnamed_7.GAMEPAD_BUTTON_RIGHT_TRIGGER_1);
pub const GAMEPAD_BUTTON_RIGHT_TRIGGER_2 = @enumToInt(enum_unnamed_7.GAMEPAD_BUTTON_RIGHT_TRIGGER_2);
pub const GAMEPAD_BUTTON_MIDDLE_LEFT = @enumToInt(enum_unnamed_7.GAMEPAD_BUTTON_MIDDLE_LEFT);
pub const GAMEPAD_BUTTON_MIDDLE = @enumToInt(enum_unnamed_7.GAMEPAD_BUTTON_MIDDLE);
pub const GAMEPAD_BUTTON_MIDDLE_RIGHT = @enumToInt(enum_unnamed_7.GAMEPAD_BUTTON_MIDDLE_RIGHT);
pub const GAMEPAD_BUTTON_LEFT_THUMB = @enumToInt(enum_unnamed_7.GAMEPAD_BUTTON_LEFT_THUMB);
pub const GAMEPAD_BUTTON_RIGHT_THUMB = @enumToInt(enum_unnamed_7.GAMEPAD_BUTTON_RIGHT_THUMB);
const enum_unnamed_7 = extern enum(c_int) {
    GAMEPAD_BUTTON_UNKNOWN = 0,
    GAMEPAD_BUTTON_LEFT_FACE_UP = 1,
    GAMEPAD_BUTTON_LEFT_FACE_RIGHT = 2,
    GAMEPAD_BUTTON_LEFT_FACE_DOWN = 3,
    GAMEPAD_BUTTON_LEFT_FACE_LEFT = 4,
    GAMEPAD_BUTTON_RIGHT_FACE_UP = 5,
    GAMEPAD_BUTTON_RIGHT_FACE_RIGHT = 6,
    GAMEPAD_BUTTON_RIGHT_FACE_DOWN = 7,
    GAMEPAD_BUTTON_RIGHT_FACE_LEFT = 8,
    GAMEPAD_BUTTON_LEFT_TRIGGER_1 = 9,
    GAMEPAD_BUTTON_LEFT_TRIGGER_2 = 10,
    GAMEPAD_BUTTON_RIGHT_TRIGGER_1 = 11,
    GAMEPAD_BUTTON_RIGHT_TRIGGER_2 = 12,
    GAMEPAD_BUTTON_MIDDLE_LEFT = 13,
    GAMEPAD_BUTTON_MIDDLE = 14,
    GAMEPAD_BUTTON_MIDDLE_RIGHT = 15,
    GAMEPAD_BUTTON_LEFT_THUMB = 16,
    GAMEPAD_BUTTON_RIGHT_THUMB = 17,
    _,
};
pub const GamepadButton = enum_unnamed_7;
pub const GAMEPAD_AXIS_UNKNOWN = @enumToInt(enum_unnamed_8.GAMEPAD_AXIS_UNKNOWN);
pub const GAMEPAD_AXIS_LEFT_X = @enumToInt(enum_unnamed_8.GAMEPAD_AXIS_LEFT_X);
pub const GAMEPAD_AXIS_LEFT_Y = @enumToInt(enum_unnamed_8.GAMEPAD_AXIS_LEFT_Y);
pub const GAMEPAD_AXIS_RIGHT_X = @enumToInt(enum_unnamed_8.GAMEPAD_AXIS_RIGHT_X);
pub const GAMEPAD_AXIS_RIGHT_Y = @enumToInt(enum_unnamed_8.GAMEPAD_AXIS_RIGHT_Y);
pub const GAMEPAD_AXIS_LEFT_TRIGGER = @enumToInt(enum_unnamed_8.GAMEPAD_AXIS_LEFT_TRIGGER);
pub const GAMEPAD_AXIS_RIGHT_TRIGGER = @enumToInt(enum_unnamed_8.GAMEPAD_AXIS_RIGHT_TRIGGER);
const enum_unnamed_8 = extern enum(c_int) {
    GAMEPAD_AXIS_UNKNOWN = 0,
    GAMEPAD_AXIS_LEFT_X = 1,
    GAMEPAD_AXIS_LEFT_Y = 2,
    GAMEPAD_AXIS_RIGHT_X = 3,
    GAMEPAD_AXIS_RIGHT_Y = 4,
    GAMEPAD_AXIS_LEFT_TRIGGER = 5,
    GAMEPAD_AXIS_RIGHT_TRIGGER = 6,
    _,
};
pub const GamepadAxis = enum_unnamed_8;
pub const LOC_VERTEX_POSITION = @enumToInt(enum_unnamed_9.LOC_VERTEX_POSITION);
pub const LOC_VERTEX_TEXCOORD01 = @enumToInt(enum_unnamed_9.LOC_VERTEX_TEXCOORD01);
pub const LOC_VERTEX_TEXCOORD02 = @enumToInt(enum_unnamed_9.LOC_VERTEX_TEXCOORD02);
pub const LOC_VERTEX_NORMAL = @enumToInt(enum_unnamed_9.LOC_VERTEX_NORMAL);
pub const LOC_VERTEX_TANGENT = @enumToInt(enum_unnamed_9.LOC_VERTEX_TANGENT);
pub const LOC_VERTEX_COLOR = @enumToInt(enum_unnamed_9.LOC_VERTEX_COLOR);
pub const LOC_MATRIX_MVP = @enumToInt(enum_unnamed_9.LOC_MATRIX_MVP);
pub const LOC_MATRIX_MODEL = @enumToInt(enum_unnamed_9.LOC_MATRIX_MODEL);
pub const LOC_MATRIX_VIEW = @enumToInt(enum_unnamed_9.LOC_MATRIX_VIEW);
pub const LOC_MATRIX_PROJECTION = @enumToInt(enum_unnamed_9.LOC_MATRIX_PROJECTION);
pub const LOC_VECTOR_VIEW = @enumToInt(enum_unnamed_9.LOC_VECTOR_VIEW);
pub const LOC_COLOR_DIFFUSE = @enumToInt(enum_unnamed_9.LOC_COLOR_DIFFUSE);
pub const LOC_COLOR_SPECULAR = @enumToInt(enum_unnamed_9.LOC_COLOR_SPECULAR);
pub const LOC_COLOR_AMBIENT = @enumToInt(enum_unnamed_9.LOC_COLOR_AMBIENT);
pub const LOC_MAP_ALBEDO = @enumToInt(enum_unnamed_9.LOC_MAP_ALBEDO);
pub const LOC_MAP_METALNESS = @enumToInt(enum_unnamed_9.LOC_MAP_METALNESS);
pub const LOC_MAP_NORMAL = @enumToInt(enum_unnamed_9.LOC_MAP_NORMAL);
pub const LOC_MAP_ROUGHNESS = @enumToInt(enum_unnamed_9.LOC_MAP_ROUGHNESS);
pub const LOC_MAP_OCCLUSION = @enumToInt(enum_unnamed_9.LOC_MAP_OCCLUSION);
pub const LOC_MAP_EMISSION = @enumToInt(enum_unnamed_9.LOC_MAP_EMISSION);
pub const LOC_MAP_HEIGHT = @enumToInt(enum_unnamed_9.LOC_MAP_HEIGHT);
pub const LOC_MAP_CUBEMAP = @enumToInt(enum_unnamed_9.LOC_MAP_CUBEMAP);
pub const LOC_MAP_IRRADIANCE = @enumToInt(enum_unnamed_9.LOC_MAP_IRRADIANCE);
pub const LOC_MAP_PREFILTER = @enumToInt(enum_unnamed_9.LOC_MAP_PREFILTER);
pub const LOC_MAP_BRDF = @enumToInt(enum_unnamed_9.LOC_MAP_BRDF);
const enum_unnamed_9 = extern enum(c_int) {
    LOC_VERTEX_POSITION = 0,
    LOC_VERTEX_TEXCOORD01 = 1,
    LOC_VERTEX_TEXCOORD02 = 2,
    LOC_VERTEX_NORMAL = 3,
    LOC_VERTEX_TANGENT = 4,
    LOC_VERTEX_COLOR = 5,
    LOC_MATRIX_MVP = 6,
    LOC_MATRIX_MODEL = 7,
    LOC_MATRIX_VIEW = 8,
    LOC_MATRIX_PROJECTION = 9,
    LOC_VECTOR_VIEW = 10,
    LOC_COLOR_DIFFUSE = 11,
    LOC_COLOR_SPECULAR = 12,
    LOC_COLOR_AMBIENT = 13,
    LOC_MAP_ALBEDO = 14,
    LOC_MAP_METALNESS = 15,
    LOC_MAP_NORMAL = 16,
    LOC_MAP_ROUGHNESS = 17,
    LOC_MAP_OCCLUSION = 18,
    LOC_MAP_EMISSION = 19,
    LOC_MAP_HEIGHT = 20,
    LOC_MAP_CUBEMAP = 21,
    LOC_MAP_IRRADIANCE = 22,
    LOC_MAP_PREFILTER = 23,
    LOC_MAP_BRDF = 24,
    _,
};
pub const ShaderLocationIndex = enum_unnamed_9;
pub const UNIFORM_FLOAT = @enumToInt(enum_unnamed_10.UNIFORM_FLOAT);
pub const UNIFORM_VEC2 = @enumToInt(enum_unnamed_10.UNIFORM_VEC2);
pub const UNIFORM_VEC3 = @enumToInt(enum_unnamed_10.UNIFORM_VEC3);
pub const UNIFORM_VEC4 = @enumToInt(enum_unnamed_10.UNIFORM_VEC4);
pub const UNIFORM_INT = @enumToInt(enum_unnamed_10.UNIFORM_INT);
pub const UNIFORM_IVEC2 = @enumToInt(enum_unnamed_10.UNIFORM_IVEC2);
pub const UNIFORM_IVEC3 = @enumToInt(enum_unnamed_10.UNIFORM_IVEC3);
pub const UNIFORM_IVEC4 = @enumToInt(enum_unnamed_10.UNIFORM_IVEC4);
pub const UNIFORM_SAMPLER2D = @enumToInt(enum_unnamed_10.UNIFORM_SAMPLER2D);
const enum_unnamed_10 = extern enum(c_int) {
    UNIFORM_FLOAT = 0,
    UNIFORM_VEC2 = 1,
    UNIFORM_VEC3 = 2,
    UNIFORM_VEC4 = 3,
    UNIFORM_INT = 4,
    UNIFORM_IVEC2 = 5,
    UNIFORM_IVEC3 = 6,
    UNIFORM_IVEC4 = 7,
    UNIFORM_SAMPLER2D = 8,
    _,
};
pub const ShaderUniformDataType = enum_unnamed_10;
pub const MAP_ALBEDO = @enumToInt(enum_unnamed_11.MAP_ALBEDO);
pub const MAP_METALNESS = @enumToInt(enum_unnamed_11.MAP_METALNESS);
pub const MAP_NORMAL = @enumToInt(enum_unnamed_11.MAP_NORMAL);
pub const MAP_ROUGHNESS = @enumToInt(enum_unnamed_11.MAP_ROUGHNESS);
pub const MAP_OCCLUSION = @enumToInt(enum_unnamed_11.MAP_OCCLUSION);
pub const MAP_EMISSION = @enumToInt(enum_unnamed_11.MAP_EMISSION);
pub const MAP_HEIGHT = @enumToInt(enum_unnamed_11.MAP_HEIGHT);
pub const MAP_CUBEMAP = @enumToInt(enum_unnamed_11.MAP_CUBEMAP);
pub const MAP_IRRADIANCE = @enumToInt(enum_unnamed_11.MAP_IRRADIANCE);
pub const MAP_PREFILTER = @enumToInt(enum_unnamed_11.MAP_PREFILTER);
pub const MAP_BRDF = @enumToInt(enum_unnamed_11.MAP_BRDF);
const enum_unnamed_11 = extern enum(c_int) {
    MAP_ALBEDO = 0,
    MAP_METALNESS = 1,
    MAP_NORMAL = 2,
    MAP_ROUGHNESS = 3,
    MAP_OCCLUSION = 4,
    MAP_EMISSION = 5,
    MAP_HEIGHT = 6,
    MAP_CUBEMAP = 7,
    MAP_IRRADIANCE = 8,
    MAP_PREFILTER = 9,
    MAP_BRDF = 10,
    _,
};
pub const MaterialMapType = enum_unnamed_11;
pub const UNCOMPRESSED_GRAYSCALE = @enumToInt(enum_unnamed_12.UNCOMPRESSED_GRAYSCALE);
pub const UNCOMPRESSED_GRAY_ALPHA = @enumToInt(enum_unnamed_12.UNCOMPRESSED_GRAY_ALPHA);
pub const UNCOMPRESSED_R5G6B5 = @enumToInt(enum_unnamed_12.UNCOMPRESSED_R5G6B5);
pub const UNCOMPRESSED_R8G8B8 = @enumToInt(enum_unnamed_12.UNCOMPRESSED_R8G8B8);
pub const UNCOMPRESSED_R5G5B5A1 = @enumToInt(enum_unnamed_12.UNCOMPRESSED_R5G5B5A1);
pub const UNCOMPRESSED_R4G4B4A4 = @enumToInt(enum_unnamed_12.UNCOMPRESSED_R4G4B4A4);
pub const UNCOMPRESSED_R8G8B8A8 = @enumToInt(enum_unnamed_12.UNCOMPRESSED_R8G8B8A8);
pub const UNCOMPRESSED_R32 = @enumToInt(enum_unnamed_12.UNCOMPRESSED_R32);
pub const UNCOMPRESSED_R32G32B32 = @enumToInt(enum_unnamed_12.UNCOMPRESSED_R32G32B32);
pub const UNCOMPRESSED_R32G32B32A32 = @enumToInt(enum_unnamed_12.UNCOMPRESSED_R32G32B32A32);
pub const COMPRESSED_DXT1_RGB = @enumToInt(enum_unnamed_12.COMPRESSED_DXT1_RGB);
pub const COMPRESSED_DXT1_RGBA = @enumToInt(enum_unnamed_12.COMPRESSED_DXT1_RGBA);
pub const COMPRESSED_DXT3_RGBA = @enumToInt(enum_unnamed_12.COMPRESSED_DXT3_RGBA);
pub const COMPRESSED_DXT5_RGBA = @enumToInt(enum_unnamed_12.COMPRESSED_DXT5_RGBA);
pub const COMPRESSED_ETC1_RGB = @enumToInt(enum_unnamed_12.COMPRESSED_ETC1_RGB);
pub const COMPRESSED_ETC2_RGB = @enumToInt(enum_unnamed_12.COMPRESSED_ETC2_RGB);
pub const COMPRESSED_ETC2_EAC_RGBA = @enumToInt(enum_unnamed_12.COMPRESSED_ETC2_EAC_RGBA);
pub const COMPRESSED_PVRT_RGB = @enumToInt(enum_unnamed_12.COMPRESSED_PVRT_RGB);
pub const COMPRESSED_PVRT_RGBA = @enumToInt(enum_unnamed_12.COMPRESSED_PVRT_RGBA);
pub const COMPRESSED_ASTC_4x4_RGBA = @enumToInt(enum_unnamed_12.COMPRESSED_ASTC_4x4_RGBA);
pub const COMPRESSED_ASTC_8x8_RGBA = @enumToInt(enum_unnamed_12.COMPRESSED_ASTC_8x8_RGBA);
const enum_unnamed_12 = extern enum(c_int) {
    UNCOMPRESSED_GRAYSCALE = 1,
    UNCOMPRESSED_GRAY_ALPHA = 2,
    UNCOMPRESSED_R5G6B5 = 3,
    UNCOMPRESSED_R8G8B8 = 4,
    UNCOMPRESSED_R5G5B5A1 = 5,
    UNCOMPRESSED_R4G4B4A4 = 6,
    UNCOMPRESSED_R8G8B8A8 = 7,
    UNCOMPRESSED_R32 = 8,
    UNCOMPRESSED_R32G32B32 = 9,
    UNCOMPRESSED_R32G32B32A32 = 10,
    COMPRESSED_DXT1_RGB = 11,
    COMPRESSED_DXT1_RGBA = 12,
    COMPRESSED_DXT3_RGBA = 13,
    COMPRESSED_DXT5_RGBA = 14,
    COMPRESSED_ETC1_RGB = 15,
    COMPRESSED_ETC2_RGB = 16,
    COMPRESSED_ETC2_EAC_RGBA = 17,
    COMPRESSED_PVRT_RGB = 18,
    COMPRESSED_PVRT_RGBA = 19,
    COMPRESSED_ASTC_4x4_RGBA = 20,
    COMPRESSED_ASTC_8x8_RGBA = 21,
    _,
};
pub const PixelFormat = enum_unnamed_12;
pub const FILTER_POINT = @enumToInt(enum_unnamed_13.FILTER_POINT);
pub const FILTER_BILINEAR = @enumToInt(enum_unnamed_13.FILTER_BILINEAR);
pub const FILTER_TRILINEAR = @enumToInt(enum_unnamed_13.FILTER_TRILINEAR);
pub const FILTER_ANISOTROPIC_4X = @enumToInt(enum_unnamed_13.FILTER_ANISOTROPIC_4X);
pub const FILTER_ANISOTROPIC_8X = @enumToInt(enum_unnamed_13.FILTER_ANISOTROPIC_8X);
pub const FILTER_ANISOTROPIC_16X = @enumToInt(enum_unnamed_13.FILTER_ANISOTROPIC_16X);
const enum_unnamed_13 = extern enum(c_int) {
    FILTER_POINT = 0,
    FILTER_BILINEAR = 1,
    FILTER_TRILINEAR = 2,
    FILTER_ANISOTROPIC_4X = 3,
    FILTER_ANISOTROPIC_8X = 4,
    FILTER_ANISOTROPIC_16X = 5,
    _,
};
pub const TextureFilterMode = enum_unnamed_13;
pub const CUBEMAP_AUTO_DETECT = @enumToInt(enum_unnamed_14.CUBEMAP_AUTO_DETECT);
pub const CUBEMAP_LINE_VERTICAL = @enumToInt(enum_unnamed_14.CUBEMAP_LINE_VERTICAL);
pub const CUBEMAP_LINE_HORIZONTAL = @enumToInt(enum_unnamed_14.CUBEMAP_LINE_HORIZONTAL);
pub const CUBEMAP_CROSS_THREE_BY_FOUR = @enumToInt(enum_unnamed_14.CUBEMAP_CROSS_THREE_BY_FOUR);
pub const CUBEMAP_CROSS_FOUR_BY_THREE = @enumToInt(enum_unnamed_14.CUBEMAP_CROSS_FOUR_BY_THREE);
pub const CUBEMAP_PANORAMA = @enumToInt(enum_unnamed_14.CUBEMAP_PANORAMA);
const enum_unnamed_14 = extern enum(c_int) {
    CUBEMAP_AUTO_DETECT = 0,
    CUBEMAP_LINE_VERTICAL = 1,
    CUBEMAP_LINE_HORIZONTAL = 2,
    CUBEMAP_CROSS_THREE_BY_FOUR = 3,
    CUBEMAP_CROSS_FOUR_BY_THREE = 4,
    CUBEMAP_PANORAMA = 5,
    _,
};
pub const CubemapLayoutType = enum_unnamed_14;
pub const WRAP_REPEAT = @enumToInt(enum_unnamed_15.WRAP_REPEAT);
pub const WRAP_CLAMP = @enumToInt(enum_unnamed_15.WRAP_CLAMP);
pub const WRAP_MIRROR_REPEAT = @enumToInt(enum_unnamed_15.WRAP_MIRROR_REPEAT);
pub const WRAP_MIRROR_CLAMP = @enumToInt(enum_unnamed_15.WRAP_MIRROR_CLAMP);
const enum_unnamed_15 = extern enum(c_int) {
    WRAP_REPEAT = 0,
    WRAP_CLAMP = 1,
    WRAP_MIRROR_REPEAT = 2,
    WRAP_MIRROR_CLAMP = 3,
    _,
};
pub const TextureWrapMode = enum_unnamed_15;
pub const FONT_DEFAULT = @enumToInt(enum_unnamed_16.FONT_DEFAULT);
pub const FONT_BITMAP = @enumToInt(enum_unnamed_16.FONT_BITMAP);
pub const FONT_SDF = @enumToInt(enum_unnamed_16.FONT_SDF);
const enum_unnamed_16 = extern enum(c_int) {
    FONT_DEFAULT = 0,
    FONT_BITMAP = 1,
    FONT_SDF = 2,
    _,
};
pub const FontType = enum_unnamed_16;
pub const BLEND_ALPHA = @enumToInt(enum_unnamed_17.BLEND_ALPHA);
pub const BLEND_ADDITIVE = @enumToInt(enum_unnamed_17.BLEND_ADDITIVE);
pub const BLEND_MULTIPLIED = @enumToInt(enum_unnamed_17.BLEND_MULTIPLIED);
const enum_unnamed_17 = extern enum(c_int) {
    BLEND_ALPHA = 0,
    BLEND_ADDITIVE = 1,
    BLEND_MULTIPLIED = 2,
    _,
};
pub const BlendMode = enum_unnamed_17;
pub const GESTURE_NONE = @enumToInt(enum_unnamed_18.GESTURE_NONE);
pub const GESTURE_TAP = @enumToInt(enum_unnamed_18.GESTURE_TAP);
pub const GESTURE_DOUBLETAP = @enumToInt(enum_unnamed_18.GESTURE_DOUBLETAP);
pub const GESTURE_HOLD = @enumToInt(enum_unnamed_18.GESTURE_HOLD);
pub const GESTURE_DRAG = @enumToInt(enum_unnamed_18.GESTURE_DRAG);
pub const GESTURE_SWIPE_RIGHT = @enumToInt(enum_unnamed_18.GESTURE_SWIPE_RIGHT);
pub const GESTURE_SWIPE_LEFT = @enumToInt(enum_unnamed_18.GESTURE_SWIPE_LEFT);
pub const GESTURE_SWIPE_UP = @enumToInt(enum_unnamed_18.GESTURE_SWIPE_UP);
pub const GESTURE_SWIPE_DOWN = @enumToInt(enum_unnamed_18.GESTURE_SWIPE_DOWN);
pub const GESTURE_PINCH_IN = @enumToInt(enum_unnamed_18.GESTURE_PINCH_IN);
pub const GESTURE_PINCH_OUT = @enumToInt(enum_unnamed_18.GESTURE_PINCH_OUT);
const enum_unnamed_18 = extern enum(c_int) {
    GESTURE_NONE = 0,
    GESTURE_TAP = 1,
    GESTURE_DOUBLETAP = 2,
    GESTURE_HOLD = 4,
    GESTURE_DRAG = 8,
    GESTURE_SWIPE_RIGHT = 16,
    GESTURE_SWIPE_LEFT = 32,
    GESTURE_SWIPE_UP = 64,
    GESTURE_SWIPE_DOWN = 128,
    GESTURE_PINCH_IN = 256,
    GESTURE_PINCH_OUT = 512,
    _,
};
pub const GestureType = enum_unnamed_18;
pub const CAMERA_CUSTOM = @enumToInt(enum_unnamed_19.CAMERA_CUSTOM);
pub const CAMERA_FREE = @enumToInt(enum_unnamed_19.CAMERA_FREE);
pub const CAMERA_ORBITAL = @enumToInt(enum_unnamed_19.CAMERA_ORBITAL);
pub const CAMERA_FIRST_PERSON = @enumToInt(enum_unnamed_19.CAMERA_FIRST_PERSON);
pub const CAMERA_THIRD_PERSON = @enumToInt(enum_unnamed_19.CAMERA_THIRD_PERSON);
const enum_unnamed_19 = extern enum(c_int) {
    CAMERA_CUSTOM = 0,
    CAMERA_FREE = 1,
    CAMERA_ORBITAL = 2,
    CAMERA_FIRST_PERSON = 3,
    CAMERA_THIRD_PERSON = 4,
    _,
};
pub const CameraMode = enum_unnamed_19;
pub const CAMERA_PERSPECTIVE = @enumToInt(enum_unnamed_20.CAMERA_PERSPECTIVE);
pub const CAMERA_ORTHOGRAPHIC = @enumToInt(enum_unnamed_20.CAMERA_ORTHOGRAPHIC);
const enum_unnamed_20 = extern enum(c_int) {
    CAMERA_PERSPECTIVE = 0,
    CAMERA_ORTHOGRAPHIC = 1,
    _,
};
pub const CameraType = enum_unnamed_20;
pub const NPT_9PATCH = @enumToInt(enum_unnamed_21.NPT_9PATCH);
pub const NPT_3PATCH_VERTICAL = @enumToInt(enum_unnamed_21.NPT_3PATCH_VERTICAL);
pub const NPT_3PATCH_HORIZONTAL = @enumToInt(enum_unnamed_21.NPT_3PATCH_HORIZONTAL);
const enum_unnamed_21 = extern enum(c_int) {
    NPT_9PATCH = 0,
    NPT_3PATCH_VERTICAL = 1,
    NPT_3PATCH_HORIZONTAL = 2,
    _,
};
pub const NPatchType = enum_unnamed_21;
pub const struct___va_list_tag = extern struct {
    gp_offset: c_uint,
    fp_offset: c_uint,
    overflow_arg_area: ?*c_void,
    reg_save_area: ?*c_void,
};
pub const TraceLogCallback = ?fn (c_int, [*c]const u8, [*c]struct___va_list_tag) callconv(.C) void;
pub extern fn InitWindow(width: c_int, height: c_int, title: [*c]const u8) void;
pub extern fn WindowShouldClose() bool;
pub extern fn CloseWindow() void;
pub extern fn IsWindowReady() bool;
pub extern fn IsWindowMinimized() bool;
pub extern fn IsWindowResized() bool;
pub extern fn IsWindowHidden() bool;
pub extern fn ToggleFullscreen() void;
pub extern fn UnhideWindow() void;
pub extern fn HideWindow() void;
pub extern fn SetWindowIcon(image: Image) void;
pub extern fn SetWindowTitle(title: [*c]const u8) void;
pub extern fn SetWindowPosition(x: c_int, y: c_int) void;
pub extern fn SetWindowMonitor(monitor: c_int) void;
pub extern fn SetWindowMinSize(width: c_int, height: c_int) void;
pub extern fn SetWindowSize(width: c_int, height: c_int) void;
pub extern fn GetWindowHandle() ?*c_void;
pub extern fn GetScreenWidth() c_int;
pub extern fn GetScreenHeight() c_int;
pub extern fn GetMonitorCount() c_int;
pub extern fn GetMonitorWidth(monitor: c_int) c_int;
pub extern fn GetMonitorHeight(monitor: c_int) c_int;
pub extern fn GetMonitorPhysicalWidth(monitor: c_int) c_int;
pub extern fn GetMonitorPhysicalHeight(monitor: c_int) c_int;
pub extern fn GetWindowPosition() Vector2;
pub extern fn GetMonitorName(monitor: c_int) [*c]const u8;
pub extern fn GetClipboardText() [*c]const u8;
pub extern fn SetClipboardText(text: [*c]const u8) void;
pub extern fn ShowCursor() void;
pub extern fn HideCursor() void;
pub extern fn IsCursorHidden() bool;
pub extern fn EnableCursor() void;
pub extern fn DisableCursor() void;
pub extern fn ClearBackground(color: Color) void;
pub extern fn BeginDrawing() void;
pub extern fn EndDrawing() void;
pub extern fn BeginMode2D(camera: Camera2D) void;
pub extern fn EndMode2D() void;
pub extern fn BeginMode3D(camera: Camera3D) void;
pub extern fn EndMode3D() void;
pub extern fn BeginTextureMode(target: RenderTexture2D) void;
pub extern fn EndTextureMode() void;
pub extern fn BeginScissorMode(x: c_int, y: c_int, width: c_int, height: c_int) void;
pub extern fn EndScissorMode() void;
pub extern fn GetMouseRayShim(mousePosition: * const Vector2, camera: Camera)  Ray;
pub        fn GetMouseRay(mousePosition: Vector2, camera: Camera) Ray {
   return  GetMouseRayShim(&mousePosition, camera);
}
pub extern fn GetCameraMatrix(camera: Camera) Matrix;
pub extern fn GetCameraMatrix2D(camera: Camera2D) Matrix;
pub extern fn GetWorldToScreenShim(position: * const Vector3, camera: Camera)  Vector2;
pub        fn GetWorldToScreen(position: Vector3, camera: Camera) Vector2 {
   return  GetWorldToScreenShim(&position, camera);
}
pub extern fn GetWorldToScreenExShim(position: * const Vector3, camera: Camera, width: c_int, height: c_int)  Vector2;
pub        fn GetWorldToScreenEx(position: Vector3, camera: Camera, width: c_int, height: c_int) Vector2 {
   return  GetWorldToScreenExShim(&position, camera, width, height);
}
pub extern fn GetWorldToScreen2DShim(position: * const Vector2, camera: Camera2D)  Vector2;
pub        fn GetWorldToScreen2D(position: Vector2, camera: Camera2D) Vector2 {
   return  GetWorldToScreen2DShim(&position, camera);
}
pub extern fn GetScreenToWorld2DShim(position: * const Vector2, camera: Camera2D)  Vector2;
pub        fn GetScreenToWorld2D(position: Vector2, camera: Camera2D) Vector2 {
   return  GetScreenToWorld2DShim(&position, camera);
}
pub extern fn SetTargetFPS(fps: c_int) void;
pub extern fn GetFPS() c_int;
pub extern fn GetFrameTime() f32;
pub extern fn GetTime() f64;
pub extern fn ColorToInt(color: Color) c_int;
pub extern fn ColorNormalize(color: Color) Vector4;
pub extern fn ColorFromNormalizedShim(normalized: * const Vector4)  Color;
pub        fn ColorFromNormalized(normalized: Vector4) Color {
   return  ColorFromNormalizedShim(&normalized);
}
pub extern fn ColorToHSV(color: Color) Vector3;
pub extern fn ColorFromHSVShim(hsv: * const Vector3)  Color;
pub        fn ColorFromHSV(hsv: Vector3) Color {
   return  ColorFromHSVShim(&hsv);
}
pub extern fn GetColor(hexValue: c_int) Color;
pub extern fn Fade(color: Color, alpha: f32) Color;
pub extern fn SetConfigFlags(flags: c_uint) void;
pub extern fn SetTraceLogLevel(logType: c_int) void;
pub extern fn SetTraceLogExit(logType: c_int) void;
pub extern fn SetTraceLogCallback(callback: TraceLogCallback) void;
pub extern fn TraceLog(logType: c_int, text: [*c]const u8, ...) void;
pub extern fn TakeScreenshot(fileName: [*c]const u8) void;
pub extern fn GetRandomValue(min: c_int, max: c_int) c_int;
pub extern fn FileExists(fileName: [*c]const u8) bool;
pub extern fn IsFileExtension(fileName: [*c]const u8, ext: [*c]const u8) bool;
pub extern fn DirectoryExists(dirPath: [*c]const u8) bool;
pub extern fn GetExtension(fileName: [*c]const u8) [*c]const u8;
pub extern fn GetFileName(filePath: [*c]const u8) [*c]const u8;
pub extern fn GetFileNameWithoutExt(filePath: [*c]const u8) [*c]const u8;
pub extern fn GetDirectoryPath(filePath: [*c]const u8) [*c]const u8;
pub extern fn GetPrevDirectoryPath(dirPath: [*c]const u8) [*c]const u8;
pub extern fn GetWorkingDirectory() [*c]const u8;
pub extern fn GetDirectoryFiles(dirPath: [*c]const u8, count: [*c]c_int) [*c][*c]u8;
pub extern fn ClearDirectoryFiles() void;
pub extern fn ChangeDirectory(dir: [*c]const u8) bool;
pub extern fn IsFileDropped() bool;
pub extern fn GetDroppedFiles(count: [*c]c_int) [*c][*c]u8;
pub extern fn ClearDroppedFiles() void;
pub extern fn GetFileModTime(fileName: [*c]const u8) c_long;
pub extern fn CompressData(data: [*c]u8, dataLength: c_int, compDataLength: [*c]c_int) [*c]u8;
pub extern fn DecompressData(compData: [*c]u8, compDataLength: c_int, dataLength: [*c]c_int) [*c]u8;
pub extern fn StorageSaveValue(position: c_int, value: c_int) void;
pub extern fn StorageLoadValue(position: c_int) c_int;
pub extern fn OpenURL(url: [*c]const u8) void;
pub extern fn IsKeyPressed(key: c_int) bool;
pub extern fn IsKeyDown(key: c_int) bool;
pub extern fn IsKeyReleased(key: c_int) bool;
pub extern fn IsKeyUp(key: c_int) bool;
pub extern fn SetExitKey(key: c_int) void;
pub extern fn GetKeyPressed() c_int;
pub extern fn IsGamepadAvailable(gamepad: c_int) bool;
pub extern fn IsGamepadName(gamepad: c_int, name: [*c]const u8) bool;
pub extern fn GetGamepadName(gamepad: c_int) [*c]const u8;
pub extern fn IsGamepadButtonPressed(gamepad: c_int, button: c_int) bool;
pub extern fn IsGamepadButtonDown(gamepad: c_int, button: c_int) bool;
pub extern fn IsGamepadButtonReleased(gamepad: c_int, button: c_int) bool;
pub extern fn IsGamepadButtonUp(gamepad: c_int, button: c_int) bool;
pub extern fn GetGamepadButtonPressed() c_int;
pub extern fn GetGamepadAxisCount(gamepad: c_int) c_int;
pub extern fn GetGamepadAxisMovement(gamepad: c_int, axis: c_int) f32;
pub extern fn IsMouseButtonPressed(button: c_int) bool;
pub extern fn IsMouseButtonDown(button: c_int) bool;
pub extern fn IsMouseButtonReleased(button: c_int) bool;
pub extern fn IsMouseButtonUp(button: c_int) bool;
pub extern fn GetMouseX() c_int;
pub extern fn GetMouseY() c_int;
pub extern fn GetMousePosition() Vector2;
pub extern fn SetMousePosition(x: c_int, y: c_int) void;
pub extern fn SetMouseOffset(offsetX: c_int, offsetY: c_int) void;
pub extern fn SetMouseScale(scaleX: f32, scaleY: f32) void;
pub extern fn GetMouseWheelMove() c_int;
pub extern fn GetTouchX() c_int;
pub extern fn GetTouchY() c_int;
pub extern fn GetTouchPosition(index: c_int) Vector2;
pub extern fn SetGesturesEnabled(gestureFlags: c_uint) void;
pub extern fn IsGestureDetected(gesture: c_int) bool;
pub extern fn GetGestureDetected() c_int;
pub extern fn GetTouchPointsCount() c_int;
pub extern fn GetGestureHoldDuration() f32;
pub extern fn GetGestureDragVector() Vector2;
pub extern fn GetGestureDragAngle() f32;
pub extern fn GetGesturePinchVector() Vector2;
pub extern fn GetGesturePinchAngle() f32;
pub extern fn SetCameraMode(camera: Camera, mode: c_int) void;
pub extern fn UpdateCamera(camera: [*c]Camera) void;
pub extern fn SetCameraPanControl(panKey: c_int) void;
pub extern fn SetCameraAltControl(altKey: c_int) void;
pub extern fn SetCameraSmoothZoomControl(szKey: c_int) void;
pub extern fn SetCameraMoveControls(frontKey: c_int, backKey: c_int, rightKey: c_int, leftKey: c_int, upKey: c_int, downKey: c_int) void;
pub extern fn DrawPixel(posX: c_int, posY: c_int, color: Color) void;
pub extern fn DrawPixelVShim(position: * const Vector2, color: Color)  void;
pub        fn DrawPixelV(position: Vector2, color: Color) void {
    DrawPixelVShim(&position, color);
}
pub extern fn DrawLine(startPosX: c_int, startPosY: c_int, endPosX: c_int, endPosY: c_int, color: Color) void;
pub extern fn DrawLineVShim(startPos: * const Vector2, endPos: * const Vector2, color: Color)  void;
pub        fn DrawLineV(startPos: Vector2, endPos: Vector2, color: Color) void {
    DrawLineVShim(&startPos, &endPos, color);
}
pub extern fn DrawLineExShim(startPos: * const Vector2, endPos: * const Vector2, thick: f32, color: Color)  void;
pub        fn DrawLineEx(startPos: Vector2, endPos: Vector2, thick: f32, color: Color) void {
    DrawLineExShim(&startPos, &endPos, thick, color);
}
pub extern fn DrawLineBezierShim(startPos: * const Vector2, endPos: * const Vector2, thick: f32, color: Color)  void;
pub        fn DrawLineBezier(startPos: Vector2, endPos: Vector2, thick: f32, color: Color) void {
    DrawLineBezierShim(&startPos, &endPos, thick, color);
}
pub extern fn DrawLineStrip(points: [*c]Vector2, numPoints: c_int, color: Color) void;
pub extern fn DrawCircle(centerX: c_int, centerY: c_int, radius: f32, color: Color) void;
pub extern fn DrawCircleSectorShim(center: * const Vector2, radius: f32, startAngle: c_int, endAngle: c_int, segments: c_int, color: Color)  void;
pub        fn DrawCircleSector(center: Vector2, radius: f32, startAngle: c_int, endAngle: c_int, segments: c_int, color: Color) void {
    DrawCircleSectorShim(&center, radius, startAngle, endAngle, segments, color);
}
pub extern fn DrawCircleSectorLinesShim(center: * const Vector2, radius: f32, startAngle: c_int, endAngle: c_int, segments: c_int, color: Color)  void;
pub        fn DrawCircleSectorLines(center: Vector2, radius: f32, startAngle: c_int, endAngle: c_int, segments: c_int, color: Color) void {
    DrawCircleSectorLinesShim(&center, radius, startAngle, endAngle, segments, color);
}
pub extern fn DrawCircleGradient(centerX: c_int, centerY: c_int, radius: f32, color1: Color, color2: Color) void;
pub extern fn DrawCircleVShim(center: * const Vector2, radius: f32, color: Color)  void;
pub        fn DrawCircleV(center: Vector2, radius: f32, color: Color) void {
    DrawCircleVShim(&center, radius, color);
}
pub extern fn DrawCircleLines(centerX: c_int, centerY: c_int, radius: f32, color: Color) void;
pub extern fn DrawEllipse(centerX: c_int, centerY: c_int, radiusH: f32, radiusV: f32, color: Color) void;
pub extern fn DrawEllipseLines(centerX: c_int, centerY: c_int, radiusH: f32, radiusV: f32, color: Color) void;
pub extern fn DrawRingShim(center: * const Vector2, innerRadius: f32, outerRadius: f32, startAngle: c_int, endAngle: c_int, segments: c_int, color: Color)  void;
pub        fn DrawRing(center: Vector2, innerRadius: f32, outerRadius: f32, startAngle: c_int, endAngle: c_int, segments: c_int, color: Color) void {
    DrawRingShim(&center, innerRadius, outerRadius, startAngle, endAngle, segments, color);
}
pub extern fn DrawRingLinesShim(center: * const Vector2, innerRadius: f32, outerRadius: f32, startAngle: c_int, endAngle: c_int, segments: c_int, color: Color)  void;
pub        fn DrawRingLines(center: Vector2, innerRadius: f32, outerRadius: f32, startAngle: c_int, endAngle: c_int, segments: c_int, color: Color) void {
    DrawRingLinesShim(&center, innerRadius, outerRadius, startAngle, endAngle, segments, color);
}
pub extern fn DrawRectangle(posX: c_int, posY: c_int, width: c_int, height: c_int, color: Color) void;
pub extern fn DrawRectangleVShim(position: * const Vector2, size: * const Vector2, color: Color)  void;
pub        fn DrawRectangleV(position: Vector2, size: Vector2, color: Color) void {
    DrawRectangleVShim(&position, &size, color);
}
pub extern fn DrawRectangleRecShim(rec: * const Rectangle, color: Color)  void;
pub        fn DrawRectangleRec(rec: Rectangle, color: Color) void {
    DrawRectangleRecShim(&rec, color);
}
pub extern fn DrawRectangleProShim(rec: * const Rectangle, origin: * const Vector2, rotation: f32, color: Color)  void;
pub        fn DrawRectanglePro(rec: Rectangle, origin: Vector2, rotation: f32, color: Color) void {
    DrawRectangleProShim(&rec, &origin, rotation, color);
}
pub extern fn DrawRectangleGradientV(posX: c_int, posY: c_int, width: c_int, height: c_int, color1: Color, color2: Color) void;
pub extern fn DrawRectangleGradientH(posX: c_int, posY: c_int, width: c_int, height: c_int, color1: Color, color2: Color) void;
pub extern fn DrawRectangleGradientExShim(rec: * const Rectangle, col1: Color, col2: Color, col3: Color, col4: Color)  void;
pub        fn DrawRectangleGradientEx(rec: Rectangle, col1: Color, col2: Color, col3: Color, col4: Color) void {
    DrawRectangleGradientExShim(&rec, col1, col2, col3, col4);
}
pub extern fn DrawRectangleLines(posX: c_int, posY: c_int, width: c_int, height: c_int, color: Color) void;
pub extern fn DrawRectangleLinesExShim(rec: * const Rectangle, lineThick: c_int, color: Color)  void;
pub        fn DrawRectangleLinesEx(rec: Rectangle, lineThick: c_int, color: Color) void {
    DrawRectangleLinesExShim(&rec, lineThick, color);
}
pub extern fn DrawRectangleRoundedShim(rec: * const Rectangle, roundness: f32, segments: c_int, color: Color)  void;
pub        fn DrawRectangleRounded(rec: Rectangle, roundness: f32, segments: c_int, color: Color) void {
    DrawRectangleRoundedShim(&rec, roundness, segments, color);
}
pub extern fn DrawRectangleRoundedLinesShim(rec: * const Rectangle, roundness: f32, segments: c_int, lineThick: c_int, color: Color)  void;
pub        fn DrawRectangleRoundedLines(rec: Rectangle, roundness: f32, segments: c_int, lineThick: c_int, color: Color) void {
    DrawRectangleRoundedLinesShim(&rec, roundness, segments, lineThick, color);
}
pub extern fn DrawTriangleShim(v1: * const Vector2, v2: * const Vector2, v3: * const Vector2, color: Color)  void;
pub        fn DrawTriangle(v1: Vector2, v2: Vector2, v3: Vector2, color: Color) void {
    DrawTriangleShim(&v1, &v2, &v3, color);
}
pub extern fn DrawTriangleLinesShim(v1: * const Vector2, v2: * const Vector2, v3: * const Vector2, color: Color)  void;
pub        fn DrawTriangleLines(v1: Vector2, v2: Vector2, v3: Vector2, color: Color) void {
    DrawTriangleLinesShim(&v1, &v2, &v3, color);
}
pub extern fn DrawTriangleFan(points: [*c]Vector2, numPoints: c_int, color: Color) void;
pub extern fn DrawTriangleStrip(points: [*c]Vector2, pointsCount: c_int, color: Color) void;
pub extern fn DrawPolyShim(center: * const Vector2, sides: c_int, radius: f32, rotation: f32, color: Color)  void;
pub        fn DrawPoly(center: Vector2, sides: c_int, radius: f32, rotation: f32, color: Color) void {
    DrawPolyShim(&center, sides, radius, rotation, color);
}
pub extern fn DrawPolyLinesShim(center: * const Vector2, sides: c_int, radius: f32, rotation: f32, color: Color)  void;
pub        fn DrawPolyLines(center: Vector2, sides: c_int, radius: f32, rotation: f32, color: Color) void {
    DrawPolyLinesShim(&center, sides, radius, rotation, color);
}
pub extern fn CheckCollisionRecsShim(rec1: * const Rectangle, rec2: * const Rectangle)  bool;
pub        fn CheckCollisionRecs(rec1: Rectangle, rec2: Rectangle) bool {
   return  CheckCollisionRecsShim(&rec1, &rec2);
}
pub extern fn CheckCollisionCirclesShim(center1: * const Vector2, radius1: f32, center2: * const Vector2, radius2: f32)  bool;
pub        fn CheckCollisionCircles(center1: Vector2, radius1: f32, center2: Vector2, radius2: f32) bool {
   return  CheckCollisionCirclesShim(&center1, radius1, &center2, radius2);
}
pub extern fn CheckCollisionCircleRecShim(center: * const Vector2, radius: f32, rec: * const Rectangle)  bool;
pub        fn CheckCollisionCircleRec(center: Vector2, radius: f32, rec: Rectangle) bool {
   return  CheckCollisionCircleRecShim(&center, radius, &rec);
}
pub extern fn GetCollisionRecShim(rec1: * const Rectangle, rec2: * const Rectangle)  Rectangle;
pub        fn GetCollisionRec(rec1: Rectangle, rec2: Rectangle) Rectangle {
   return  GetCollisionRecShim(&rec1, &rec2);
}
pub extern fn CheckCollisionPointRecShim(point: * const Vector2, rec: * const Rectangle)  bool;
pub        fn CheckCollisionPointRec(point: Vector2, rec: Rectangle) bool {
   return  CheckCollisionPointRecShim(&point, &rec);
}
pub extern fn CheckCollisionPointCircleShim(point: * const Vector2, center: * const Vector2, radius: f32)  bool;
pub        fn CheckCollisionPointCircle(point: Vector2, center: Vector2, radius: f32) bool {
   return  CheckCollisionPointCircleShim(&point, &center, radius);
}
pub extern fn CheckCollisionPointTriangleShim(point: * const Vector2, p1: * const Vector2, p2: * const Vector2, p3: * const Vector2)  bool;
pub        fn CheckCollisionPointTriangle(point: Vector2, p1: Vector2, p2: Vector2, p3: Vector2) bool {
   return  CheckCollisionPointTriangleShim(&point, &p1, &p2, &p3);
}
pub extern fn LoadImage(fileName: [*c]const u8) Image;
pub extern fn LoadImageEx(pixels: [*c]Color, width: c_int, height: c_int) Image;
pub extern fn LoadImagePro(data: ?*c_void, width: c_int, height: c_int, format: c_int) Image;
pub extern fn LoadImageRaw(fileName: [*c]const u8, width: c_int, height: c_int, format: c_int, headerSize: c_int) Image;
pub extern fn ExportImage(image: Image, fileName: [*c]const u8) void;
pub extern fn ExportImageAsCode(image: Image, fileName: [*c]const u8) void;
pub extern fn LoadTexture(fileName: [*c]const u8) Texture2D;
pub extern fn LoadTextureFromImage(image: Image) Texture2D;
pub extern fn LoadTextureCubemap(image: Image, layoutType: c_int) TextureCubemap;
pub extern fn LoadRenderTexture(width: c_int, height: c_int) RenderTexture2D;
pub extern fn UnloadImage(image: Image) void;
pub extern fn UnloadTexture(texture: Texture2D) void;
pub extern fn UnloadRenderTexture(target: RenderTexture2D) void;
pub extern fn GetImageData(image: Image) [*c]Color;
pub extern fn GetImageDataNormalized(image: Image) [*c]Vector4;
pub extern fn GetImageAlphaBorder(image: Image, threshold: f32) Rectangle;
pub extern fn GetPixelDataSize(width: c_int, height: c_int, format: c_int) c_int;
pub extern fn GetTextureData(texture: Texture2D) Image;
pub extern fn GetScreenData() Image;
pub extern fn UpdateTexture(texture: Texture2D, pixels: ?*const c_void) void;
pub extern fn ImageCopy(image: Image) Image;
pub extern fn ImageFromImageShim(image: Image, rec: * const Rectangle)  Image;
pub        fn ImageFromImage(image: Image, rec: Rectangle) Image {
   return  ImageFromImageShim(image, &rec);
}
pub extern fn ImageToPOT(image: [*c]Image, fillColor: Color) void;
pub extern fn ImageFormat(image: [*c]Image, newFormat: c_int) void;
pub extern fn ImageAlphaMask(image: [*c]Image, alphaMask: Image) void;
pub extern fn ImageAlphaClear(image: [*c]Image, color: Color, threshold: f32) void;
pub extern fn ImageAlphaCrop(image: [*c]Image, threshold: f32) void;
pub extern fn ImageAlphaPremultiply(image: [*c]Image) void;
pub extern fn ImageCropShim(image: [*c]Image, crop: * const Rectangle)  void;
pub        fn ImageCrop(image: [*c]Image, crop: Rectangle) void {
    ImageCropShim(image, &crop);
}
pub extern fn ImageResize(image: [*c]Image, newWidth: c_int, newHeight: c_int) void;
pub extern fn ImageResizeNN(image: [*c]Image, newWidth: c_int, newHeight: c_int) void;
pub extern fn ImageResizeCanvas(image: [*c]Image, newWidth: c_int, newHeight: c_int, offsetX: c_int, offsetY: c_int, color: Color) void;
pub extern fn ImageMipmaps(image: [*c]Image) void;
pub extern fn ImageDither(image: [*c]Image, rBpp: c_int, gBpp: c_int, bBpp: c_int, aBpp: c_int) void;
pub extern fn ImageExtractPalette(image: Image, maxPaletteSize: c_int, extractCount: [*c]c_int) [*c]Color;
pub extern fn ImageText(text: [*c]const u8, fontSize: c_int, color: Color) Image;
pub extern fn ImageTextEx(font: Font, text: [*c]const u8, fontSize: f32, spacing: f32, tint: Color) Image;
pub extern fn ImageDrawShim(dst: [*c]Image, src: Image, srcRec: * const Rectangle, dstRec: * const Rectangle, tint: Color)  void;
pub        fn ImageDraw(dst: [*c]Image, src: Image, srcRec: Rectangle, dstRec: Rectangle, tint: Color) void {
    ImageDrawShim(dst, src, &srcRec, &dstRec, tint);
}
pub extern fn ImageDrawRectangleShim(dst: [*c]Image, rec: * const Rectangle, color: Color)  void;
pub        fn ImageDrawRectangle(dst: [*c]Image, rec: Rectangle, color: Color) void {
    ImageDrawRectangleShim(dst, &rec, color);
}
pub extern fn ImageDrawRectangleLinesShim(dst: [*c]Image, rec: * const Rectangle, thick: c_int, color: Color)  void;
pub        fn ImageDrawRectangleLines(dst: [*c]Image, rec: Rectangle, thick: c_int, color: Color) void {
    ImageDrawRectangleLinesShim(dst, &rec, thick, color);
}
pub extern fn ImageDrawTextShim(dst: [*c]Image, position: * const Vector2, text: [*c]const u8, fontSize: c_int, color: Color)  void;
pub        fn ImageDrawText(dst: [*c]Image, position: Vector2, text: [*c]const u8, fontSize: c_int, color: Color) void {
    ImageDrawTextShim(dst, &position, text, fontSize, color);
}
pub extern fn ImageDrawTextExShim(dst: [*c]Image, position: * const Vector2, font: Font, text: [*c]const u8, fontSize: f32, spacing: f32, color: Color)  void;
pub        fn ImageDrawTextEx(dst: [*c]Image, position: Vector2, font: Font, text: [*c]const u8, fontSize: f32, spacing: f32, color: Color) void {
    ImageDrawTextExShim(dst, &position, font, text, fontSize, spacing, color);
}
pub extern fn ImageFlipVertical(image: [*c]Image) void;
pub extern fn ImageFlipHorizontal(image: [*c]Image) void;
pub extern fn ImageRotateCW(image: [*c]Image) void;
pub extern fn ImageRotateCCW(image: [*c]Image) void;
pub extern fn ImageColorTint(image: [*c]Image, color: Color) void;
pub extern fn ImageColorInvert(image: [*c]Image) void;
pub extern fn ImageColorGrayscale(image: [*c]Image) void;
pub extern fn ImageColorContrast(image: [*c]Image, contrast: f32) void;
pub extern fn ImageColorBrightness(image: [*c]Image, brightness: c_int) void;
pub extern fn ImageColorReplace(image: [*c]Image, color: Color, replace: Color) void;
pub extern fn GenImageColor(width: c_int, height: c_int, color: Color) Image;
pub extern fn GenImageGradientV(width: c_int, height: c_int, top: Color, bottom: Color) Image;
pub extern fn GenImageGradientH(width: c_int, height: c_int, left: Color, right: Color) Image;
pub extern fn GenImageGradientRadial(width: c_int, height: c_int, density: f32, inner: Color, outer: Color) Image;
pub extern fn GenImageChecked(width: c_int, height: c_int, checksX: c_int, checksY: c_int, col1: Color, col2: Color) Image;
pub extern fn GenImageWhiteNoise(width: c_int, height: c_int, factor: f32) Image;
pub extern fn GenImagePerlinNoise(width: c_int, height: c_int, offsetX: c_int, offsetY: c_int, scale: f32) Image;
pub extern fn GenImageCellular(width: c_int, height: c_int, tileSize: c_int) Image;
pub extern fn GenTextureMipmaps(texture: [*c]Texture2D) void;
pub extern fn SetTextureFilter(texture: Texture2D, filterMode: c_int) void;
pub extern fn SetTextureWrap(texture: Texture2D, wrapMode: c_int) void;
pub extern fn DrawTexture(texture: Texture2D, posX: c_int, posY: c_int, tint: Color) void;
pub extern fn DrawTextureVShim(texture: Texture2D, position: * const Vector2, tint: Color)  void;
pub        fn DrawTextureV(texture: Texture2D, position: Vector2, tint: Color) void {
    DrawTextureVShim(texture, &position, tint);
}
pub extern fn DrawTextureExShim(texture: Texture2D, position: * const Vector2, rotation: f32, scale: f32, tint: Color)  void;
pub        fn DrawTextureEx(texture: Texture2D, position: Vector2, rotation: f32, scale: f32, tint: Color) void {
    DrawTextureExShim(texture, &position, rotation, scale, tint);
}
pub extern fn DrawTextureRecShim(texture: Texture2D, sourceRec: * const Rectangle, position: * const Vector2, tint: Color)  void;
pub        fn DrawTextureRec(texture: Texture2D, sourceRec: Rectangle, position: Vector2, tint: Color) void {
    DrawTextureRecShim(texture, &sourceRec, &position, tint);
}
pub extern fn DrawTextureQuadShim(texture: Texture2D, tiling: * const Vector2, offset: * const Vector2, quad: * const Rectangle, tint: Color)  void;
pub        fn DrawTextureQuad(texture: Texture2D, tiling: Vector2, offset: Vector2, quad: Rectangle, tint: Color) void {
    DrawTextureQuadShim(texture, &tiling, &offset, &quad, tint);
}
pub extern fn DrawTextureProShim(texture: Texture2D, sourceRec: * const Rectangle, destRec: * const Rectangle, origin: * const Vector2, rotation: f32, tint: Color)  void;
pub        fn DrawTexturePro(texture: Texture2D, sourceRec: Rectangle, destRec: Rectangle, origin: Vector2, rotation: f32, tint: Color) void {
    DrawTextureProShim(texture, &sourceRec, &destRec, &origin, rotation, tint);
}
pub extern fn DrawTextureNPatchShim(texture: Texture2D, nPatchInfo: NPatchInfo, destRec: * const Rectangle, origin: * const Vector2, rotation: f32, tint: Color)  void;
pub        fn DrawTextureNPatch(texture: Texture2D, nPatchInfo: NPatchInfo, destRec: Rectangle, origin: Vector2, rotation: f32, tint: Color) void {
    DrawTextureNPatchShim(texture, nPatchInfo, &destRec, &origin, rotation, tint);
}
pub extern fn GetFontDefault() Font;
pub extern fn LoadFont(fileName: [*c]const u8) Font;
pub extern fn LoadFontEx(fileName: [*c]const u8, fontSize: c_int, fontChars: [*c]c_int, charsCount: c_int) Font;
pub extern fn LoadFontFromImage(image: Image, key: Color, firstChar: c_int) Font;
pub extern fn LoadFontData(fileName: [*c]const u8, fontSize: c_int, fontChars: [*c]c_int, charsCount: c_int, type: c_int) [*c]CharInfo;
pub extern fn GenImageFontAtlas(chars: [*c]const CharInfo, recs: [*c][*c]Rectangle, charsCount: c_int, fontSize: c_int, padding: c_int, packMethod: c_int) Image;
pub extern fn UnloadFont(font: Font) void;
pub extern fn DrawFPS(posX: c_int, posY: c_int) void;
pub extern fn DrawText(text: [*c]const u8, posX: c_int, posY: c_int, fontSize: c_int, color: Color) void;
pub extern fn DrawTextExShim(font: Font, text: [*c]const u8, position: * const Vector2, fontSize: f32, spacing: f32, tint: Color)  void;
pub        fn DrawTextEx(font: Font, text: [*c]const u8, position: Vector2, fontSize: f32, spacing: f32, tint: Color) void {
    DrawTextExShim(font, text, &position, fontSize, spacing, tint);
}
pub extern fn DrawTextRecShim(font: Font, text: [*c]const u8, rec: * const Rectangle, fontSize: f32, spacing: f32, wordWrap: bool, tint: Color)  void;
pub        fn DrawTextRec(font: Font, text: [*c]const u8, rec: Rectangle, fontSize: f32, spacing: f32, wordWrap: bool, tint: Color) void {
    DrawTextRecShim(font, text, &rec, fontSize, spacing, wordWrap, tint);
}
pub extern fn DrawTextRecExShim(font: Font, text: [*c]const u8, rec: * const Rectangle, fontSize: f32, spacing: f32, wordWrap: bool, tint: Color, selectStart: c_int, selectLength: c_int, selectTint: Color, selectBackTint: Color)  void;
pub        fn DrawTextRecEx(font: Font, text: [*c]const u8, rec: Rectangle, fontSize: f32, spacing: f32, wordWrap: bool, tint: Color, selectStart: c_int, selectLength: c_int, selectTint: Color, selectBackTint: Color) void {
    DrawTextRecExShim(font, text, &rec, fontSize, spacing, wordWrap, tint, selectStart, selectLength, selectTint, selectBackTint);
}
pub extern fn DrawTextCodepointShim(font: Font, codepoint: c_int, position: * const Vector2, scale: f32, tint: Color)  void;
pub        fn DrawTextCodepoint(font: Font, codepoint: c_int, position: Vector2, scale: f32, tint: Color) void {
    DrawTextCodepointShim(font, codepoint, &position, scale, tint);
}
pub extern fn MeasureText(text: [*c]const u8, fontSize: c_int) c_int;
pub extern fn MeasureTextEx(font: Font, text: [*c]const u8, fontSize: f32, spacing: f32) Vector2;
pub extern fn GetGlyphIndex(font: Font, codepoint: c_int) c_int;
pub extern fn TextCopy(dst: [*c]u8, src: [*c]const u8) c_int;
pub extern fn TextIsEqual(text1: [*c]const u8, text2: [*c]const u8) bool;
pub extern fn TextLength(text: [*c]const u8) c_uint;
pub extern fn TextFormat(text: [*c]const u8, ...) [*c]const u8;
pub extern fn TextSubtext(text: [*c]const u8, position: c_int, length: c_int) [*c]const u8;
pub extern fn TextReplace(text: [*c]u8, replace: [*c]const u8, by: [*c]const u8) [*c]u8;
pub extern fn TextInsert(text: [*c]const u8, insert: [*c]const u8, position: c_int) [*c]u8;
pub extern fn TextJoin(textList: [*c][*c]const u8, count: c_int, delimiter: [*c]const u8) [*c]const u8;
pub extern fn TextSplit(text: [*c]const u8, delimiter: u8, count: [*c]c_int) [*c][*c]const u8;
pub extern fn TextAppend(text: [*c]u8, append: [*c]const u8, position: [*c]c_int) void;
pub extern fn TextFindIndex(text: [*c]const u8, find: [*c]const u8) c_int;
pub extern fn TextToUpper(text: [*c]const u8) [*c]const u8;
pub extern fn TextToLower(text: [*c]const u8) [*c]const u8;
pub extern fn TextToPascal(text: [*c]const u8) [*c]const u8;
pub extern fn TextToInteger(text: [*c]const u8) c_int;
pub extern fn TextToUtf8(codepoints: [*c]c_int, length: c_int) [*c]u8;
pub extern fn GetCodepoints(text: [*c]const u8, count: [*c]c_int) [*c]c_int;
pub extern fn GetCodepointsCount(text: [*c]const u8) c_int;
pub extern fn GetNextCodepoint(text: [*c]const u8, bytesProcessed: [*c]c_int) c_int;
pub extern fn CodepointToUtf8(codepoint: c_int, byteLength: [*c]c_int) [*c]const u8;
pub extern fn DrawLine3DShim(startPos: * const Vector3, endPos: * const Vector3, color: Color)  void;
pub        fn DrawLine3D(startPos: Vector3, endPos: Vector3, color: Color) void {
    DrawLine3DShim(&startPos, &endPos, color);
}
pub extern fn DrawPoint3DShim(position: * const Vector3, color: Color)  void;
pub        fn DrawPoint3D(position: Vector3, color: Color) void {
    DrawPoint3DShim(&position, color);
}
pub extern fn DrawCircle3DShim(center: * const Vector3, radius: f32, rotationAxis: * const Vector3, rotationAngle: f32, color: Color)  void;
pub        fn DrawCircle3D(center: Vector3, radius: f32, rotationAxis: Vector3, rotationAngle: f32, color: Color) void {
    DrawCircle3DShim(&center, radius, &rotationAxis, rotationAngle, color);
}
pub extern fn DrawCubeShim(position: * const Vector3, width: f32, height: f32, length: f32, color: Color)  void;
pub        fn DrawCube(position: Vector3, width: f32, height: f32, length: f32, color: Color) void {
    DrawCubeShim(&position, width, height, length, color);
}
pub extern fn DrawCubeVShim(position: * const Vector3, size: * const Vector3, color: Color)  void;
pub        fn DrawCubeV(position: Vector3, size: Vector3, color: Color) void {
    DrawCubeVShim(&position, &size, color);
}
pub extern fn DrawCubeWiresShim(position: * const Vector3, width: f32, height: f32, length: f32, color: Color)  void;
pub        fn DrawCubeWires(position: Vector3, width: f32, height: f32, length: f32, color: Color) void {
    DrawCubeWiresShim(&position, width, height, length, color);
}
pub extern fn DrawCubeWiresVShim(position: * const Vector3, size: * const Vector3, color: Color)  void;
pub        fn DrawCubeWiresV(position: Vector3, size: Vector3, color: Color) void {
    DrawCubeWiresVShim(&position, &size, color);
}
pub extern fn DrawCubeTextureShim(texture: Texture2D, position: * const Vector3, width: f32, height: f32, length: f32, color: Color)  void;
pub        fn DrawCubeTexture(texture: Texture2D, position: Vector3, width: f32, height: f32, length: f32, color: Color) void {
    DrawCubeTextureShim(texture, &position, width, height, length, color);
}
pub extern fn DrawSphereShim(centerPos: * const Vector3, radius: f32, color: Color)  void;
pub        fn DrawSphere(centerPos: Vector3, radius: f32, color: Color) void {
    DrawSphereShim(&centerPos, radius, color);
}
pub extern fn DrawSphereExShim(centerPos: * const Vector3, radius: f32, rings: c_int, slices: c_int, color: Color)  void;
pub        fn DrawSphereEx(centerPos: Vector3, radius: f32, rings: c_int, slices: c_int, color: Color) void {
    DrawSphereExShim(&centerPos, radius, rings, slices, color);
}
pub extern fn DrawSphereWiresShim(centerPos: * const Vector3, radius: f32, rings: c_int, slices: c_int, color: Color)  void;
pub        fn DrawSphereWires(centerPos: Vector3, radius: f32, rings: c_int, slices: c_int, color: Color) void {
    DrawSphereWiresShim(&centerPos, radius, rings, slices, color);
}
pub extern fn DrawCylinderShim(position: * const Vector3, radiusTop: f32, radiusBottom: f32, height: f32, slices: c_int, color: Color)  void;
pub        fn DrawCylinder(position: Vector3, radiusTop: f32, radiusBottom: f32, height: f32, slices: c_int, color: Color) void {
    DrawCylinderShim(&position, radiusTop, radiusBottom, height, slices, color);
}
pub extern fn DrawCylinderWiresShim(position: * const Vector3, radiusTop: f32, radiusBottom: f32, height: f32, slices: c_int, color: Color)  void;
pub        fn DrawCylinderWires(position: Vector3, radiusTop: f32, radiusBottom: f32, height: f32, slices: c_int, color: Color) void {
    DrawCylinderWiresShim(&position, radiusTop, radiusBottom, height, slices, color);
}
pub extern fn DrawPlaneShim(centerPos: * const Vector3, size: * const Vector2, color: Color)  void;
pub        fn DrawPlane(centerPos: Vector3, size: Vector2, color: Color) void {
    DrawPlaneShim(&centerPos, &size, color);
}
pub extern fn DrawRay(ray: Ray, color: Color) void;
pub extern fn DrawGrid(slices: c_int, spacing: f32) void;
pub extern fn DrawGizmoShim(position: * const Vector3)  void;
pub        fn DrawGizmo(position: Vector3) void {
    DrawGizmoShim(&position);
}
pub extern fn LoadModel(fileName: [*c]const u8) Model;
pub extern fn LoadModelFromMesh(mesh: Mesh) Model;
pub extern fn UnloadModel(model: Model) void;
pub extern fn LoadMeshes(fileName: [*c]const u8, meshCount: [*c]c_int) [*c]Mesh;
pub extern fn ExportMesh(mesh: Mesh, fileName: [*c]const u8) void;
pub extern fn UnloadMesh(mesh: Mesh) void;
pub extern fn LoadMaterials(fileName: [*c]const u8, materialCount: [*c]c_int) [*c]Material;
pub extern fn LoadMaterialDefault() Material;
pub extern fn UnloadMaterial(material: Material) void;
pub extern fn SetMaterialTexture(material: [*c]Material, mapType: c_int, texture: Texture2D) void;
pub extern fn SetModelMeshMaterial(model: [*c]Model, meshId: c_int, materialId: c_int) void;
pub extern fn LoadModelAnimations(fileName: [*c]const u8, animsCount: [*c]c_int) [*c]ModelAnimation;
pub extern fn UpdateModelAnimation(model: Model, anim: ModelAnimation, frame: c_int) void;
pub extern fn UnloadModelAnimation(anim: ModelAnimation) void;
pub extern fn IsModelAnimationValid(model: Model, anim: ModelAnimation) bool;
pub extern fn GenMeshPoly(sides: c_int, radius: f32) Mesh;
pub extern fn GenMeshPlane(width: f32, length: f32, resX: c_int, resZ: c_int) Mesh;
pub extern fn GenMeshCube(width: f32, height: f32, length: f32) Mesh;
pub extern fn GenMeshSphere(radius: f32, rings: c_int, slices: c_int) Mesh;
pub extern fn GenMeshHemiSphere(radius: f32, rings: c_int, slices: c_int) Mesh;
pub extern fn GenMeshCylinder(radius: f32, height: f32, slices: c_int) Mesh;
pub extern fn GenMeshTorus(radius: f32, size: f32, radSeg: c_int, sides: c_int) Mesh;
pub extern fn GenMeshKnot(radius: f32, size: f32, radSeg: c_int, sides: c_int) Mesh;
pub extern fn GenMeshHeightmapShim(heightmap: Image, size: * const Vector3)  Mesh;
pub        fn GenMeshHeightmap(heightmap: Image, size: Vector3) Mesh {
   return  GenMeshHeightmapShim(heightmap, &size);
}
pub extern fn GenMeshCubicmapShim(cubicmap: Image, cubeSize: * const Vector3)  Mesh;
pub        fn GenMeshCubicmap(cubicmap: Image, cubeSize: Vector3) Mesh {
   return  GenMeshCubicmapShim(cubicmap, &cubeSize);
}
pub extern fn MeshBoundingBox(mesh: Mesh) BoundingBox;
pub extern fn MeshTangents(mesh: [*c]Mesh) void;
pub extern fn MeshBinormals(mesh: [*c]Mesh) void;
pub extern fn DrawModelShim(model: Model, position: * const Vector3, scale: f32, tint: Color)  void;
pub        fn DrawModel(model: Model, position: Vector3, scale: f32, tint: Color) void {
    DrawModelShim(model, &position, scale, tint);
}
pub extern fn DrawModelExShim(model: Model, position: * const Vector3, rotationAxis: * const Vector3, rotationAngle: f32, scale: * const Vector3, tint: Color)  void;
pub        fn DrawModelEx(model: Model, position: Vector3, rotationAxis: Vector3, rotationAngle: f32, scale: Vector3, tint: Color) void {
    DrawModelExShim(model, &position, &rotationAxis, rotationAngle, &scale, tint);
}
pub extern fn DrawModelWiresShim(model: Model, position: * const Vector3, scale: f32, tint: Color)  void;
pub        fn DrawModelWires(model: Model, position: Vector3, scale: f32, tint: Color) void {
    DrawModelWiresShim(model, &position, scale, tint);
}
pub extern fn DrawModelWiresExShim(model: Model, position: * const Vector3, rotationAxis: * const Vector3, rotationAngle: f32, scale: * const Vector3, tint: Color)  void;
pub        fn DrawModelWiresEx(model: Model, position: Vector3, rotationAxis: Vector3, rotationAngle: f32, scale: Vector3, tint: Color) void {
    DrawModelWiresExShim(model, &position, &rotationAxis, rotationAngle, &scale, tint);
}
pub extern fn DrawBoundingBox(box: BoundingBox, color: Color) void;
pub extern fn DrawBillboardShim(camera: Camera, texture: Texture2D, center: * const Vector3, size: f32, tint: Color)  void;
pub        fn DrawBillboard(camera: Camera, texture: Texture2D, center: Vector3, size: f32, tint: Color) void {
    DrawBillboardShim(camera, texture, &center, size, tint);
}
pub extern fn DrawBillboardRecShim(camera: Camera, texture: Texture2D, sourceRec: * const Rectangle, center: * const Vector3, size: f32, tint: Color)  void;
pub        fn DrawBillboardRec(camera: Camera, texture: Texture2D, sourceRec: Rectangle, center: Vector3, size: f32, tint: Color) void {
    DrawBillboardRecShim(camera, texture, &sourceRec, &center, size, tint);
}
pub extern fn CheckCollisionSpheresShim(centerA: * const Vector3, radiusA: f32, centerB: * const Vector3, radiusB: f32)  bool;
pub        fn CheckCollisionSpheres(centerA: Vector3, radiusA: f32, centerB: Vector3, radiusB: f32) bool {
   return  CheckCollisionSpheresShim(&centerA, radiusA, &centerB, radiusB);
}
pub extern fn CheckCollisionBoxes(box1: BoundingBox, box2: BoundingBox) bool;
pub extern fn CheckCollisionBoxSphereShim(box: BoundingBox, center: * const Vector3, radius: f32)  bool;
pub        fn CheckCollisionBoxSphere(box: BoundingBox, center: Vector3, radius: f32) bool {
   return  CheckCollisionBoxSphereShim(box, &center, radius);
}
pub extern fn CheckCollisionRaySphereShim(ray: Ray, center: * const Vector3, radius: f32)  bool;
pub        fn CheckCollisionRaySphere(ray: Ray, center: Vector3, radius: f32) bool {
   return  CheckCollisionRaySphereShim(ray, &center, radius);
}
pub extern fn CheckCollisionRaySphereExShim(ray: Ray, center: * const Vector3, radius: f32, collisionPoint: [*c]Vector3)  bool;
pub        fn CheckCollisionRaySphereEx(ray: Ray, center: Vector3, radius: f32, collisionPoint: [*c]Vector3) bool {
   return  CheckCollisionRaySphereExShim(ray, &center, radius, collisionPoint);
}
pub extern fn CheckCollisionRayBox(ray: Ray, box: BoundingBox) bool;
pub extern fn GetCollisionRayModel(ray: Ray, model: Model) RayHitInfo;
pub extern fn GetCollisionRayTriangleShim(ray: Ray, p1: * const Vector3, p2: * const Vector3, p3: * const Vector3)  RayHitInfo;
pub        fn GetCollisionRayTriangle(ray: Ray, p1: Vector3, p2: Vector3, p3: Vector3) RayHitInfo {
   return  GetCollisionRayTriangleShim(ray, &p1, &p2, &p3);
}
pub extern fn GetCollisionRayGround(ray: Ray, groundHeight: f32) RayHitInfo;
pub extern fn LoadText(fileName: [*c]const u8) [*c]u8;
pub extern fn LoadShader(vsFileName: [*c]const u8, fsFileName: [*c]const u8) Shader;
pub extern fn LoadShaderCode(vsCode: [*c]const u8, fsCode: [*c]const u8) Shader;
pub extern fn UnloadShader(shader: Shader) void;
pub extern fn GetShaderDefault() Shader;
pub extern fn GetTextureDefault() Texture2D;
pub extern fn GetShapesTexture() Texture2D;
pub extern fn GetShapesTextureRec() Rectangle;
pub extern fn SetShapesTextureShim(texture: Texture2D, source: * const Rectangle)  void;
pub        fn SetShapesTexture(texture: Texture2D, source: Rectangle) void {
    SetShapesTextureShim(texture, &source);
}
pub extern fn GetShaderLocation(shader: Shader, uniformName: [*c]const u8) c_int;
pub extern fn SetShaderValue(shader: Shader, uniformLoc: c_int, value: ?*const c_void, uniformType: c_int) void;
pub extern fn SetShaderValueV(shader: Shader, uniformLoc: c_int, value: ?*const c_void, uniformType: c_int, count: c_int) void;
pub extern fn SetShaderValueMatrix(shader: Shader, uniformLoc: c_int, mat: Matrix) void;
pub extern fn SetShaderValueTexture(shader: Shader, uniformLoc: c_int, texture: Texture2D) void;
pub extern fn SetMatrixProjection(proj: Matrix) void;
pub extern fn SetMatrixModelview(view: Matrix) void;
pub extern fn GetMatrixModelview() Matrix;
pub extern fn GetMatrixProjection() Matrix;
pub extern fn GenTextureCubemap(shader: Shader, map: Texture2D, size: c_int) Texture2D;
pub extern fn GenTextureIrradiance(shader: Shader, cubemap: Texture2D, size: c_int) Texture2D;
pub extern fn GenTexturePrefilter(shader: Shader, cubemap: Texture2D, size: c_int) Texture2D;
pub extern fn GenTextureBRDF(shader: Shader, size: c_int) Texture2D;
pub extern fn BeginShaderMode(shader: Shader) void;
pub extern fn EndShaderMode() void;
pub extern fn BeginBlendMode(mode: c_int) void;
pub extern fn EndBlendMode() void;
pub extern fn InitVrSimulator() void;
pub extern fn CloseVrSimulator() void;
pub extern fn UpdateVrTracking(camera: [*c]Camera) void;
pub extern fn SetVrConfiguration(info: VrDeviceInfo, distortion: Shader) void;
pub extern fn IsVrSimulatorReady() bool;
pub extern fn ToggleVrMode() void;
pub extern fn BeginVrDrawing() void;
pub extern fn EndVrDrawing() void;
pub extern fn InitAudioDevice() void;
pub extern fn CloseAudioDevice() void;
pub extern fn IsAudioDeviceReady() bool;
pub extern fn SetMasterVolume(volume: f32) void;
pub extern fn LoadWave(fileName: [*c]const u8) Wave;
pub extern fn LoadSound(fileName: [*c]const u8) Sound;
pub extern fn LoadSoundFromWave(wave: Wave) Sound;
pub extern fn UpdateSound(sound: Sound, data: ?*const c_void, samplesCount: c_int) void;
pub extern fn UnloadWave(wave: Wave) void;
pub extern fn UnloadSound(sound: Sound) void;
pub extern fn ExportWave(wave: Wave, fileName: [*c]const u8) void;
pub extern fn ExportWaveAsCode(wave: Wave, fileName: [*c]const u8) void;
pub extern fn PlaySound(sound: Sound) void;
pub extern fn StopSound(sound: Sound) void;
pub extern fn PauseSound(sound: Sound) void;
pub extern fn ResumeSound(sound: Sound) void;
pub extern fn PlaySoundMulti(sound: Sound) void;
pub extern fn StopSoundMulti() void;
pub extern fn GetSoundsPlaying() c_int;
pub extern fn IsSoundPlaying(sound: Sound) bool;
pub extern fn SetSoundVolume(sound: Sound, volume: f32) void;
pub extern fn SetSoundPitch(sound: Sound, pitch: f32) void;
pub extern fn WaveFormat(wave: [*c]Wave, sampleRate: c_int, sampleSize: c_int, channels: c_int) void;
pub extern fn WaveCopy(wave: Wave) Wave;
pub extern fn WaveCrop(wave: [*c]Wave, initSample: c_int, finalSample: c_int) void;
pub extern fn GetWaveData(wave: Wave) [*c]f32;
pub extern fn LoadMusicStream(fileName: [*c]const u8) Music;
pub extern fn UnloadMusicStream(music: Music) void;
pub extern fn PlayMusicStream(music: Music) void;
pub extern fn UpdateMusicStream(music: Music) void;
pub extern fn StopMusicStream(music: Music) void;
pub extern fn PauseMusicStream(music: Music) void;
pub extern fn ResumeMusicStream(music: Music) void;
pub extern fn IsMusicPlaying(music: Music) bool;
pub extern fn SetMusicVolume(music: Music, volume: f32) void;
pub extern fn SetMusicPitch(music: Music, pitch: f32) void;
pub extern fn SetMusicLoopCount(music: Music, count: c_int) void;
pub extern fn GetMusicTimeLength(music: Music) f32;
pub extern fn GetMusicTimePlayed(music: Music) f32;
pub extern fn InitAudioStream(sampleRate: c_uint, sampleSize: c_uint, channels: c_uint) AudioStream;
pub extern fn UpdateAudioStream(stream: AudioStream, data: ?*const c_void, samplesCount: c_int) void;
pub extern fn CloseAudioStream(stream: AudioStream) void;
pub extern fn IsAudioStreamProcessed(stream: AudioStream) bool;
pub extern fn PlayAudioStream(stream: AudioStream) void;
pub extern fn PauseAudioStream(stream: AudioStream) void;
pub extern fn ResumeAudioStream(stream: AudioStream) void;
pub extern fn IsAudioStreamPlaying(stream: AudioStream) bool;
pub extern fn StopAudioStream(stream: AudioStream) void;
pub extern fn SetAudioStreamVolume(stream: AudioStream, volume: f32) void;
pub extern fn SetAudioStreamPitch(stream: AudioStream, pitch: f32) void;
pub extern fn SetAudioStreamBufferSizeDefault(size: c_int) void;
pub const wchar_t = c_int;
pub const P_ALL = @enumToInt(enum_unnamed_22.P_ALL);
pub const P_PID = @enumToInt(enum_unnamed_22.P_PID);
pub const P_PGID = @enumToInt(enum_unnamed_22.P_PGID);
const enum_unnamed_22 = extern enum(c_int) {
    P_ALL,
    P_PID,
    P_PGID,
    _,
};
pub const idtype_t = enum_unnamed_22;
const struct_unnamed_23 = extern struct {
    quot: c_int,
    rem: c_int,
};
pub const div_t = struct_unnamed_23;
const struct_unnamed_24 = extern struct {
    quot: c_long,
    rem: c_long,
};
pub const ldiv_t = struct_unnamed_24;
const struct_unnamed_25 = extern struct {
    quot: c_longlong,
    rem: c_longlong,
};
pub const lldiv_t = struct_unnamed_25;
pub extern fn atof(__nptr: [*c]const u8) f64;
pub extern fn atoi(__nptr: [*c]const u8) c_int;
pub extern fn atol(__nptr: [*c]const u8) c_long;
pub extern fn atoll(__nptr: [*c]const u8) c_longlong;
pub extern fn strtod(__nptr: [*c]const u8, __endptr: [*c][*c]u8) f64;
pub extern fn strtof(__nptr: [*c]const u8, __endptr: [*c][*c]u8) f32;
pub extern fn strtold(__nptr: [*c]const u8, __endptr: [*c][*c]u8) c_longdouble;
pub extern fn strtol(__nptr: [*c]const u8, __endptr: [*c][*c]u8, __base: c_int) c_long;
pub extern fn strtoul(__nptr: [*c]const u8, __endptr: [*c][*c]u8, __base: c_int) c_ulong;
pub extern fn strtoq(noalias __nptr: [*c]const u8, noalias __endptr: [*c][*c]u8, __base: c_int) c_longlong;
pub extern fn strtouq(noalias __nptr: [*c]const u8, noalias __endptr: [*c][*c]u8, __base: c_int) c_ulonglong;
pub extern fn strtoll(__nptr: [*c]const u8, __endptr: [*c][*c]u8, __base: c_int) c_longlong;
pub extern fn strtoull(__nptr: [*c]const u8, __endptr: [*c][*c]u8, __base: c_int) c_ulonglong;
pub extern fn l64a(__n: c_long) [*c]u8;
pub extern fn a64l(__s: [*c]const u8) c_long;
const struct_unnamed_26 = extern struct {
    __val: [2]c_int,
};
pub const u_char = __u_char;
pub const u_short = __u_short;
pub const u_int = __u_int;
pub const u_long = __u_long;
pub const quad_t = __quad_t;
pub const u_quad_t = __u_quad_t;
pub const fsid_t = __fsid_t;
pub const loff_t = __loff_t;
pub const ino_t = __ino_t;
pub const dev_t = __dev_t;
pub const gid_t = __gid_t;
pub const mode_t = __mode_t;
pub const nlink_t = __nlink_t;
pub const uid_t = __uid_t;
pub const off_t = __off_t;
pub const pid_t = __pid_t;
pub const id_t = __id_t;
pub const daddr_t = __daddr_t;
pub const caddr_t = __caddr_t;
pub const key_t = __key_t;
pub const clock_t = __clock_t;
pub const clockid_t = __clockid_t;
pub const time_t = __time_t;
pub const timer_t = __timer_t;
pub const ulong = c_ulong;
pub const ushort = c_ushort;
pub const uint = c_uint;
pub const u_int8_t = __uint8_t;
pub const u_int16_t = __uint16_t;
pub const u_int32_t = __uint32_t;
pub const u_int64_t = __uint64_t;
pub const register_t = c_long;
pub fn __bswap_16(arg___bsx: __uint16_t) callconv(.C) __uint16_t {
    var __bsx = arg___bsx;
    return (@bitCast(__uint16_t, @truncate(c_short, (((@bitCast(c_int, @as(c_uint, (__bsx))) >> @intCast(@import("std").math.Log2Int(c_int), 8)) & @as(c_int, 255)) | ((@bitCast(c_int, @as(c_uint, (__bsx))) & @as(c_int, 255)) << @intCast(@import("std").math.Log2Int(c_int), 8))))));
}
pub fn __bswap_32(arg___bsx: __uint32_t) callconv(.C) __uint32_t {
    var __bsx = arg___bsx;
    return ((((((__bsx) & @as(c_uint, 4278190080)) >> @intCast(@import("std").math.Log2Int(c_uint), 24)) | (((__bsx) & @as(c_uint, 16711680)) >> @intCast(@import("std").math.Log2Int(c_uint), 8))) | (((__bsx) & @as(c_uint, 65280)) << @intCast(@import("std").math.Log2Int(c_uint), 8))) | (((__bsx) & @as(c_uint, 255)) << @intCast(@import("std").math.Log2Int(c_uint), 24)));
}
pub fn __bswap_64(arg___bsx: __uint64_t) callconv(.C) __uint64_t {
    var __bsx = arg___bsx;
    return @bitCast(__uint64_t, @truncate(c_ulong, (((((((((@bitCast(c_ulonglong, @as(c_ulonglong, (__bsx))) & @as(c_ulonglong, 18374686479671623680)) >> @intCast(@import("std").math.Log2Int(c_ulonglong), 56)) | ((@bitCast(c_ulonglong, @as(c_ulonglong, (__bsx))) & @as(c_ulonglong, 71776119061217280)) >> @intCast(@import("std").math.Log2Int(c_ulonglong), 40))) | ((@bitCast(c_ulonglong, @as(c_ulonglong, (__bsx))) & @as(c_ulonglong, 280375465082880)) >> @intCast(@import("std").math.Log2Int(c_ulonglong), 24))) | ((@bitCast(c_ulonglong, @as(c_ulonglong, (__bsx))) & @as(c_ulonglong, 1095216660480)) >> @intCast(@import("std").math.Log2Int(c_ulonglong), 8))) | ((@bitCast(c_ulonglong, @as(c_ulonglong, (__bsx))) & @as(c_ulonglong, 4278190080)) << @intCast(@import("std").math.Log2Int(c_ulonglong), 8))) | ((@bitCast(c_ulonglong, @as(c_ulonglong, (__bsx))) & @as(c_ulonglong, 16711680)) << @intCast(@import("std").math.Log2Int(c_ulonglong), 24))) | ((@bitCast(c_ulonglong, @as(c_ulonglong, (__bsx))) & @as(c_ulonglong, 65280)) << @intCast(@import("std").math.Log2Int(c_ulonglong), 40))) | ((@bitCast(c_ulonglong, @as(c_ulonglong, (__bsx))) & @as(c_ulonglong, 255)) << @intCast(@import("std").math.Log2Int(c_ulonglong), 56)))));
}
pub fn __uint16_identity(arg___x: __uint16_t) callconv(.C) __uint16_t {
    var __x = arg___x;
    return __x;
}
pub fn __uint32_identity(arg___x: __uint32_t) callconv(.C) __uint32_t {
    var __x = arg___x;
    return __x;
}
pub fn __uint64_identity(arg___x: __uint64_t) callconv(.C) __uint64_t {
    var __x = arg___x;
    return __x;
}
const struct_unnamed_27 = extern struct {
    __val: [16]c_ulong,
};
pub const sigset_t = __sigset_t;
pub const struct_timeval = extern struct {
    tv_sec: __time_t,
    tv_usec: __suseconds_t,
};
pub const struct_timespec = extern struct {
    tv_sec: __time_t,
    tv_nsec: __syscall_slong_t,
};
pub const suseconds_t = __suseconds_t;
const struct_unnamed_28 = extern struct {
    __fds_bits: [16]__fd_mask,
};
pub const fd_set = struct_unnamed_28;
pub const fd_mask = __fd_mask;
pub extern fn select(__nfds: c_int, noalias __readfds: [*c]fd_set, noalias __writefds: [*c]fd_set, noalias __exceptfds: [*c]fd_set, noalias __timeout: [*c]struct_timeval) c_int;
pub extern fn pselect(__nfds: c_int, noalias __readfds: [*c]fd_set, noalias __writefds: [*c]fd_set, noalias __exceptfds: [*c]fd_set, noalias __timeout: [*c]const struct_timespec, noalias __sigmask: [*c]const __sigset_t) c_int;
pub const blksize_t = __blksize_t;
pub const blkcnt_t = __blkcnt_t;
pub const fsblkcnt_t = __fsblkcnt_t;
pub const fsfilcnt_t = __fsfilcnt_t;
pub const struct___pthread_rwlock_arch_t = extern struct {
    __readers: c_uint,
    __writers: c_uint,
    __wrphase_futex: c_uint,
    __writers_futex: c_uint,
    __pad3: c_uint,
    __pad4: c_uint,
    __cur_writer: c_int,
    __shared: c_int,
    __rwelision: i8,
    __pad1: [7]u8,
    __pad2: c_ulong,
    __flags: c_uint,
};
pub const struct___pthread_internal_list = extern struct {
    __prev: [*c]struct___pthread_internal_list,
    __next: [*c]struct___pthread_internal_list,
};
pub const struct___pthread_mutex_s = extern struct {
    __lock: c_int,
    __count: c_uint,
    __owner: c_int,
    __nusers: c_uint,
    __kind: c_int,
    __spins: c_short,
    __elision: c_short,
    __list: __pthread_list_t,
};
const struct_unnamed_31 = extern struct {
    __low: c_uint,
    __high: c_uint,
};
const union_unnamed_30 = extern union {
    __wseq: c_ulonglong,
    __wseq32: struct_unnamed_31,
};
const struct_unnamed_34 = extern struct {
    __low: c_uint,
    __high: c_uint,
};
const union_unnamed_33 = extern union {
    __g1_start: c_ulonglong,
    __g1_start32: struct_unnamed_34,
};
pub const struct___pthread_cond_s = extern struct {
    unnamed_29: union_unnamed_30,
    unnamed_32: union_unnamed_33,
    __g_refs: [2]c_uint,
    __g_size: [2]c_uint,
    __g1_orig_size: c_uint,
    __wrefs: c_uint,
    __g_signals: [2]c_uint,
};
pub const pthread_t = c_ulong;
const union_unnamed_35 = extern union {
    __size: [4]u8,
    __align: c_int,
};
pub const pthread_mutexattr_t = union_unnamed_35;
const union_unnamed_36 = extern union {
    __size: [4]u8,
    __align: c_int,
};
pub const pthread_condattr_t = union_unnamed_36;
pub const pthread_key_t = c_uint;
pub const pthread_once_t = c_int;
pub const union_pthread_attr_t = extern union {
    __size: [56]u8,
    __align: c_long,
};
pub const pthread_attr_t = union_pthread_attr_t;
const union_unnamed_37 = extern union {
    __data: struct___pthread_mutex_s,
    __size: [40]u8,
    __align: c_long,
};
pub const pthread_mutex_t = union_unnamed_37;
const union_unnamed_38 = extern union {
    __data: struct___pthread_cond_s,
    __size: [48]u8,
    __align: c_longlong,
};
pub const pthread_cond_t = union_unnamed_38;
const union_unnamed_39 = extern union {
    __data: struct___pthread_rwlock_arch_t,
    __size: [56]u8,
    __align: c_long,
};
pub const pthread_rwlock_t = union_unnamed_39;
const union_unnamed_40 = extern union {
    __size: [8]u8,
    __align: c_long,
};
pub const pthread_rwlockattr_t = union_unnamed_40;
pub const pthread_spinlock_t = c_int;
const union_unnamed_41 = extern union {
    __size: [32]u8,
    __align: c_long,
};
pub const pthread_barrier_t = union_unnamed_41;
const union_unnamed_42 = extern union {
    __size: [4]u8,
    __align: c_int,
};
pub const pthread_barrierattr_t = union_unnamed_42;
pub extern fn random() c_long;
pub extern fn srandom(__seed: c_uint) void;
pub extern fn initstate(__seed: c_uint, __statebuf: [*c]u8, __statelen: usize) [*c]u8;
pub extern fn setstate(__statebuf: [*c]u8) [*c]u8;
pub const struct_random_data = extern struct {
    fptr: [*c]i32,
    rptr: [*c]i32,
    state: [*c]i32,
    rand_type: c_int,
    rand_deg: c_int,
    rand_sep: c_int,
    end_ptr: [*c]i32,
};
pub extern fn random_r(noalias __buf: [*c]struct_random_data, noalias __result: [*c]i32) c_int;
pub extern fn srandom_r(__seed: c_uint, __buf: [*c]struct_random_data) c_int;
pub extern fn initstate_r(__seed: c_uint, noalias __statebuf: [*c]u8, __statelen: usize, noalias __buf: [*c]struct_random_data) c_int;
pub extern fn setstate_r(noalias __statebuf: [*c]u8, noalias __buf: [*c]struct_random_data) c_int;
pub extern fn rand() c_int;
pub extern fn srand(__seed: c_uint) void;
pub extern fn rand_r(__seed: [*c]c_uint) c_int;
pub extern fn drand48() f64;
pub extern fn erand48(__xsubi: [*c]c_ushort) f64;
pub extern fn lrand48() c_long;
pub extern fn nrand48(__xsubi: [*c]c_ushort) c_long;
pub extern fn mrand48() c_long;
pub extern fn jrand48(__xsubi: [*c]c_ushort) c_long;
pub extern fn srand48(__seedval: c_long) void;
pub extern fn seed48(__seed16v: [*c]c_ushort) [*c]c_ushort;
pub extern fn lcong48(__param: [*c]c_ushort) void;
pub const struct_drand48_data = extern struct {
    __x: [3]c_ushort,
    __old_x: [3]c_ushort,
    __c: c_ushort,
    __init: c_ushort,
    __a: c_ulonglong,
};
pub extern fn drand48_r(noalias __buffer: [*c]struct_drand48_data, noalias __result: [*c]f64) c_int;
pub extern fn erand48_r(__xsubi: [*c]c_ushort, noalias __buffer: [*c]struct_drand48_data, noalias __result: [*c]f64) c_int;
pub extern fn lrand48_r(noalias __buffer: [*c]struct_drand48_data, noalias __result: [*c]c_long) c_int;
pub extern fn nrand48_r(__xsubi: [*c]c_ushort, noalias __buffer: [*c]struct_drand48_data, noalias __result: [*c]c_long) c_int;
pub extern fn mrand48_r(noalias __buffer: [*c]struct_drand48_data, noalias __result: [*c]c_long) c_int;
pub extern fn jrand48_r(__xsubi: [*c]c_ushort, noalias __buffer: [*c]struct_drand48_data, noalias __result: [*c]c_long) c_int;
pub extern fn srand48_r(__seedval: c_long, __buffer: [*c]struct_drand48_data) c_int;
pub extern fn seed48_r(__seed16v: [*c]c_ushort, __buffer: [*c]struct_drand48_data) c_int;
pub extern fn lcong48_r(__param: [*c]c_ushort, __buffer: [*c]struct_drand48_data) c_int;
pub extern fn malloc(__size: c_ulong) ?*c_void;
pub extern fn calloc(__nmemb: c_ulong, __size: c_ulong) ?*c_void;
pub extern fn realloc(__ptr: ?*c_void, __size: c_ulong) ?*c_void;
pub extern fn reallocarray(__ptr: ?*c_void, __nmemb: usize, __size: usize) ?*c_void;
pub extern fn free(__ptr: ?*c_void) void;
pub extern fn alloca(__size: c_ulong) ?*c_void;
pub extern fn valloc(__size: usize) ?*c_void;
pub extern fn posix_memalign(__memptr: [*c]?*c_void, __alignment: usize, __size: usize) c_int;
pub extern fn aligned_alloc(__alignment: usize, __size: usize) ?*c_void;
pub extern fn abort() noreturn;
pub extern fn atexit(__func: ?fn () callconv(.C) void) c_int;
pub extern fn at_quick_exit(__func: ?fn () callconv(.C) void) c_int;
pub extern fn on_exit(__func: ?fn (c_int, ?*c_void) callconv(.C) void, __arg: ?*c_void) c_int;
pub extern fn exit(__status: c_int) noreturn;
pub extern fn quick_exit(__status: c_int) noreturn;
pub extern fn getenv(__name: [*c]const u8) [*c]u8;
pub extern fn putenv(__string: [*c]u8) c_int;
pub extern fn setenv(__name: [*c]const u8, __value: [*c]const u8, __replace: c_int) c_int;
pub extern fn unsetenv(__name: [*c]const u8) c_int;
pub extern fn clearenv() c_int;
pub extern fn mktemp(__template: [*c]u8) [*c]u8;
pub extern fn mkstemp(__template: [*c]u8) c_int;
pub extern fn mkstemps(__template: [*c]u8, __suffixlen: c_int) c_int;
pub extern fn mkdtemp(__template: [*c]u8) [*c]u8;
pub extern fn system(__command: [*c]const u8) c_int;
pub extern fn realpath(noalias __name: [*c]const u8, noalias __resolved: [*c]u8) [*c]u8;
pub extern fn bsearch(__key: ?*const c_void, __base: ?*const c_void, __nmemb: usize, __size: usize, __compar: __compar_fn_t) ?*c_void;
pub extern fn qsort(__base: ?*c_void, __nmemb: usize, __size: usize, __compar: __compar_fn_t) void;
pub extern fn abs(__x: c_int) c_int;
pub extern fn labs(__x: c_long) c_long;
pub extern fn llabs(__x: c_longlong) c_longlong;
pub extern fn div(__numer: c_int, __denom: c_int) div_t;
pub extern fn ldiv(__numer: c_long, __denom: c_long) ldiv_t;
pub extern fn lldiv(__numer: c_longlong, __denom: c_longlong) lldiv_t;
pub extern fn ecvt(__value: f64, __ndigit: c_int, noalias __decpt: [*c]c_int, noalias __sign: [*c]c_int) [*c]u8;
pub extern fn fcvt(__value: f64, __ndigit: c_int, noalias __decpt: [*c]c_int, noalias __sign: [*c]c_int) [*c]u8;
pub extern fn gcvt(__value: f64, __ndigit: c_int, __buf: [*c]u8) [*c]u8;
pub extern fn qecvt(__value: c_longdouble, __ndigit: c_int, noalias __decpt: [*c]c_int, noalias __sign: [*c]c_int) [*c]u8;
pub extern fn qfcvt(__value: c_longdouble, __ndigit: c_int, noalias __decpt: [*c]c_int, noalias __sign: [*c]c_int) [*c]u8;
pub extern fn qgcvt(__value: c_longdouble, __ndigit: c_int, __buf: [*c]u8) [*c]u8;
pub extern fn ecvt_r(__value: f64, __ndigit: c_int, noalias __decpt: [*c]c_int, noalias __sign: [*c]c_int, noalias __buf: [*c]u8, __len: usize) c_int;
pub extern fn fcvt_r(__value: f64, __ndigit: c_int, noalias __decpt: [*c]c_int, noalias __sign: [*c]c_int, noalias __buf: [*c]u8, __len: usize) c_int;
pub extern fn qecvt_r(__value: c_longdouble, __ndigit: c_int, noalias __decpt: [*c]c_int, noalias __sign: [*c]c_int, noalias __buf: [*c]u8, __len: usize) c_int;
pub extern fn qfcvt_r(__value: c_longdouble, __ndigit: c_int, noalias __decpt: [*c]c_int, noalias __sign: [*c]c_int, noalias __buf: [*c]u8, __len: usize) c_int;
pub extern fn mblen(__s: [*c]const u8, __n: usize) c_int;
pub extern fn mbtowc(noalias __pwc: [*c]wchar_t, noalias __s: [*c]const u8, __n: usize) c_int;
pub extern fn wctomb(__s: [*c]u8, __wchar: wchar_t) c_int;
pub extern fn mbstowcs(noalias __pwcs: [*c]wchar_t, noalias __s: [*c]const u8, __n: usize) usize;
pub extern fn wcstombs(noalias __s: [*c]u8, noalias __pwcs: [*c]const wchar_t, __n: usize) usize;
pub extern fn rpmatch(__response: [*c]const u8) c_int;
pub extern fn getsubopt(noalias __optionp: [*c][*c]u8, noalias __tokens: [*c]const [*c]u8, noalias __valuep: [*c][*c]u8) c_int;
pub extern fn getloadavg(__loadavg: [*c]f64, __nelem: c_int) c_int;
pub const GUI_STATE_NORMAL = @enumToInt(enum_unnamed_43.GUI_STATE_NORMAL);
pub const GUI_STATE_FOCUSED = @enumToInt(enum_unnamed_43.GUI_STATE_FOCUSED);
pub const GUI_STATE_PRESSED = @enumToInt(enum_unnamed_43.GUI_STATE_PRESSED);
pub const GUI_STATE_DISABLED = @enumToInt(enum_unnamed_43.GUI_STATE_DISABLED);
const enum_unnamed_43 = extern enum(c_int) {
    GUI_STATE_NORMAL = 0,
    GUI_STATE_FOCUSED = 1,
    GUI_STATE_PRESSED = 2,
    GUI_STATE_DISABLED = 3,
    _,
};
pub const GuiControlState = enum_unnamed_43;
pub const GUI_TEXT_ALIGN_LEFT = @enumToInt(enum_unnamed_44.GUI_TEXT_ALIGN_LEFT);
pub const GUI_TEXT_ALIGN_CENTER = @enumToInt(enum_unnamed_44.GUI_TEXT_ALIGN_CENTER);
pub const GUI_TEXT_ALIGN_RIGHT = @enumToInt(enum_unnamed_44.GUI_TEXT_ALIGN_RIGHT);
const enum_unnamed_44 = extern enum(c_int) {
    GUI_TEXT_ALIGN_LEFT = 0,
    GUI_TEXT_ALIGN_CENTER = 1,
    GUI_TEXT_ALIGN_RIGHT = 2,
    _,
};
pub const GuiTextAlignment = enum_unnamed_44;
pub const DEFAULT = @enumToInt(enum_unnamed_45.DEFAULT);
pub const LABEL = @enumToInt(enum_unnamed_45.LABEL);
pub const BUTTON = @enumToInt(enum_unnamed_45.BUTTON);
pub const TOGGLE = @enumToInt(enum_unnamed_45.TOGGLE);
pub const SLIDER = @enumToInt(enum_unnamed_45.SLIDER);
pub const PROGRESSBAR = @enumToInt(enum_unnamed_45.PROGRESSBAR);
pub const CHECKBOX = @enumToInt(enum_unnamed_45.CHECKBOX);
pub const COMBOBOX = @enumToInt(enum_unnamed_45.COMBOBOX);
pub const DROPDOWNBOX = @enumToInt(enum_unnamed_45.DROPDOWNBOX);
pub const TEXTBOX = @enumToInt(enum_unnamed_45.TEXTBOX);
pub const VALUEBOX = @enumToInt(enum_unnamed_45.VALUEBOX);
pub const SPINNER = @enumToInt(enum_unnamed_45.SPINNER);
pub const LISTVIEW = @enumToInt(enum_unnamed_45.LISTVIEW);
pub const COLORPICKER = @enumToInt(enum_unnamed_45.COLORPICKER);
pub const SCROLLBAR = @enumToInt(enum_unnamed_45.SCROLLBAR);
pub const RESERVED = @enumToInt(enum_unnamed_45.RESERVED);
const enum_unnamed_45 = extern enum(c_int) {
    DEFAULT = 0,
    LABEL = 1,
    BUTTON = 2,
    TOGGLE = 3,
    SLIDER = 4,
    PROGRESSBAR = 5,
    CHECKBOX = 6,
    COMBOBOX = 7,
    DROPDOWNBOX = 8,
    TEXTBOX = 9,
    VALUEBOX = 10,
    SPINNER = 11,
    LISTVIEW = 12,
    COLORPICKER = 13,
    SCROLLBAR = 14,
    RESERVED = 15,
    _,
};
pub const GuiControl = enum_unnamed_45;
pub const BORDER_COLOR_NORMAL = @enumToInt(enum_unnamed_46.BORDER_COLOR_NORMAL);
pub const BASE_COLOR_NORMAL = @enumToInt(enum_unnamed_46.BASE_COLOR_NORMAL);
pub const TEXT_COLOR_NORMAL = @enumToInt(enum_unnamed_46.TEXT_COLOR_NORMAL);
pub const BORDER_COLOR_FOCUSED = @enumToInt(enum_unnamed_46.BORDER_COLOR_FOCUSED);
pub const BASE_COLOR_FOCUSED = @enumToInt(enum_unnamed_46.BASE_COLOR_FOCUSED);
pub const TEXT_COLOR_FOCUSED = @enumToInt(enum_unnamed_46.TEXT_COLOR_FOCUSED);
pub const BORDER_COLOR_PRESSED = @enumToInt(enum_unnamed_46.BORDER_COLOR_PRESSED);
pub const BASE_COLOR_PRESSED = @enumToInt(enum_unnamed_46.BASE_COLOR_PRESSED);
pub const TEXT_COLOR_PRESSED = @enumToInt(enum_unnamed_46.TEXT_COLOR_PRESSED);
pub const BORDER_COLOR_DISABLED = @enumToInt(enum_unnamed_46.BORDER_COLOR_DISABLED);
pub const BASE_COLOR_DISABLED = @enumToInt(enum_unnamed_46.BASE_COLOR_DISABLED);
pub const TEXT_COLOR_DISABLED = @enumToInt(enum_unnamed_46.TEXT_COLOR_DISABLED);
pub const BORDER_WIDTH = @enumToInt(enum_unnamed_46.BORDER_WIDTH);
pub const INNER_PADDING = @enumToInt(enum_unnamed_46.INNER_PADDING);
pub const TEXT_ALIGNMENT = @enumToInt(enum_unnamed_46.TEXT_ALIGNMENT);
pub const RESERVED02 = @enumToInt(enum_unnamed_46.RESERVED02);
const enum_unnamed_46 = extern enum(c_int) {
    BORDER_COLOR_NORMAL = 0,
    BASE_COLOR_NORMAL = 1,
    TEXT_COLOR_NORMAL = 2,
    BORDER_COLOR_FOCUSED = 3,
    BASE_COLOR_FOCUSED = 4,
    TEXT_COLOR_FOCUSED = 5,
    BORDER_COLOR_PRESSED = 6,
    BASE_COLOR_PRESSED = 7,
    TEXT_COLOR_PRESSED = 8,
    BORDER_COLOR_DISABLED = 9,
    BASE_COLOR_DISABLED = 10,
    TEXT_COLOR_DISABLED = 11,
    BORDER_WIDTH = 12,
    INNER_PADDING = 13,
    TEXT_ALIGNMENT = 14,
    RESERVED02 = 15,
    _,
};
pub const GuiControlProperty = enum_unnamed_46;
pub const TEXT_SIZE = @enumToInt(enum_unnamed_47.TEXT_SIZE);
pub const TEXT_SPACING = @enumToInt(enum_unnamed_47.TEXT_SPACING);
pub const LINE_COLOR = @enumToInt(enum_unnamed_47.LINE_COLOR);
pub const BACKGROUND_COLOR = @enumToInt(enum_unnamed_47.BACKGROUND_COLOR);
const enum_unnamed_47 = extern enum(c_int) {
    TEXT_SIZE = 16,
    TEXT_SPACING = 17,
    LINE_COLOR = 18,
    BACKGROUND_COLOR = 19,
    _,
};
pub const GuiDefaultProperty = enum_unnamed_47;
pub const GROUP_PADDING = @enumToInt(enum_unnamed_48.GROUP_PADDING);
const enum_unnamed_48 = extern enum(c_int) {
    GROUP_PADDING = 16,
    _,
};
pub const GuiToggleProperty = enum_unnamed_48;
pub const SLIDER_WIDTH = @enumToInt(enum_unnamed_49.SLIDER_WIDTH);
pub const TEXT_PADDING = @enumToInt(enum_unnamed_49.TEXT_PADDING);
const enum_unnamed_49 = extern enum(c_int) {
    SLIDER_WIDTH = 16,
    TEXT_PADDING = 17,
    _,
};
pub const GuiSliderProperty = enum_unnamed_49;
pub const CHECK_TEXT_PADDING = @enumToInt(enum_unnamed_50.CHECK_TEXT_PADDING);
const enum_unnamed_50 = extern enum(c_int) {
    CHECK_TEXT_PADDING = 16,
    _,
};
pub const GuiCheckBoxProperty = enum_unnamed_50;
pub const SELECTOR_WIDTH = @enumToInt(enum_unnamed_51.SELECTOR_WIDTH);
pub const SELECTOR_PADDING = @enumToInt(enum_unnamed_51.SELECTOR_PADDING);
const enum_unnamed_51 = extern enum(c_int) {
    SELECTOR_WIDTH = 16,
    SELECTOR_PADDING = 17,
    _,
};
pub const GuiComboBoxProperty = enum_unnamed_51;
pub const ARROW_RIGHT_PADDING = @enumToInt(enum_unnamed_52.ARROW_RIGHT_PADDING);
const enum_unnamed_52 = extern enum(c_int) {
    ARROW_RIGHT_PADDING = 16,
    _,
};
pub const GuiDropdownBoxProperty = enum_unnamed_52;
pub const MULTILINE_PADDING = @enumToInt(enum_unnamed_53.MULTILINE_PADDING);
pub const COLOR_SELECTED_FG = @enumToInt(enum_unnamed_53.COLOR_SELECTED_FG);
pub const COLOR_SELECTED_BG = @enumToInt(enum_unnamed_53.COLOR_SELECTED_BG);
const enum_unnamed_53 = extern enum(c_int) {
    MULTILINE_PADDING = 16,
    COLOR_SELECTED_FG = 17,
    COLOR_SELECTED_BG = 18,
    _,
};
pub const GuiTextBoxProperty = enum_unnamed_53;
pub const SELECT_BUTTON_WIDTH = @enumToInt(enum_unnamed_54.SELECT_BUTTON_WIDTH);
pub const SELECT_BUTTON_PADDING = @enumToInt(enum_unnamed_54.SELECT_BUTTON_PADDING);
pub const SELECT_BUTTON_BORDER_WIDTH = @enumToInt(enum_unnamed_54.SELECT_BUTTON_BORDER_WIDTH);
const enum_unnamed_54 = extern enum(c_int) {
    SELECT_BUTTON_WIDTH = 16,
    SELECT_BUTTON_PADDING = 17,
    SELECT_BUTTON_BORDER_WIDTH = 18,
    _,
};
pub const GuiSpinnerProperty = enum_unnamed_54;
pub const ARROWS_SIZE = @enumToInt(enum_unnamed_55.ARROWS_SIZE);
pub const SLIDER_PADDING = @enumToInt(enum_unnamed_55.SLIDER_PADDING);
pub const SLIDER_SIZE = @enumToInt(enum_unnamed_55.SLIDER_SIZE);
pub const SCROLL_SPEED = @enumToInt(enum_unnamed_55.SCROLL_SPEED);
pub const ARROWS_VISIBLE = @enumToInt(enum_unnamed_55.ARROWS_VISIBLE);
const enum_unnamed_55 = extern enum(c_int) {
    ARROWS_SIZE = 16,
    SLIDER_PADDING = 17,
    SLIDER_SIZE = 18,
    SCROLL_SPEED = 19,
    ARROWS_VISIBLE = 20,
    _,
};
pub const GuiScrollBarProperty = enum_unnamed_55;
pub const SCROLLBAR_LEFT_SIDE = @enumToInt(enum_unnamed_56.SCROLLBAR_LEFT_SIDE);
pub const SCROLLBAR_RIGHT_SIDE = @enumToInt(enum_unnamed_56.SCROLLBAR_RIGHT_SIDE);
const enum_unnamed_56 = extern enum(c_int) {
    SCROLLBAR_LEFT_SIDE = 0,
    SCROLLBAR_RIGHT_SIDE = 1,
    _,
};
pub const GuiScrollBarSide = enum_unnamed_56;
pub const ELEMENTS_HEIGHT = @enumToInt(enum_unnamed_57.ELEMENTS_HEIGHT);
pub const ELEMENTS_PADDING = @enumToInt(enum_unnamed_57.ELEMENTS_PADDING);
pub const SCROLLBAR_WIDTH = @enumToInt(enum_unnamed_57.SCROLLBAR_WIDTH);
pub const SCROLLBAR_SIDE = @enumToInt(enum_unnamed_57.SCROLLBAR_SIDE);
const enum_unnamed_57 = extern enum(c_int) {
    ELEMENTS_HEIGHT = 16,
    ELEMENTS_PADDING = 17,
    SCROLLBAR_WIDTH = 18,
    SCROLLBAR_SIDE = 19,
    _,
};
pub const GuiListViewProperty = enum_unnamed_57;
pub const COLOR_SELECTOR_SIZE = @enumToInt(enum_unnamed_58.COLOR_SELECTOR_SIZE);
pub const BAR_WIDTH = @enumToInt(enum_unnamed_58.BAR_WIDTH);
pub const BAR_PADDING = @enumToInt(enum_unnamed_58.BAR_PADDING);
pub const BAR_SELECTOR_HEIGHT = @enumToInt(enum_unnamed_58.BAR_SELECTOR_HEIGHT);
pub const BAR_SELECTOR_PADDING = @enumToInt(enum_unnamed_58.BAR_SELECTOR_PADDING);
const enum_unnamed_58 = extern enum(c_int) {
    COLOR_SELECTOR_SIZE = 16,
    BAR_WIDTH = 17,
    BAR_PADDING = 18,
    BAR_SELECTOR_HEIGHT = 19,
    BAR_SELECTOR_PADDING = 20,
    _,
};
pub const GuiColorPickerProperty = enum_unnamed_58;
pub extern fn GuiEnable() void;
pub extern fn GuiDisable() void;
pub extern fn GuiLock() void;
pub extern fn GuiUnlock() void;
pub extern fn GuiState(state: c_int) void;
pub extern fn GuiFont(font: Font) void;
pub extern fn GuiFade(alpha: f32) void;
pub extern fn GuiSetStyle(control: c_int, property: c_int, value: c_int) void;
pub extern fn GuiGetStyle(control: c_int, property: c_int) c_int;
pub extern fn GuiWindowBoxShim(bounds: * const Rectangle, text: [*c]const u8)  bool;
pub        fn GuiWindowBox(bounds: Rectangle, text: [*c]const u8) bool {
   return  GuiWindowBoxShim(&bounds, text);
}
pub extern fn GuiGroupBoxShim(bounds: * const Rectangle, text: [*c]const u8)  void;
pub        fn GuiGroupBox(bounds: Rectangle, text: [*c]const u8) void {
    GuiGroupBoxShim(&bounds, text);
}
pub extern fn GuiLineShim(bounds: * const Rectangle, text: [*c]const u8)  void;
pub        fn GuiLine(bounds: Rectangle, text: [*c]const u8) void {
    GuiLineShim(&bounds, text);
}
pub extern fn GuiPanelShim(bounds: * const Rectangle)  void;
pub        fn GuiPanel(bounds: Rectangle) void {
    GuiPanelShim(&bounds);
}
pub extern fn GuiScrollPanelShim(bounds: * const Rectangle, content: * const Rectangle, scroll: [*c]Vector2)  Rectangle;
pub        fn GuiScrollPanel(bounds: Rectangle, content: Rectangle, scroll: [*c]Vector2) Rectangle {
   return  GuiScrollPanelShim(&bounds, &content, scroll);
}
pub extern fn GuiLabelShim(bounds: * const Rectangle, text: [*c]const u8)  void;
pub        fn GuiLabel(bounds: Rectangle, text: [*c]const u8) void {
    GuiLabelShim(&bounds, text);
}
pub extern fn GuiButtonShim(bounds: * const Rectangle, text: [*c]const u8)  bool;
pub        fn GuiButton(bounds: Rectangle, text: [*c]const u8) bool {
   return  GuiButtonShim(&bounds, text);
}
pub extern fn GuiLabelButtonShim(bounds: * const Rectangle, text: [*c]const u8)  bool;
pub        fn GuiLabelButton(bounds: Rectangle, text: [*c]const u8) bool {
   return  GuiLabelButtonShim(&bounds, text);
}
pub extern fn GuiImageButtonShim(bounds: * const Rectangle, texture: Texture2D)  bool;
pub        fn GuiImageButton(bounds: Rectangle, texture: Texture2D) bool {
   return  GuiImageButtonShim(&bounds, texture);
}
pub extern fn GuiImageButtonExShim(bounds: * const Rectangle, texture: Texture2D, texSource: * const Rectangle, text: [*c]const u8)  bool;
pub        fn GuiImageButtonEx(bounds: Rectangle, texture: Texture2D, texSource: Rectangle, text: [*c]const u8) bool {
   return  GuiImageButtonExShim(&bounds, texture, &texSource, text);
}
pub extern fn GuiToggleShim(bounds: * const Rectangle, text: [*c]const u8, active: bool)  bool;
pub        fn GuiToggle(bounds: Rectangle, text: [*c]const u8, active: bool) bool {
   return  GuiToggleShim(&bounds, text, active);
}
pub extern fn GuiToggleGroupShim(bounds: * const Rectangle, text: [*c]const u8, active: c_int)  c_int;
pub        fn GuiToggleGroup(bounds: Rectangle, text: [*c]const u8, active: c_int) c_int {
   return  GuiToggleGroupShim(&bounds, text, active);
}
pub extern fn GuiCheckBoxShim(bounds: * const Rectangle, text: [*c]const u8, checked: bool)  bool;
pub        fn GuiCheckBox(bounds: Rectangle, text: [*c]const u8, checked: bool) bool {
   return  GuiCheckBoxShim(&bounds, text, checked);
}
pub extern fn GuiComboBoxShim(bounds: * const Rectangle, text: [*c]const u8, active: c_int)  c_int;
pub        fn GuiComboBox(bounds: Rectangle, text: [*c]const u8, active: c_int) c_int {
   return  GuiComboBoxShim(&bounds, text, active);
}
pub extern fn GuiDropdownBoxShim(bounds: * const Rectangle, text: [*c]const u8, active: [*c]c_int, editMode: bool)  bool;
pub        fn GuiDropdownBox(bounds: Rectangle, text: [*c]const u8, active: [*c]c_int, editMode: bool) bool {
   return  GuiDropdownBoxShim(&bounds, text, active, editMode);
}
pub extern fn GuiSpinnerShim(bounds: * const Rectangle, value: [*c]c_int, minValue: c_int, maxValue: c_int, editMode: bool)  bool;
pub        fn GuiSpinner(bounds: Rectangle, value: [*c]c_int, minValue: c_int, maxValue: c_int, editMode: bool) bool {
   return  GuiSpinnerShim(&bounds, value, minValue, maxValue, editMode);
}
pub extern fn GuiValueBoxShim(bounds: * const Rectangle, value: [*c]c_int, minValue: c_int, maxValue: c_int, editMode: bool)  bool;
pub        fn GuiValueBox(bounds: Rectangle, value: [*c]c_int, minValue: c_int, maxValue: c_int, editMode: bool) bool {
   return  GuiValueBoxShim(&bounds, value, minValue, maxValue, editMode);
}
pub extern fn GuiTextBoxShim(bounds: * const Rectangle, text: [*c]u8, textSize: c_int, editMode: bool)  bool;
pub        fn GuiTextBox(bounds: Rectangle, text: [*c]u8, textSize: c_int, editMode: bool) bool {
   return  GuiTextBoxShim(&bounds, text, textSize, editMode);
}
pub extern fn GuiTextBoxMultiShim(bounds: * const Rectangle, text: [*c]u8, textSize: c_int, editMode: bool)  bool;
pub        fn GuiTextBoxMulti(bounds: Rectangle, text: [*c]u8, textSize: c_int, editMode: bool) bool {
   return  GuiTextBoxMultiShim(&bounds, text, textSize, editMode);
}
pub extern fn GuiSliderShim(bounds: * const Rectangle, text: [*c]const u8, value: f32, minValue: f32, maxValue: f32, showValue: bool)  f32;
pub        fn GuiSlider(bounds: Rectangle, text: [*c]const u8, value: f32, minValue: f32, maxValue: f32, showValue: bool) f32 {
   return  GuiSliderShim(&bounds, text, value, minValue, maxValue, showValue);
}
pub extern fn GuiSliderBarShim(bounds: * const Rectangle, text: [*c]const u8, value: f32, minValue: f32, maxValue: f32, showValue: bool)  f32;
pub        fn GuiSliderBar(bounds: Rectangle, text: [*c]const u8, value: f32, minValue: f32, maxValue: f32, showValue: bool) f32 {
   return  GuiSliderBarShim(&bounds, text, value, minValue, maxValue, showValue);
}
pub extern fn GuiProgressBarShim(bounds: * const Rectangle, text: [*c]const u8, value: f32, minValue: f32, maxValue: f32, showValue: bool)  f32;
pub        fn GuiProgressBar(bounds: Rectangle, text: [*c]const u8, value: f32, minValue: f32, maxValue: f32, showValue: bool) f32 {
   return  GuiProgressBarShim(&bounds, text, value, minValue, maxValue, showValue);
}
pub extern fn GuiStatusBarShim(bounds: * const Rectangle, text: [*c]const u8)  void;
pub        fn GuiStatusBar(bounds: Rectangle, text: [*c]const u8) void {
    GuiStatusBarShim(&bounds, text);
}
pub extern fn GuiDummyRecShim(bounds: * const Rectangle, text: [*c]const u8)  void;
pub        fn GuiDummyRec(bounds: Rectangle, text: [*c]const u8) void {
    GuiDummyRecShim(&bounds, text);
}
pub extern fn GuiScrollBarShim(bounds: * const Rectangle, value: c_int, minValue: c_int, maxValue: c_int)  c_int;
pub        fn GuiScrollBar(bounds: Rectangle, value: c_int, minValue: c_int, maxValue: c_int) c_int {
   return  GuiScrollBarShim(&bounds, value, minValue, maxValue);
}
pub extern fn GuiGridShim(bounds: * const Rectangle, spacing: f32, subdivs: c_int)  Vector2;
pub        fn GuiGrid(bounds: Rectangle, spacing: f32, subdivs: c_int) Vector2 {
   return  GuiGridShim(&bounds, spacing, subdivs);
}
pub extern fn GuiListViewShim(bounds: * const Rectangle, text: [*c]const u8, active: [*c]c_int, scrollIndex: [*c]c_int, editMode: bool)  bool;
pub        fn GuiListView(bounds: Rectangle, text: [*c]const u8, active: [*c]c_int, scrollIndex: [*c]c_int, editMode: bool) bool {
   return  GuiListViewShim(&bounds, text, active, scrollIndex, editMode);
}
pub extern fn GuiListViewExShim(bounds: * const Rectangle, text: [*c][*c]const u8, count: c_int, enabled: [*c]c_int, active: [*c]c_int, focus: [*c]c_int, scrollIndex: [*c]c_int, editMode: bool)  bool;
pub        fn GuiListViewEx(bounds: Rectangle, text: [*c][*c]const u8, count: c_int, enabled: [*c]c_int, active: [*c]c_int, focus: [*c]c_int, scrollIndex: [*c]c_int, editMode: bool) bool {
   return  GuiListViewExShim(&bounds, text, count, enabled, active, focus, scrollIndex, editMode);
}
pub extern fn GuiMessageBoxShim(bounds: * const Rectangle, windowTitle: [*c]const u8, message: [*c]const u8, buttons: [*c]const u8)  c_int;
pub        fn GuiMessageBox(bounds: Rectangle, windowTitle: [*c]const u8, message: [*c]const u8, buttons: [*c]const u8) c_int {
   return  GuiMessageBoxShim(&bounds, windowTitle, message, buttons);
}
pub extern fn GuiTextInputBoxShim(bounds: * const Rectangle, windowTitle: [*c]const u8, message: [*c]const u8, text: [*c]u8, buttons: [*c]const u8)  c_int;
pub        fn GuiTextInputBox(bounds: Rectangle, windowTitle: [*c]const u8, message: [*c]const u8, text: [*c]u8, buttons: [*c]const u8) c_int {
   return  GuiTextInputBoxShim(&bounds, windowTitle, message, text, buttons);
}
pub extern fn GuiColorPickerShim(bounds: * const Rectangle, color: Color)  Color;
pub        fn GuiColorPicker(bounds: Rectangle, color: Color) Color {
   return  GuiColorPickerShim(&bounds, color);
}
pub extern fn GuiLoadStyle(fileName: [*c]const u8) void;
pub extern fn GuiLoadStyleProps(props: [*c]const c_int, count: c_int) void;
pub extern fn GuiLoadStyleDefault() void;
pub extern fn GuiUpdateStyleComplete() void;
pub extern fn GuiIconText(iconId: c_int, text: [*c]const u8) [*c]const u8;
pub const float_t = f32;
pub const double_t = f64;
pub extern fn acos(__x: f64) f64;
pub extern fn asin(__x: f64) f64;
pub extern fn atan(__x: f64) f64;
pub extern fn atan2(__y: f64, __x: f64) f64;
pub extern fn cos(__x: f64) f64;
pub extern fn sin(__x: f64) f64;
pub extern fn tan(__x: f64) f64;
pub extern fn cosh(__x: f64) f64;
pub extern fn sinh(__x: f64) f64;
pub extern fn tanh(__x: f64) f64;
pub extern fn acosh(__x: f64) f64;
pub extern fn asinh(__x: f64) f64;
pub extern fn atanh(__x: f64) f64;
pub extern fn exp(__x: f64) f64;
pub extern fn frexp(__x: f64, __exponent: [*c]c_int) f64;
pub extern fn ldexp(__x: f64, __exponent: c_int) f64;
pub extern fn log(__x: f64) f64;
pub extern fn log10(__x: f64) f64;
pub extern fn modf(__x: f64, __iptr: [*c]f64) f64;
pub extern fn expm1(__x: f64) f64;
pub extern fn log1p(__x: f64) f64;
pub extern fn logb(__x: f64) f64;
pub extern fn exp2(__x: f64) f64;
pub extern fn log2(__x: f64) f64;
pub extern fn pow(__x: f64, __y: f64) f64;
pub extern fn sqrt(__x: f64) f64;
pub extern fn hypot(__x: f64, __y: f64) f64;
pub extern fn cbrt(__x: f64) f64;
pub extern fn ceil(__x: f64) f64;
pub extern fn fabs(__x: f64) f64;
pub extern fn floor(__x: f64) f64;
pub extern fn fmod(__x: f64, __y: f64) f64;
pub extern fn isinf(__value: f64) c_int;
pub extern fn finite(__value: f64) c_int;
pub extern fn drem(__x: f64, __y: f64) f64;
pub extern fn significand(__x: f64) f64;
pub extern fn copysign(__x: f64, __y: f64) f64;
pub extern fn nan(__tagb: [*c]const u8) f64;
pub extern fn isnan(__value: f64) c_int;
pub extern fn j0(f64) f64;
pub extern fn j1(f64) f64;
pub extern fn jn(c_int, f64) f64;
pub extern fn y0(f64) f64;
pub extern fn y1(f64) f64;
pub extern fn yn(c_int, f64) f64;
pub extern fn erf(f64) f64;
pub extern fn erfc(f64) f64;
pub extern fn lgamma(f64) f64;
pub extern fn tgamma(f64) f64;
pub extern fn gamma(f64) f64;
pub extern fn lgamma_r(f64, __signgamp: [*c]c_int) f64;
pub extern fn rint(__x: f64) f64;
pub extern fn nextafter(__x: f64, __y: f64) f64;
pub extern fn nexttoward(__x: f64, __y: c_longdouble) f64;
pub extern fn remainder(__x: f64, __y: f64) f64;
pub extern fn scalbn(__x: f64, __n: c_int) f64;
pub extern fn ilogb(__x: f64) c_int;
pub extern fn scalbln(__x: f64, __n: c_long) f64;
pub extern fn nearbyint(__x: f64) f64;
pub extern fn round(__x: f64) f64;
pub extern fn trunc(__x: f64) f64;
pub extern fn remquo(__x: f64, __y: f64, __quo: [*c]c_int) f64;
pub extern fn lrint(__x: f64) c_long;
pub extern fn llrint(__x: f64) c_longlong;
pub extern fn lround(__x: f64) c_long;
pub extern fn llround(__x: f64) c_longlong;
pub extern fn fdim(__x: f64, __y: f64) f64;
pub extern fn fmax(__x: f64, __y: f64) f64;
pub extern fn fmin(__x: f64, __y: f64) f64;
pub extern fn fma(__x: f64, __y: f64, __z: f64) f64;
pub extern fn scalb(__x: f64, __n: f64) f64;
pub extern fn acosf(__x: f32) f32;
pub extern fn asinf(__x: f32) f32;
pub extern fn atanf(__x: f32) f32;
pub extern fn atan2f(__y: f32, __x: f32) f32;
pub extern fn cosf(__x: f32) f32;
pub extern fn sinf(__x: f32) f32;
pub extern fn tanf(__x: f32) f32;
pub extern fn coshf(__x: f32) f32;
pub extern fn sinhf(__x: f32) f32;
pub extern fn tanhf(__x: f32) f32;
pub extern fn acoshf(__x: f32) f32;
pub extern fn asinhf(__x: f32) f32;
pub extern fn atanhf(__x: f32) f32;
pub extern fn expf(__x: f32) f32;
pub extern fn frexpf(__x: f32, __exponent: [*c]c_int) f32;
pub extern fn ldexpf(__x: f32, __exponent: c_int) f32;
pub extern fn logf(__x: f32) f32;
pub extern fn log10f(__x: f32) f32;
pub extern fn modff(__x: f32, __iptr: [*c]f32) f32;
pub extern fn expm1f(__x: f32) f32;
pub extern fn log1pf(__x: f32) f32;
pub extern fn logbf(__x: f32) f32;
pub extern fn exp2f(__x: f32) f32;
pub extern fn log2f(__x: f32) f32;
pub extern fn powf(__x: f32, __y: f32) f32;
pub extern fn sqrtf(__x: f32) f32;
pub extern fn hypotf(__x: f32, __y: f32) f32;
pub extern fn cbrtf(__x: f32) f32;
pub extern fn ceilf(__x: f32) f32;
pub extern fn fabsf(__x: f32) f32;
pub extern fn floorf(__x: f32) f32;
pub extern fn fmodf(__x: f32, __y: f32) f32;
pub extern fn isinff(__value: f32) c_int;
pub extern fn finitef(__value: f32) c_int;
pub extern fn dremf(__x: f32, __y: f32) f32;
pub extern fn significandf(__x: f32) f32;
pub extern fn copysignf(__x: f32, __y: f32) f32;
pub extern fn nanf(__tagb: [*c]const u8) f32;
pub extern fn isnanf(__value: f32) c_int;
pub extern fn j0f(f32) f32;
pub extern fn j1f(f32) f32;
pub extern fn jnf(c_int, f32) f32;
pub extern fn y0f(f32) f32;
pub extern fn y1f(f32) f32;
pub extern fn ynf(c_int, f32) f32;
pub extern fn erff(f32) f32;
pub extern fn erfcf(f32) f32;
pub extern fn lgammaf(f32) f32;
pub extern fn tgammaf(f32) f32;
pub extern fn gammaf(f32) f32;
pub extern fn lgammaf_r(f32, __signgamp: [*c]c_int) f32;
pub extern fn rintf(__x: f32) f32;
pub extern fn nextafterf(__x: f32, __y: f32) f32;
pub extern fn nexttowardf(__x: f32, __y: c_longdouble) f32;
pub extern fn remainderf(__x: f32, __y: f32) f32;
pub extern fn scalbnf(__x: f32, __n: c_int) f32;
pub extern fn ilogbf(__x: f32) c_int;
pub extern fn scalblnf(__x: f32, __n: c_long) f32;
pub extern fn nearbyintf(__x: f32) f32;
pub extern fn roundf(__x: f32) f32;
pub extern fn truncf(__x: f32) f32;
pub extern fn remquof(__x: f32, __y: f32, __quo: [*c]c_int) f32;
pub extern fn lrintf(__x: f32) c_long;
pub extern fn llrintf(__x: f32) c_longlong;
pub extern fn lroundf(__x: f32) c_long;
pub extern fn llroundf(__x: f32) c_longlong;
pub extern fn fdimf(__x: f32, __y: f32) f32;
pub extern fn fmaxf(__x: f32, __y: f32) f32;
pub extern fn fminf(__x: f32, __y: f32) f32;
pub extern fn fmaf(__x: f32, __y: f32, __z: f32) f32;
pub extern fn scalbf(__x: f32, __n: f32) f32;
pub extern fn acosl(__x: c_longdouble) c_longdouble;
pub extern fn asinl(__x: c_longdouble) c_longdouble;
pub extern fn atanl(__x: c_longdouble) c_longdouble;
pub extern fn atan2l(__y: c_longdouble, __x: c_longdouble) c_longdouble;
pub extern fn cosl(__x: c_longdouble) c_longdouble;
pub extern fn sinl(__x: c_longdouble) c_longdouble;
pub extern fn tanl(__x: c_longdouble) c_longdouble;
pub extern fn coshl(__x: c_longdouble) c_longdouble;
pub extern fn sinhl(__x: c_longdouble) c_longdouble;
pub extern fn tanhl(__x: c_longdouble) c_longdouble;
pub extern fn acoshl(__x: c_longdouble) c_longdouble;
pub extern fn asinhl(__x: c_longdouble) c_longdouble;
pub extern fn atanhl(__x: c_longdouble) c_longdouble;
pub extern fn expl(__x: c_longdouble) c_longdouble;
pub extern fn frexpl(__x: c_longdouble, __exponent: [*c]c_int) c_longdouble;
pub extern fn ldexpl(__x: c_longdouble, __exponent: c_int) c_longdouble;
pub extern fn logl(__x: c_longdouble) c_longdouble;
pub extern fn log10l(__x: c_longdouble) c_longdouble;
pub extern fn modfl(__x: c_longdouble, __iptr: [*c]c_longdouble) c_longdouble;
pub extern fn expm1l(__x: c_longdouble) c_longdouble;
pub extern fn log1pl(__x: c_longdouble) c_longdouble;
pub extern fn logbl(__x: c_longdouble) c_longdouble;
pub extern fn exp2l(__x: c_longdouble) c_longdouble;
pub extern fn log2l(__x: c_longdouble) c_longdouble;
pub extern fn powl(__x: c_longdouble, __y: c_longdouble) c_longdouble;
pub extern fn sqrtl(__x: c_longdouble) c_longdouble;
pub extern fn hypotl(__x: c_longdouble, __y: c_longdouble) c_longdouble;
pub extern fn cbrtl(__x: c_longdouble) c_longdouble;
pub extern fn ceill(__x: c_longdouble) c_longdouble;
pub extern fn fabsl(__x: c_longdouble) c_longdouble;
pub extern fn floorl(__x: c_longdouble) c_longdouble;
pub extern fn fmodl(__x: c_longdouble, __y: c_longdouble) c_longdouble;
pub extern fn isinfl(__value: c_longdouble) c_int;
pub extern fn finitel(__value: c_longdouble) c_int;
pub extern fn dreml(__x: c_longdouble, __y: c_longdouble) c_longdouble;
pub extern fn significandl(__x: c_longdouble) c_longdouble;
pub extern fn copysignl(__x: c_longdouble, __y: c_longdouble) c_longdouble;
pub extern fn nanl(__tagb: [*c]const u8) c_longdouble;
pub extern fn isnanl(__value: c_longdouble) c_int;
pub extern fn j0l(c_longdouble) c_longdouble;
pub extern fn j1l(c_longdouble) c_longdouble;
pub extern fn jnl(c_int, c_longdouble) c_longdouble;
pub extern fn y0l(c_longdouble) c_longdouble;
pub extern fn y1l(c_longdouble) c_longdouble;
pub extern fn ynl(c_int, c_longdouble) c_longdouble;
pub extern fn erfl(c_longdouble) c_longdouble;
pub extern fn erfcl(c_longdouble) c_longdouble;
pub extern fn lgammal(c_longdouble) c_longdouble;
pub extern fn tgammal(c_longdouble) c_longdouble;
pub extern fn gammal(c_longdouble) c_longdouble;
pub extern fn lgammal_r(c_longdouble, __signgamp: [*c]c_int) c_longdouble;
pub extern fn rintl(__x: c_longdouble) c_longdouble;
pub extern fn nextafterl(__x: c_longdouble, __y: c_longdouble) c_longdouble;
pub extern fn nexttowardl(__x: c_longdouble, __y: c_longdouble) c_longdouble;
pub extern fn remainderl(__x: c_longdouble, __y: c_longdouble) c_longdouble;
pub extern fn scalbnl(__x: c_longdouble, __n: c_int) c_longdouble;
pub extern fn ilogbl(__x: c_longdouble) c_int;
pub extern fn scalblnl(__x: c_longdouble, __n: c_long) c_longdouble;
pub extern fn nearbyintl(__x: c_longdouble) c_longdouble;
pub extern fn roundl(__x: c_longdouble) c_longdouble;
pub extern fn truncl(__x: c_longdouble) c_longdouble;
pub extern fn remquol(__x: c_longdouble, __y: c_longdouble, __quo: [*c]c_int) c_longdouble;
pub extern fn lrintl(__x: c_longdouble) c_long;
pub extern fn llrintl(__x: c_longdouble) c_longlong;
pub extern fn lroundl(__x: c_longdouble) c_long;
pub extern fn llroundl(__x: c_longdouble) c_longlong;
pub extern fn fdiml(__x: c_longdouble, __y: c_longdouble) c_longdouble;
pub extern fn fmaxl(__x: c_longdouble, __y: c_longdouble) c_longdouble;
pub extern fn fminl(__x: c_longdouble, __y: c_longdouble) c_longdouble;
pub extern fn fmal(__x: c_longdouble, __y: c_longdouble, __z: c_longdouble) c_longdouble;
pub extern fn scalbl(__x: c_longdouble, __n: c_longdouble) c_longdouble;
pub extern var signgam: c_int;
pub const FP_NAN = @enumToInt(enum_unnamed_59.FP_NAN);
pub const FP_INFINITE = @enumToInt(enum_unnamed_59.FP_INFINITE);
pub const FP_ZERO = @enumToInt(enum_unnamed_59.FP_ZERO);
pub const FP_SUBNORMAL = @enumToInt(enum_unnamed_59.FP_SUBNORMAL);
pub const FP_NORMAL = @enumToInt(enum_unnamed_59.FP_NORMAL);
const enum_unnamed_59 = extern enum(c_int) {
    FP_NAN = 0,
    FP_INFINITE = 1,
    FP_ZERO = 2,
    FP_SUBNORMAL = 3,
    FP_NORMAL = 4,
    _,
};
pub fn EaseLinearNone(arg_t: f32, arg_b: f32, arg_c: f32, arg_d: f32) callconv(.C) f32 {
    var t = arg_t;
    var b = arg_b;
    var c = arg_c;
    var d = arg_d;
    return (@divTrunc((c * t), d) + b);
}
pub fn EaseLinearIn(arg_t: f32, arg_b: f32, arg_c: f32, arg_d: f32) callconv(.C) f32 {
    var t = arg_t;
    var b = arg_b;
    var c = arg_c;
    var d = arg_d;
    return (@divTrunc((c * t), d) + b);
}
pub fn EaseLinearOut(arg_t: f32, arg_b: f32, arg_c: f32, arg_d: f32) callconv(.C) f32 {
    var t = arg_t;
    var b = arg_b;
    var c = arg_c;
    var d = arg_d;
    return (@divTrunc((c * t), d) + b);
}
pub fn EaseLinearInOut(arg_t: f32, arg_b: f32, arg_c: f32, arg_d: f32) callconv(.C) f32 {
    var t = arg_t;
    var b = arg_b;
    var c = arg_c;
    var d = arg_d;
    return (@divTrunc((c * t), d) + b);
}
pub fn EaseSineIn(arg_t: f32, arg_b: f32, arg_c: f32, arg_d: f32) callconv(.C) f32 {
    var t = arg_t;
    var b = arg_b;
    var c = arg_c;
    var d = arg_d;
    return @floatCast(f32, (((@floatCast(f64, -c) * cos(@floatCast(f64, (@divTrunc(t, d) * (@divTrunc(3.1415927410125732, @intToFloat(f32, @as(c_int, 2)))))))) + @floatCast(f64, c)) + @floatCast(f64, b)));
}
pub fn EaseSineOut(arg_t: f32, arg_b: f32, arg_c: f32, arg_d: f32) callconv(.C) f32 {
    var t = arg_t;
    var b = arg_b;
    var c = arg_c;
    var d = arg_d;
    return @floatCast(f32, ((@floatCast(f64, c) * sin(@floatCast(f64, (@divTrunc(t, d) * (@divTrunc(3.1415927410125732, @intToFloat(f32, @as(c_int, 2)))))))) + @floatCast(f64, b)));
}
pub fn EaseSineInOut(arg_t: f32, arg_b: f32, arg_c: f32, arg_d: f32) callconv(.C) f32 {
    var t = arg_t;
    var b = arg_b;
    var c = arg_c;
    var d = arg_d;
    return @floatCast(f32, ((@floatCast(f64, @divTrunc(-c, @intToFloat(f32, @as(c_int, 2)))) * (cos(@floatCast(f64, @divTrunc((3.1415927410125732 * t), d))) - @intToFloat(f64, @as(c_int, 1)))) + @floatCast(f64, b)));
}
pub const EaseCircIn = @compileError("unable to translate function");
pub fn EaseCircOut(arg_t: f32, arg_b: f32, arg_c: f32, arg_d: f32) callconv(.C) f32 {
    var t = arg_t;
    var b = arg_b;
    var c = arg_c;
    var d = arg_d;
    t = (@divTrunc(t, d) - @intToFloat(f32, @as(c_int, 1)));
    return @floatCast(f32, ((@floatCast(f64, c) * sqrt(@floatCast(f64, (@intToFloat(f32, @as(c_int, 1)) - (t * t))))) + @floatCast(f64, b)));
}
pub const EaseCircInOut = @compileError("unable to translate function");
pub const EaseCubicIn = @compileError("unable to translate function");
pub fn EaseCubicOut(arg_t: f32, arg_b: f32, arg_c: f32, arg_d: f32) callconv(.C) f32 {
    var t = arg_t;
    var b = arg_b;
    var c = arg_c;
    var d = arg_d;
    t = (@divTrunc(t, d) - @intToFloat(f32, @as(c_int, 1)));
    return ((c * (((t * t) * t) + @intToFloat(f32, @as(c_int, 1)))) + b);
}
pub const EaseCubicInOut = @compileError("unable to translate function");
pub const EaseQuadIn = @compileError("unable to translate function");
pub const EaseQuadOut = @compileError("unable to translate function");
pub const EaseQuadInOut = @compileError("unable to translate function");
pub fn EaseExpoIn(arg_t: f32, arg_b: f32, arg_c: f32, arg_d: f32) callconv(.C) f32 {
    var t = arg_t;
    var b = arg_b;
    var c = arg_c;
    var d = arg_d;
    return @floatCast(f32, if (t == @intToFloat(f32, @as(c_int, 0))) @floatCast(f64, b) else ((@floatCast(f64, c) * pow(@intToFloat(f64, @as(c_int, 2)), @floatCast(f64, (@intToFloat(f32, @as(c_int, 10)) * (@divTrunc(t, d) - @intToFloat(f32, @as(c_int, 1))))))) + @floatCast(f64, b)));
}
pub fn EaseExpoOut(arg_t: f32, arg_b: f32, arg_c: f32, arg_d: f32) callconv(.C) f32 {
    var t = arg_t;
    var b = arg_b;
    var c = arg_c;
    var d = arg_d;
    return @floatCast(f32, if (t == d) @floatCast(f64, (b + c)) else ((@floatCast(f64, c) * (-pow(@intToFloat(f64, @as(c_int, 2)), @floatCast(f64, @divTrunc((@intToFloat(f32, -@as(c_int, 10)) * t), d))) + @intToFloat(f64, @as(c_int, 1)))) + @floatCast(f64, b)));
}
pub const EaseExpoInOut = @compileError("unable to translate function");
pub const EaseBackIn = @compileError("unable to translate function");
pub fn EaseBackOut(arg_t: f32, arg_b: f32, arg_c: f32, arg_d: f32) callconv(.C) f32 {
    var t = arg_t;
    var b = arg_b;
    var c = arg_c;
    var d = arg_d;
    var s: f32 = 1.7015800476074219;
    t = (@divTrunc(t, d) - @intToFloat(f32, @as(c_int, 1)));
    return ((c * (((t * t) * (((s + @intToFloat(f32, @as(c_int, 1))) * t) + s)) + @intToFloat(f32, @as(c_int, 1)))) + b);
}
pub const EaseBackInOut = @compileError("unable to translate function");
pub const EaseBounceOut = @compileError("unable to translate function");
pub fn EaseBounceIn(arg_t: f32, arg_b: f32, arg_c: f32, arg_d: f32) callconv(.C) f32 {
    var t = arg_t;
    var b = arg_b;
    var c = arg_c;
    var d = arg_d;
    return ((c - EaseBounceOut((d - t), @intToFloat(f32, @as(c_int, 0)), c, d)) + b);
}
pub fn EaseBounceInOut(arg_t: f32, arg_b: f32, arg_c: f32, arg_d: f32) callconv(.C) f32 {
    var t = arg_t;
    var b = arg_b;
    var c = arg_c;
    var d = arg_d;
    if (t < @divTrunc(d, @intToFloat(f32, @as(c_int, 2)))) return ((EaseBounceIn((t * @intToFloat(f32, @as(c_int, 2))), @intToFloat(f32, @as(c_int, 0)), c, d) * 0.5) + b) else return (((EaseBounceOut(((t * @intToFloat(f32, @as(c_int, 2))) - d), @intToFloat(f32, @as(c_int, 0)), c, d) * 0.5) + (c * 0.5)) + b);
}
pub const EaseElasticIn = @compileError("unable to translate function");
pub const EaseElasticOut = @compileError("unable to translate function");
pub const EaseElasticInOut = @compileError("unable to translate function");
pub const PHYSICS_CIRCLE = @enumToInt(enum_PhysicsShapeType.PHYSICS_CIRCLE);
pub const PHYSICS_POLYGON = @enumToInt(enum_PhysicsShapeType.PHYSICS_POLYGON);
pub const enum_PhysicsShapeType = extern enum(c_int) {
    PHYSICS_CIRCLE,
    PHYSICS_POLYGON,
    _,
};
pub const PhysicsShapeType = enum_PhysicsShapeType;
pub const struct_PhysicsBodyData = @OpaqueType();
pub const PhysicsBody = ?*struct_PhysicsBodyData;
pub extern fn InitPhysics() void;
pub extern fn RunPhysicsStep() void;
pub extern fn SetPhysicsTimeStep(delta: f64) void;
pub extern fn IsPhysicsEnabled() bool;
pub extern fn SetPhysicsGravity(x: f32, y: f32) void;
pub extern fn CreatePhysicsBodyCircleShim(pos: * const Vector2, radius: f32, density: f32)  PhysicsBody;
pub        fn CreatePhysicsBodyCircle(pos: Vector2, radius: f32, density: f32) PhysicsBody {
   return  CreatePhysicsBodyCircleShim(&pos, radius, density);
}
pub extern fn CreatePhysicsBodyRectangleShim(pos: * const Vector2, width: f32, height: f32, density: f32)  PhysicsBody;
pub        fn CreatePhysicsBodyRectangle(pos: Vector2, width: f32, height: f32, density: f32) PhysicsBody {
   return  CreatePhysicsBodyRectangleShim(&pos, width, height, density);
}
pub extern fn CreatePhysicsBodyPolygonShim(pos: * const Vector2, radius: f32, sides: c_int, density: f32)  PhysicsBody;
pub        fn CreatePhysicsBodyPolygon(pos: Vector2, radius: f32, sides: c_int, density: f32) PhysicsBody {
   return  CreatePhysicsBodyPolygonShim(&pos, radius, sides, density);
}
pub extern fn PhysicsAddForceShim(body: PhysicsBody, force: * const Vector2)  void;
pub        fn PhysicsAddForce(body: PhysicsBody, force: Vector2) void {
    PhysicsAddForceShim(body, &force);
}
pub extern fn PhysicsAddTorque(body: PhysicsBody, amount: f32) void;
pub extern fn PhysicsShatterShim(body: PhysicsBody, position: * const Vector2, force: f32)  void;
pub        fn PhysicsShatter(body: PhysicsBody, position: Vector2, force: f32) void {
    PhysicsShatterShim(body, &position, force);
}
pub extern fn GetPhysicsBodiesCount() c_int;
pub extern fn GetPhysicsBody(index: c_int) PhysicsBody;
pub extern fn GetPhysicsShapeType(index: c_int) c_int;
pub extern fn GetPhysicsShapeVerticesCount(index: c_int) c_int;
pub extern fn GetPhysicsShapeVertex(body: PhysicsBody, vertex: c_int) Vector2;
pub extern fn SetPhysicsBodyRotation(body: PhysicsBody, radians: f32) void;
pub extern fn DestroyPhysicsBody(body: PhysicsBody) void;
pub extern fn ResetPhysics() void;
pub extern fn ClosePhysics() void;
pub const DEG2RAD = @compileError("unable to translate C expr: expected ')'' here");
pub const RAD2DEG = @compileError("unable to translate C expr: expected ')'' here");
pub const LIGHTGRAY = @compileError("unable to translate C expr: unexpected token Id{ .LBrace = void }");
pub const GRAY = @compileError("unable to translate C expr: unexpected token Id{ .LBrace = void }");
pub const DARKGRAY = @compileError("unable to translate C expr: unexpected token Id{ .LBrace = void }");
pub const YELLOW = @compileError("unable to translate C expr: unexpected token Id{ .LBrace = void }");
pub const GOLD = @compileError("unable to translate C expr: unexpected token Id{ .LBrace = void }");
pub const ORANGE = @compileError("unable to translate C expr: unexpected token Id{ .LBrace = void }");
pub const PINK = @compileError("unable to translate C expr: unexpected token Id{ .LBrace = void }");
pub const RED = @compileError("unable to translate C expr: unexpected token Id{ .LBrace = void }");
pub const MAROON = @compileError("unable to translate C expr: unexpected token Id{ .LBrace = void }");
pub const GREEN = @compileError("unable to translate C expr: unexpected token Id{ .LBrace = void }");
pub const LIME = @compileError("unable to translate C expr: unexpected token Id{ .LBrace = void }");
pub const DARKGREEN = @compileError("unable to translate C expr: unexpected token Id{ .LBrace = void }");
pub const SKYBLUE = @compileError("unable to translate C expr: unexpected token Id{ .LBrace = void }");
pub const BLUE = @compileError("unable to translate C expr: unexpected token Id{ .LBrace = void }");
pub const DARKBLUE = @compileError("unable to translate C expr: unexpected token Id{ .LBrace = void }");
pub const PURPLE = @compileError("unable to translate C expr: unexpected token Id{ .LBrace = void }");
pub const VIOLET = @compileError("unable to translate C expr: unexpected token Id{ .LBrace = void }");
pub const DARKPURPLE = @compileError("unable to translate C expr: unexpected token Id{ .LBrace = void }");
pub const BEIGE = @compileError("unable to translate C expr: unexpected token Id{ .LBrace = void }");
pub const BROWN = @compileError("unable to translate C expr: unexpected token Id{ .LBrace = void }");
pub const DARKBROWN = @compileError("unable to translate C expr: unexpected token Id{ .LBrace = void }");
pub const WHITE = Color{.r = 255, .g = 255, .b = 255, .a = 255};
pub const BLACK = @compileError("unable to translate C expr: unexpected token Id{ .LBrace = void }");
pub const BLANK = @compileError("unable to translate C expr: unexpected token Id{ .LBrace = void }");
pub const MAGENTA = @compileError("unable to translate C expr: unexpected token Id{ .LBrace = void }");
pub const RAYWHITE = @compileError("unable to translate C expr: unexpected token Id{ .LBrace = void }");
pub const NULL = @compileError("unable to translate C expr: expected ')'' here");
pub const MB_CUR_MAX = @compileError("unable to translate C expr: unexpected token Id{ .RParen = void }");
pub const EASEDEF = @compileError("unable to translate C expr: unexpected token Id{ .Keyword_static = void }");
pub const HUGE_VAL = @compileError("unable to translate C expr: unexpected token Id{ .RParen = void }");
pub const HUGE_VALF = @compileError("unable to translate C expr: unexpected token Id{ .RParen = void }");
pub const HUGE_VALL = @compileError("unable to translate C expr: unexpected token Id{ .RParen = void }");
pub const INFINITY = @compileError("unable to translate C expr: unexpected token Id{ .RParen = void }");
pub const PHYSACDEF = @compileError("unable to translate C expr: unexpected token Id{ .Keyword_extern = void }");
pub const PHYSAC_DEG2RAD = @compileError("unable to translate C expr: expected ')'' here");
pub inline fn va_start(ap: var, param: var) @TypeOf(__builtin_va_start(ap, param)) {
    return __builtin_va_start(ap, param);
}
pub inline fn __GNUC_PREREQ(maj: var, min: var) @TypeOf(__GNUC__ << 16 + __GNUC_MINOR__ >= maj << 16 + min) {
    return __GNUC__ << 16 + __GNUC_MINOR__ >= maj << 16 + min;
}
pub const PDP_ENDIAN = __PDP_ENDIAN;
pub inline fn htobe64(x: var) @TypeOf(__bswap_64(x)) {
    return __bswap_64(x);
}
pub const WNOWAIT = 0x01000000;
pub inline fn le16toh(x: var) @TypeOf(__uint16_identity(x)) {
    return __uint16_identity(x);
}
pub const PHYSAC_MAX_BODIES = 64;
pub const RAYGUI_VERSION = "2.5-dev";
pub inline fn WIFSIGNALED(status: var) @TypeOf(__WIFSIGNALED(status)) {
    return __WIFSIGNALED(status);
}
pub inline fn __builtin_nansf32x(x: var) @TypeOf(__builtin_nans(x)) {
    return __builtin_nans(x);
}
pub inline fn __glibc_likely(cond: var) @TypeOf(__builtin_expect(cond, 1)) {
    return __builtin_expect(cond, 1);
}
pub inline fn htobe32(x: var) @TypeOf(__bswap_32(x)) {
    return __bswap_32(x);
}
pub const EXIT_SUCCESS = 0;
pub const M_LOG10E = 0.43429448190325182765;
pub const BIG_ENDIAN = __BIG_ENDIAN;
pub inline fn FD_ISSET(fd: var, fdsetp: var) @TypeOf(__FD_ISSET(fd, fdsetp)) {
    return __FD_ISSET(fd, fdsetp);
}
pub inline fn __attribute_deprecated_msg__(msg: var) @TypeOf(__attribute__(__deprecated__(msg))) {
    return __attribute__(__deprecated__(msg));
}
pub const PHYSAC_MAX_MANIFOLDS = 4096;
pub const FormatText = TextFormat;
pub inline fn isless(x: var, y: var) @TypeOf(__builtin_isless(x, y)) {
    return __builtin_isless(x, y);
}
pub inline fn islessequal(x: var, y: var) @TypeOf(__builtin_islessequal(x, y)) {
    return __builtin_islessequal(x, y);
}
pub inline fn __bswap_constant_32(x: var) @TypeOf(x & @as(c_uint, 0xff000000) >> 24 | x & @as(c_uint, 0x00ff0000) >> 8 | x & @as(c_uint, 0x0000ff00) << 8 | x & @as(c_uint, 0x000000ff) << 24) {
    return x & @as(c_uint, 0xff000000) >> 24 | x & @as(c_uint, 0x00ff0000) >> 8 | x & @as(c_uint, 0x0000ff00) << 8 | x & @as(c_uint, 0x000000ff) << 24;
}
pub inline fn __va_copy(d: var, s: var) @TypeOf(__builtin_va_copy(d, s)) {
    return __builtin_va_copy(d, s);
}
pub inline fn be32toh(x: var) @TypeOf(__bswap_32(x)) {
    return __bswap_32(x);
}
pub inline fn FD_ZERO(fdsetp: var) @TypeOf(__FD_ZERO(fdsetp)) {
    return __FD_ZERO(fdsetp);
}
pub inline fn htole16(x: var) @TypeOf(__uint16_identity(x)) {
    return __uint16_identity(x);
}
pub inline fn RL_REALLOC(n: var, sz: var) @TypeOf(realloc(n, sz)) {
    return realloc(n, sz);
}
pub const unix = 1;
pub inline fn __builtin_nansf64(x: var) @TypeOf(__builtin_nans(x)) {
    return __builtin_nans(x);
}
pub inline fn FD_SET(fd: var, fdsetp: var) @TypeOf(__FD_SET(fd, fdsetp)) {
    return __FD_SET(fd, fdsetp);
}
pub const ShowWindow = UnhideWindow;
pub const MATH_ERREXCEPT = 2;
pub inline fn __bswap_constant_64(x: var) @TypeOf(x & @as(c_ulonglong, 0xff00000000000000) >> 56 | x & @as(c_ulonglong, 0x00ff000000000000) >> 40 | x & @as(c_ulonglong, 0x0000ff0000000000) >> 24 | x & @as(c_ulonglong, 0x000000ff00000000) >> 8 | x & @as(c_ulonglong, 0x00000000ff000000) << 8 | x & @as(c_ulonglong, 0x0000000000ff0000) << 24 | x & @as(c_ulonglong, 0x000000000000ff00) << 40 | x & @as(c_ulonglong, 0x00000000000000ff) << 56) {
    return x & @as(c_ulonglong, 0xff00000000000000) >> 56 | x & @as(c_ulonglong, 0x00ff000000000000) >> 40 | x & @as(c_ulonglong, 0x0000ff0000000000) >> 24 | x & @as(c_ulonglong, 0x000000ff00000000) >> 8 | x & @as(c_ulonglong, 0x00000000ff000000) << 8 | x & @as(c_ulonglong, 0x0000000000ff0000) << 24 | x & @as(c_ulonglong, 0x000000000000ff00) << 40 | x & @as(c_ulonglong, 0x00000000000000ff) << 56;
}
pub const NFDBITS = __NFDBITS;
pub inline fn WTERMSIG(status: var) @TypeOf(__WTERMSIG(status)) {
    return __WTERMSIG(status);
}
pub const WSTOPPED = 2;
pub const MATH_ERRNO = 1;
pub const LITTLE_ENDIAN = __LITTLE_ENDIAN;
pub const PI = @as(f32, 3.14159265358979323846);
pub inline fn __P(args: var) @TypeOf(args) {
    return args;
}
pub const M_SQRT1_2 = 0.70710678118654752440;
pub const WNOHANG = 1;
pub inline fn __glibc_clang_prereq(maj: var, min: var) @TypeOf(__clang_major__ << 16 + __clang_minor__ >= maj << 16 + min) {
    return __clang_major__ << 16 + __clang_minor__ >= maj << 16 + min;
}
pub inline fn RL_FREE(p: var) @TypeOf(free(p)) {
    return free(p);
}
pub inline fn va_copy(dest: var, src: var) @TypeOf(__builtin_va_copy(dest, src)) {
    return __builtin_va_copy(dest, src);
}
pub inline fn __bos(ptr: var) @TypeOf(__builtin_object_size(ptr, __USE_FORTIFY_LEVEL > 1)) {
    return __builtin_object_size(ptr, __USE_FORTIFY_LEVEL > 1);
}
pub const PHYSAC_MAX_VERTICES = 24;
pub inline fn isunordered(x: var, y: var) @TypeOf(__builtin_isunordered(x, y)) {
    return __builtin_isunordered(x, y);
}
pub inline fn WEXITSTATUS(status: var) @TypeOf(__WEXITSTATUS(status)) {
    return __WEXITSTATUS(status);
}
pub const @"false" = 0;
pub inline fn __MATHCALL_NARROW(func: var, redir: var, nargs: var) @TypeOf(__MATHCALL_NARROW_NORMAL(func, nargs)) {
    return __MATHCALL_NARROW_NORMAL(func, nargs);
}
pub inline fn __glibc_unlikely(cond: var) @TypeOf(__builtin_expect(cond, 0)) {
    return __builtin_expect(cond, 0);
}
pub inline fn __glibc_has_attribute(attr: var) @TypeOf(__has_attribute(attr)) {
    return __has_attribute(attr);
}
pub inline fn WIFEXITED(status: var) @TypeOf(__WIFEXITED(status)) {
    return __WIFEXITED(status);
}
pub inline fn signbit(x: var) @TypeOf(__builtin_signbit(x)) {
    return __builtin_signbit(x);
}
pub inline fn isfinite(x: var) @TypeOf(__builtin_isfinite(x)) {
    return __builtin_isfinite(x);
}
pub const FD_SETSIZE = __FD_SETSIZE;
pub inline fn __attribute_format_strfmon__(a: var, b: var) @TypeOf(__attribute__(__format__(__strfmon__, a, b))) {
    return __attribute__(__format__(__strfmon__, a, b));
}
pub inline fn PHYSAC_FREE(ptr: var) @TypeOf(free(ptr)) {
    return free(ptr);
}
pub inline fn fpclassify(x: var) @TypeOf(__builtin_fpclassify(FP_NAN, FP_INFINITE, FP_NORMAL, FP_SUBNORMAL, FP_ZERO, x)) {
    return __builtin_fpclassify(FP_NAN, FP_INFINITE, FP_NORMAL, FP_SUBNORMAL, FP_ZERO, x);
}
pub inline fn va_arg(ap: var, type_1: var) @TypeOf(__builtin_va_arg(ap, type_1)) {
    return __builtin_va_arg(ap, type_1);
}
pub inline fn __bswap_constant_16(x: var) @TypeOf(if (@typeId(@TypeOf(x >> 8 & 0xff | x & 0xff << 8)) == .Pointer) @ptrCast(__uint16_t, x >> 8 & 0xff | x & 0xff << 8) else if (@typeId(@TypeOf(x >> 8 & 0xff | x & 0xff << 8)) == .Int) @intToPtr(__uint16_t, x >> 8 & 0xff | x & 0xff << 8) else @as(__uint16_t, x >> 8 & 0xff | x & 0xff << 8)) {
    return if (@typeId(@TypeOf(x >> 8 & 0xff | x & 0xff << 8)) == .Pointer) @ptrCast(__uint16_t, x >> 8 & 0xff | x & 0xff << 8) else if (@typeId(@TypeOf(x >> 8 & 0xff | x & 0xff << 8)) == .Int) @intToPtr(__uint16_t, x >> 8 & 0xff | x & 0xff << 8) else @as(__uint16_t, x >> 8 & 0xff | x & 0xff << 8);
}
pub const SubText = TextSubtext;
pub const FP_ILOGBNAN = -2147483647 - 1;
pub inline fn __REDIRECT_LDBL(name: var, proto: var, alias: var) @TypeOf(__REDIRECT(name, proto, alias)) {
    return __REDIRECT(name, proto, alias);
}
pub const PHYSAC_PI = 3.14159265358979323846;
pub inline fn isnormal(x: var) @TypeOf(__builtin_isnormal(x)) {
    return __builtin_isnormal(x);
}
pub inline fn __builtin_nanf32x(x: var) @TypeOf(__builtin_nan(x)) {
    return __builtin_nan(x);
}
pub inline fn __WSTOPSIG(status: var) @TypeOf(__WEXITSTATUS(status)) {
    return __WEXITSTATUS(status);
}
pub const MAP_DIFFUSE = MAP_ALBEDO;
pub const NUM_PROPS_EXTENDED = 8;
pub const LOC_MAP_SPECULAR = LOC_MAP_METALNESS;
pub inline fn RL_CALLOC(n: var, sz: var) @TypeOf(calloc(n, sz)) {
    return calloc(n, sz);
}
pub inline fn htole32(x: var) @TypeOf(__uint32_identity(x)) {
    return __uint32_identity(x);
}
pub inline fn __bos0(ptr: var) @TypeOf(__builtin_object_size(ptr, 0)) {
    return __builtin_object_size(ptr, 0);
}
pub inline fn __REDIRECT_NTH_LDBL(name: var, proto: var, alias: var) @TypeOf(__REDIRECT_NTH(name, proto, alias)) {
    return __REDIRECT_NTH(name, proto, alias);
}
pub inline fn __WCOREDUMP(status: var) @TypeOf(status & __WCOREFLAG) {
    return status & __WCOREFLAG;
}
pub inline fn __builtin_nansf32(x: var) @TypeOf(__builtin_nansf(x)) {
    return __builtin_nansf(x);
}
pub const M_1_PI = 0.31830988618379067154;
pub inline fn __W_STOPCODE(sig: var) @TypeOf(sig << 8 | 0x7f) {
    return sig << 8 | 0x7f;
}
pub inline fn __glibc_clang_has_extension(ext: var) @TypeOf(__has_extension(ext)) {
    return __has_extension(ext);
}
pub const WUNTRACED = 2;
pub inline fn WSTOPSIG(status: var) @TypeOf(__WSTOPSIG(status)) {
    return __WSTOPSIG(status);
}
pub inline fn __WTERMSIG(status: var) @TypeOf(status & 0x7f) {
    return status & 0x7f;
}
pub inline fn le64toh(x: var) @TypeOf(__uint64_identity(x)) {
    return __uint64_identity(x);
}
pub inline fn __GLIBC_PREREQ(maj: var, min: var) @TypeOf(__GLIBC__ << 16 + __GLIBC_MINOR__ >= maj << 16 + min) {
    return __GLIBC__ << 16 + __GLIBC_MINOR__ >= maj << 16 + min;
}
pub const M_LN2 = 0.69314718055994530942;
pub const M_2_PI = 0.63661977236758134308;
pub const FP_ILOGB0 = -2147483647 - 1;
pub inline fn __f32x(x: var) @TypeOf(x) {
    return x;
}
pub const NUM_PROPS_DEFAULT = 16;
pub inline fn __WEXITSTATUS(status: var) @TypeOf(status & 0xff00 >> 8) {
    return status & 0xff00 >> 8;
}
pub inline fn __PMT(args: var) @TypeOf(args) {
    return args;
}
pub inline fn htole64(x: var) @TypeOf(__uint64_identity(x)) {
    return __uint64_identity(x);
}
pub const TEXTEDIT_CURSOR_BLINK_FRAMES = 20;
pub const M_PI_2 = 1.57079632679489661923;
pub inline fn RL_MALLOC(sz: var) @TypeOf(malloc(sz)) {
    return malloc(sz);
}
pub inline fn be64toh(x: var) @TypeOf(__bswap_64(x)) {
    return __bswap_64(x);
}
pub inline fn isgreater(x: var, y: var) @TypeOf(__builtin_isgreater(x, y)) {
    return __builtin_isgreater(x, y);
}
pub const M_PI = 3.14159265358979323846;
pub const MAX_TOUCH_POINTS = 10;
pub inline fn __MATHCALLX(function: var, suffix: var, args: var, attrib: var) @TypeOf(__MATHDECLX(_Mdouble_, function, suffix, args, attrib)) {
    return __MATHDECLX(_Mdouble_, function, suffix, args, attrib);
}
pub inline fn __FDS_BITS(set: var) @TypeOf(set.*.__fds_bits) {
    return set.*.__fds_bits;
}
pub const linux = 1;
pub inline fn __W_EXITCODE(ret: var, sig: var) @TypeOf(ret << 8 | sig) {
    return ret << 8 | sig;
}
pub const PHYSAC_PENETRATION_CORRECTION = @as(f32, 0.4);
pub inline fn __MATH_PRECNAME(name: var, r: var) @TypeOf(__CONCAT(name, r)) {
    return __CONCAT(name, r);
}
pub const M_E = 2.7182818284590452354;
pub const @"true" = 1;
pub inline fn __builtin_nanf64(x: var) @TypeOf(__builtin_nan(x)) {
    return __builtin_nan(x);
}
pub inline fn FD_CLR(fd: var, fdsetp: var) @TypeOf(__FD_CLR(fd, fdsetp)) {
    return __FD_CLR(fd, fdsetp);
}
pub const PHYSAC_COLLISION_ITERATIONS = 100;
pub const M_PI_4 = 0.78539816339744830962;
pub const M_LOG2E = 1.4426950408889634074;
pub inline fn islessgreater(x: var, y: var) @TypeOf(__builtin_islessgreater(x, y)) {
    return __builtin_islessgreater(x, y);
}
pub const PHYSAC_PENETRATION_ALLOWANCE = @as(f32, 0.05);
pub const M_2_SQRTPI = 1.12837916709551257390;
pub inline fn WIFCONTINUED(status: var) @TypeOf(__WIFCONTINUED(status)) {
    return __WIFCONTINUED(status);
}
pub inline fn __builtin_nansf64x(x: var) @TypeOf(__builtin_nansl(x)) {
    return __builtin_nansl(x);
}
pub inline fn le32toh(x: var) @TypeOf(__uint32_identity(x)) {
    return __uint32_identity(x);
}
pub inline fn WIFSTOPPED(status: var) @TypeOf(__WIFSTOPPED(status)) {
    return __WIFSTOPPED(status);
}
pub inline fn CLITERAL(type_1: var) @TypeOf(type_1) {
    return type_1;
}
pub const SpriteFont = Font;
pub const RAND_MAX = 2147483647;
pub inline fn __ASMNAME(cname: var) @TypeOf(__ASMNAME2(__USER_LABEL_PREFIX__, cname)) {
    return __ASMNAME2(__USER_LABEL_PREFIX__, cname);
}
pub const LOC_MAP_DIFFUSE = LOC_MAP_ALBEDO;
pub inline fn __attribute_format_arg__(x: var) @TypeOf(__attribute__(__format_arg__(x))) {
    return __attribute__(__format_arg__(x));
}
pub const BYTE_ORDER = __BYTE_ORDER;
pub const EXIT_FAILURE = 1;
pub const M_SQRT2 = 1.41421356237309504880;
pub inline fn PHYSAC_MALLOC(size: var) @TypeOf(malloc(size)) {
    return malloc(size);
}
pub inline fn __builtin_nanf32(x: var) @TypeOf(__builtin_nanf(x)) {
    return __builtin_nanf(x);
}
pub const M_LN10 = 2.30258509299404568402;
pub inline fn htobe16(x: var) @TypeOf(__bswap_16(x)) {
    return __bswap_16(x);
}
pub const math_errhandling = MATH_ERRNO | MATH_ERREXCEPT;
pub const WEXITED = 4;
pub const MAP_SPECULAR = MAP_METALNESS;
pub const WCONTINUED = 8;
pub inline fn __builtin_nanf64x(x: var) @TypeOf(__builtin_nanl(x)) {
    return __builtin_nanl(x);
}
pub const PHYSAC_CIRCLE_VERTICES = 24;
pub inline fn isgreaterequal(x: var, y: var) @TypeOf(__builtin_isgreaterequal(x, y)) {
    return __builtin_isgreaterequal(x, y);
}
pub const NAN = __builtin_nanf("");
pub inline fn __MATHCALL(function: var, suffix: var, args: var) @TypeOf(__MATHDECL(_Mdouble_, function, suffix, args)) {
    return __MATHDECL(_Mdouble_, function, suffix, args);
}
pub inline fn be16toh(x: var) @TypeOf(__bswap_16(x)) {
    return __bswap_16(x);
}
pub inline fn __SIMD_DECL(function: var) @TypeOf(__CONCAT(__DECL_SIMD_, function)) {
    return __CONCAT(__DECL_SIMD_, function);
}
pub inline fn va_end(ap: var) @TypeOf(__builtin_va_end(ap)) {
    return __builtin_va_end(ap);
}
pub inline fn __f64(x: var) @TypeOf(x) {
    return x;
}
pub const NUM_CONTROLS = 16;
pub const timeval = struct_timeval;
pub const timespec = struct_timespec;
pub const random_data = struct_random_data;
pub const drand48_data = struct_drand48_data;
pub const PhysicsBodyData = struct_PhysicsBodyData;
