import random
import framebuffer
import core
import draw
import colors

var fb : FrameBuffer[300, 400]
fb.line(Point(x:0, y:0), Point(x:50, y:50), RED)
fb.line(Point(x:50, y:0), Point(x:50, y:50), GREEN)
fb.line(Point(x:0, y:50), Point(x:50, y:50), YELLOW)
fb.line(Point(x:200, y:150), Point(x:200, y:150), WHITE)
fb.line(Point(x:13, y:20), Point(x:80, y:40), MAROON); 
fb.line(Point(x:20, y:13), Point(x:40, y:80), AQUA); 
fb.line(Point(x:80, y:40), Point(x:13, y:20), PURPLE);

fb.paint()