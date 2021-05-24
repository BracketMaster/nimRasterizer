import random
import sdl2
import sdl2/ttf

type
  Pixel* = object
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
  var width  = fb[0].high
  var height = fb.high
  sdlFailIf(not sdl2.init(INIT_VIDEO or INIT_TIMER or INIT_EVENTS).toBool):
    "SDL2 initialization failed"
  defer: sdl2.quit()

  let window = createWindow(
    title = "FrameBuffer",
    x = SDL_WINDOWPOS_CENTERED,
    y = SDL_WINDOWPOS_CENTERED,
    w = width,
    h = height,
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
  for r_index, row in fb:
    for c_index, pixel in row:
      renderer.setDrawColor pixel.red, pixel.green, pixel.blue, 255
      renderer.drawPoint(cint(c_index),cint(height - r_index - 1))
  renderer.present()

  var running = true
  while running:
    var event = defaultEvent

    while pollEvent(event).toBool:
      case event.kind
      of QuitEvent:
        running = false
        break
      else:
        discard