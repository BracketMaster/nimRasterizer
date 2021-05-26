import random, itertools, sugar
import framebuffer, core, draw, colors
import objReader, print, sequtils

#let window_iter = slideWrap(arr, 2)
# var arr = toSeq(0..2)
# for grouping in windowed(arr & arr[0], 2):
#     echo grouping
const fb_width    = 400
const fb_height   = 300
var fb : FrameBuffer[fb_height, fb_width]

let african_head = "resources/african_head.obj".open
var triangles = african_head.readOBJ

# var collect_values    = map(triangles, (el) => el.v1.y) 
# print(max(collect_values))
# print(min(collect_values))

for triangle in triangles:
    var vertices = triangle.vertices
    # sliding window of two over vertices that wraps back around 
    # since we concatenate with vertices[0]
    for vertex_pair in windowed(vertices & vertices[0], 2):
        var x0 = ((vertex_pair[0].x + 1.0) * ((fb_width - 1)/2)).toInt
        var x1 = ((vertex_pair[1].x + 1.0) * ((fb_width - 1)/2)).toInt

        var y0 = ((vertex_pair[0].y + 1.0) * ((fb_height - 1)/2)).toInt
        var y1 = ((vertex_pair[1].y + 1.0) * ((fb_height - 1)/2)).toInt
        fb.line(fbCoord(x:x0, y:y0), fbCoord(x:x1, y:y1), WHITE)

fb.paint()