import random
import framebuffer
import core
import draw
import colors

var fb : FrameBuffer[300, 400]
# fb.line(0,0,50,50,RED)
fb.line(Point(x:0, y:0), Point(x:50, y:50), RED)
fb.paint()