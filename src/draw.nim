import framebuffer
import core
import colors
import itertools

type Line* = tuple[p1: Vector2i, p2: Vector2i]

proc lineLow(fb : var FrameBuffer, line : Line, color : Pixel) = 
    var y0 = line.p1.y
    var y1 = line.p2.y
    var x0 = line.p1.x
    var x1 = line.p2.x

    var dx = x1 - x0
    var dy = y1 - y0
    var yi = 1
    if dy < 0:
        yi = -1
        dy = -dy

    var D = (2 * dy) - dx
    var y = y0

    for x in x0 .. x1:
        fb[y][x] = color
        if D > 0:
            y = y + yi
            D = D + (2 * (dy - dx))
        else:
            D = D + 2*dy

proc lineHigh(fb : var FrameBuffer, line : Line, color : Pixel) = 
    var y0 = line.p1.y
    var y1 = line.p2.y
    var x0 = line.p1.x
    var x1 = line.p2.x

    var dx = x1 - x0
    var dy = y1 - y0
    var xi = 1

    if dx < 0:
        xi = -1
        dx = -dx

    var D = (2 * dx) - dy
    var x = x0

    for y in y0 .. y1:
        fb[y][x] = color
        if D > 0:
            x = x + xi
            D = D + (2 * (dx - dy))
        else:
            D = D + 2*dx

proc line*(fb : var FrameBuffer, line : Line, color : Pixel) = 
    var y0 = line.p1.y
    var y1 = line.p2.y
    var x0 = line.p1.x
    var x1 = line.p2.x

    if abs(y1 - y0) < abs(x1 - x0):
        if x0 > x1:
            fb.lineLow((p1 : Vector2i(x : x1, y : y1), p2 : Vector2i(x : x0, y : y0)), color)
        else:
            fb.lineLow((p1 : Vector2i(x : x0, y : y0), p2 : Vector2i(x : x1, y : y1)), color)
    else:
        if y0 > y1:
            fb.lineHigh((p1 : Vector2i(x : x1, y : y1), p2 : Vector2i(x : x0, y : y0)), color)
        else:
            fb.lineHigh((p1 : Vector2i(x : x0, y : y0), p2 : Vector2i(x : x1, y : y1)), color)

proc triangleWire*(fb : var FrameBuffer, triangle : RasterTrianglei,  color : Pixel) = 
    var verticesAsSeq = @[triangle.a, triangle.b, triangle.c, triangle.a]
    # sliding window of two over vertices that wraps back around 
    # since we concatenate with vertices[0]
    for vertex_pair in windowed(verticesAsSeq, 2):
        fb.line((p1 : vertex_pair[0], p2: vertex_pair[1]), color)