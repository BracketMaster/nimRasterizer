import random, itertools, sugar
import framebuffer, core, draw, colors
import objReader, print, sequtils

const fb_width    = 800
const fb_height   = 600
var fb : FrameBuffer[fb_height, fb_width]

let african_head = "resources/african_head.obj".open
var triangles = african_head.readOBJ

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

# fb.line(fbCoord(x:0, y:104), fbCoord(x:270, y:100), WHITE)
fb.paint()