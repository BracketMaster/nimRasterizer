import random, itertools, sugar
import framebuffer, core, draw, colors
import objReader, print, sequtils

const fb_width    = 800
const fb_height   = 600
var fb : FrameBuffer[fb_height, fb_width]

let african_head = "resources/african_head.obj".open
var triangles = african_head.readOBJ

# proc pointInTriangle(triangle : Triangle, P : Vectori) : bool = 
#     var trianglei = triangle.verticesi()
#     var A = trianglei[0]; var B = trianglei[1]; var C = trianglei[2]
#     var vAC = C - A; var vAB = B - A; var vPA = A - P

#     var cross_product = cross(
#         Vectori(x:vAB.x, y:vAC.x, z:vPA.x), 
#         Vectori(x:vAB.y, y:vAC.y, z:vPA.y), 
#     )
#     var x = cross_product.x; var y = cross_product.y; var z = cross_product.z;

#     # degenerate triangle, AKA, line or point
#     if z == 0:
#         return false

#     # non-degenrate cases
#     if (x + y) < -z:
#         return false
#     if z > 0:
#         if y < 0:
#             return false
#         if x < 0:
#             return false
#     if z < 0:
#         if y > 0:
#             return false
#         if x > 0:
#             return false
#     return true

type
    bounds = tuple
        upper_left  : int
        upper_right : int
        lower_left  : int
        lower_right : int

# proc triangleBounds(triangle : RasterTriangle) : bounds = 
#     var verts = @[triangle.a, triangle.b, triangle.c]
#     var x_coords = verts.map((triangle) => triangle.x)
#     var y_coords = verts.map((triangle) => triangle.y)


# render the head

for triangle in triangles:
    fb.wireT(triangle, fb_width, fb_height, WHITE)

# fb.paintPNG()
fb.paintScreen()