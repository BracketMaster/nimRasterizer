import framebuffer
import core
import colors

proc lineByY(fb : var FrameBuffer, p1, p2 : fbCoord, color : Pixel) = 
    var dp      = p2 - p1
    var y_count = abs(p2.y - p1.y)
    for add_Y in 0..y_count:
        var curr_p = p1 + (add_Y/y_count)*dp
        fb[curr_p.y][curr_p.x] = color

proc lineByX(fb : var FrameBuffer, p1, p2 : fbCoord, color : Pixel) = 
    var dp      = p2 - p1
    var x_count = abs(p2.x - p1.x)
    for add_X in 0..x_count:
        var curr_p = p1 + (add_X/x_count)*dp
        fb[curr_p.y][curr_p.x] = color

proc line*(fb : var FrameBuffer, p1, p2 : fbCoord, color : Pixel) = 
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