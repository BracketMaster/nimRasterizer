import random
import sdl2
import sdl2/ttf

type
  Pixel = object
    red*: byte
    green*: byte
    blue*: byte
  FrameBuffer*[R, C: static[int]] =
    array[R, array[C, Pixel]]


const
  WindowWidth = 640
  WindowHeight = 480

type SDLException = object of Defect

template sdlFailIf(condition: typed, reason: string) =
  if condition: raise SDLException.newException(
    reason & ", SDL error " & $getError()
  )

proc paint*(fb : FrameBuffer) =
  sdlFailIf(not sdl2.init(INIT_VIDEO or INIT_TIMER or INIT_EVENTS)):
    "SDL2 initialization failed"
  defer: sdl2.quit()

  let window = createWindow(
    title = "Pong",
    x = SDL_WINDOWPOS_CENTERED,
    y = SDL_WINDOWPOS_CENTERED,
    w = WindowWidth,
    h = WindowHeight,
    flags = SDL_WINDOW_SHOWN
  )

  sdlFailIf window.isNil: "window could not be created"
  defer: window.destroy()

  let renderer = createRenderer(
    window = window,
    index = -1,
    flags = Renderer_Accelerated or Renderer_PresentVsync or Renderer_TargetTexture
  )
  sdlFailIf renderer.isNil: "renderer could not be created"
  defer: renderer.destroy()
  renderer.clear
  renderer.setDrawColor 255, 255, 255, 255 # white
  for x in 0..10:
    for y in 0..10:
      renderer.drawPoint(cint(x),cint(y))
  renderer.present()

  var running = true
  while running:
    var event = defaultEvent

    while pollEvent(event):
      case event.kind
      of QuitEvent:
        running = false
        break
      else:
        discard

# var fb : FrameBuffer[400, 400]
# for row in 0..200:
#   for col in 0..100:
#     fb[row][col].red = 128u8
#     fb[row][col].green = 128u8
#     fb[row][col].blue = 128u8
# fb.paint()