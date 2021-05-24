import random
import framebuffer
import sdl2
import sdl2/ttf

# proc main = 
var fb : FrameBuffer[400, 400]
for row in 0..200:
  for col in 0..100:
    fb[row][col].red = 128u8
    fb[row][col].green = 128u8
    fb[row][col].blue = 128u8
fb.paint()

# when isMainModule:
#   main()