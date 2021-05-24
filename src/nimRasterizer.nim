import random
import framebuffer
import draw
import colors

var fb : FrameBuffer[400, 400]
fb.line(0,0,10,10,RED)
# for row in 0..200:
#   for col in 0..100:
#     fb[row][col].red = 128u8
#     fb[row][col].green = 128u8
#     fb[row][col].blue = 128u8
fb.paint()