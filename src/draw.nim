import framebuffer
import core

# proc lineByY(fb : var FrameBuffer, x0, y0, x1, y1 : float64, color : Pixel) = 
#     var dy = (if (y1 > y0): 1 else: -1)
#     var m = (y1 - y0)/(x1 - x0)

proc line*(fb : var FrameBuffer, p1, p2 : Point, color : Pixel) = 
    var dp = p2 - p1
    var t = 0.0
    while t < 1.0:
        var curr_p = p1 + t*dp
        fb[curr_p.y][curr_p.x] = color
        t += 0.01