# Package

version       = "0.1.0"
author        = "Yehowshua Immanuel"
description   = "Toy rasterizer written in Nim."
license       = "GPL-3.0-or-later"
srcDir        = "src"
bin           = @["nimRasterizer"]


# Dependencies

requires "nim >= 1.4.6", "simplepng", "print", "itertools", "sdl2"
