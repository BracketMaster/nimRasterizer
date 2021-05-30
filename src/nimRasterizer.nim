import random, itertools, sugar
import framebuffer, core, draw, colors
import objReader, print, sequtils

const fb_width    = 800
const fb_height   = 600
var fb : FrameBuffer[fb_height, fb_width]

let african_head = "resources/african_head.obj".open
var triangles = african_head.readOBJ

# proc cross(a,b :  Vectori) : Vectori = 
#     var a1 = a.x; var a2 = a.y; var a3 = a.z
#     var b1 = b.x; var b2 = b.y; var b3 = b.z
#     result.x = a2*b3 - a3*b2
#     result.y = -(a1*b3  - a3*b1)
#     result.z = (a1*b2 - a2*b1)

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

# proc triangleBounds()

# render the head
for triangle in triangles[60 .. 125]:
    fb.wireT(triangle, fb_width, fb_height, WHITE)

fb.paint()