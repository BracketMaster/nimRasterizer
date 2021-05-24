import random
import framebuffer
import draw
import colors

var fb : FrameBuffer[300, 400]
fb.line(0,0,50,50,RED)
fb.paint()