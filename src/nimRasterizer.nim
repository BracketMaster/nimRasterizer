import framebuffer, draw, colors
import objReader, print, pipeline

const fb_width    = 800
const fb_height   = 600
var fb : FrameBuffer[fb_height, fb_width]

let african_head = "resources/african_head.obj".open
var triangles = african_head.readOBJ


# some tests
# var a = Vector2i(x: 0, y:0)
# var b = Vector2i(x: 50, y:50)
# var c = Vector2i(x: 30, y:40)
# var d = Vector2i(x: 70, y:90)
# var e = Vector2i(x: 120, y:130)
# var myTri = RasterTrianglei(a : a, b : b, c: c)
# fb.line((p1 : d, p2 : e), WHITE)
# fb.triangleFill(myTri, WHITE)
# fb.triangleWire(myTri, RED)

var interval = 5
for triangle in triangles:
    var projectedT = triangle.projectScreen(fb_width, fb_height)
    fb.triangleFill(projectedT, WHITE)

fb.paintPNG()
fb.paintScreen()