import random
import simplepng
import sdl2
import print


type
  Pixel* = object
    red*: byte
    green*: byte
    blue*: byte
  FrameBuffer*[R, C: static[int]] =
    array[R, array[C, Pixel]]

## Write Resulting image to file
proc paintPNG*(fb : FrameBuffer) =
  var width  = fb[0].high
  var height = fb.high
  var p = initPixels(width + 1, height + 1)
  p.fill(0'u8, 0'u8, 0'u8, 255)

  for r_index, row in fb:
    for c_index, pixel in row:
      p[c_index, height - r_index].setColor(pixel.red, pixel.blue, pixel.green, 255'u8)

  simplePNG("sample.png", p)

## Draw directly to screen

type SDLException = object of Defect

template sdlFailIf(condition: typed, reason: string) =
  if condition: raise SDLException.newException(
    reason & ", SDL error " & $getError()
  )

proc paintScreen*(fb : FrameBuffer) =
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