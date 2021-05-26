import random, itertools
import framebuffer, core, draw, colors
import objReader, print, sequtils

#let window_iter = slideWrap(arr, 2)
# var arr = toSeq(0..2)
# for grouping in windowed(arr & arr[0], 2):
#     echo grouping

var fb : FrameBuffer[300, 400]

# fb.line(fbCoord(x:0, y:0), fbCoord(x:50, y:50), RED)
# fb.line(fbCoord(x:50, y:0), fbCoord(x:50, y:50), GREEN)
# fb.line(fbCoord(x:0, y:50), fbCoord(x:50, y:50), YELLOW)
# fb.line(fbCoord(x:200, y:150), fbCoord(x:200, y:150), WHITE)
# fb.line(fbCoord(x:13, y:20), fbCoord(x:80, y:40), MAROON); 
# fb.line(fbCoord(x:20, y:13), fbCoord(x:40, y:80), AQUA); 
# fb.line(fbCoord(x:80, y:40), fbCoord(x:13, y:20), PURPLE);
# fb.paint()


let african_head = "resources/african_head.obj".open
var triangles = african_head.readOBJ

for triangle in triangles[0..1]:
    var vertices = triangle.vertices
    for vertex_pair in windowed(vertices & vertices[0], 2):
        print(vertex_pair)


# print(triangles.len)
# print(triangles[13])
