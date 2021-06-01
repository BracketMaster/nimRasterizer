import random, itertools, sugar
import framebuffer, core, draw, colors
import objReader, print, sequtils, pipeline

const fb_width    = 800
const fb_height   = 600
var fb : FrameBuffer[fb_height, fb_width]

let african_head = "resources/african_head.obj".open
var triangles = african_head.readOBJ

proc pointInTriangle(triangle : RasterTrianglei, P : Vector2i) : bool = 
    var A = triangle.a
    var B = triangle.b
    var C = triangle.c

    var vAC = C - A
    var vAB = B - A
    var vPA = A - P

    # print Vector3i(x:vAB.x, y:vAC.x, z:vPA.x)
    # print Vector3i(x:vAB.y, y:vAC.y, z:vPA.y)
    # print (vAC, vAB, vPA)

    var cross_product = cross(
        Vector3i(x:vAB.x, y:vAC.x, z:vPA.x), 
        Vector3i(x:vAB.y, y:vAC.y, z:vPA.y), 
    )
    # print cross_product
    var x = cross_product.x
    var y = cross_product.y
    var z = cross_product.z

    # degenerate triangle, AKA, line or point
    if z == 0:
        return false

    # non-degenrate cases
    if z > 0:
        if (x + y - z) > 0:
            return false
        if y < 0:
            return false
        if x < 0:
            return false
    if z < 0:
        if (x + y - z) < 0:
            return false
        if y > 0:
            return false
        if x > 0:
            return false
    return true

type
    bounds = tuple
        left    : int
        right   : int
        up      : int
        down    : int

proc triangleBounds(triangle : RasterTrianglei) : bounds = 
    var verts = @[triangle.a, triangle.b, triangle.c]
    var x_coords = verts.map((triangle) => triangle.x)
    var y_coords = verts.map((triangle) => triangle.y)

    result.left     = min(x_coords)
    result.right    = max(x_coords)
    result.up       = max(y_coords)
    result.down     = min(y_coords)

proc triangleFill(fb : var Framebuffer, triangle : RasterTrianglei, color : Pixel) =
    var tBounds = triangle.triangleBounds()

    for y in tBounds.down .. tBounds.up:
        for x in tBounds.left .. tBounds.right:
            var point = Vector2i(x : x, y : y)
            if triangle.pointInTriangle(point):
                fb[y][x] = color


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
    var projectedT = triangle.projection(fb_width, fb_height)
    fb.triangleFill(projectedT, WHITE)

fb.paintPNG()
fb.paintScreen()