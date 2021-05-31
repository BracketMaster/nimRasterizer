import framebuffer
import core
import colors
import itertools

proc lineByY(fb : var FrameBuffer, p1, p2 : Vector2i, color : Pixel) = 
    var dp      = p2 - p1
    var y_count = abs(p2.y - p1.y)
    for add_Y in 0..y_count:
        var curr_p = p1 + (add_Y/y_count)*dp
        fb[curr_p.y][curr_p.x] = color

proc lineByX(fb : var FrameBuffer, p1, p2 : Vector2i, color : Pixel) = 
    var dp      = p2 - p1
    var x_count = abs(p2.x - p1.x)
    for add_X in 0..x_count:
        var curr_p = p1 + (add_X/x_count)*dp
        fb[curr_p.y][curr_p.x] = color

proc line*(fb : var FrameBuffer, p1, p2 : Vector2i, color : Pixel) = 
    var y_count = abs(p2.y - p1.y)
    var x_count = abs(p2.x - p1.x)

    if (y_count == 0) and (x_count == 0):
        fb[p1.y][p1.x] = color
    elif y_count == x_count:
        lineByX(fb, p1, p2, color)
    elif y_count > x_count:
        lineByY(fb, p1, p2, color)
    elif x_count > y_count:
        lineByX(fb, p1, p2, color)
    else:
        echo "skipped"

proc wireT*(fb : var FrameBuffer, triangle : VectorTriangle, buf_width : int, buf_height : int, color : Pixel) = 
    var vertices = triangle.vertices
    var verticesAsSeq = @[vertices.a, vertices.b, vertices.c, vertices.a]
    # sliding window of two over vertices that wraps back around 
    # since we concatenate with vertices[0]
    for vertex_pair in windowed(verticesAsSeq, 2):
        var x0 = ((vertex_pair[0].x + 1.0) * ((buf_width - 1)/2)).toInt
        var x1 = ((vertex_pair[1].x + 1.0) * ((buf_width - 1)/2)).toInt

        var y0 = ((vertex_pair[0].y + 1.0) * ((buf_height - 1)/2)).toInt
        var y1 = ((vertex_pair[1].y + 1.0) * ((buf_height - 1)/2)).toInt
        fb.line(Vector2i(x:x0, y:y0), Vector2i(x:x1, y:y1), color)
