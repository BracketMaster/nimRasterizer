import framebuffer

proc line*(fb : var FrameBuffer, x0, y0, x1, y1 : float64, color : Pixel) = 
    var t = 0.0
    while t < 1.0:
        var x = (x0 + (x1 - x0)*t).toInt
        var y = (y0 + (y1 - y0)*t).toInt
        fb[y][x] = color
        t += 0.01