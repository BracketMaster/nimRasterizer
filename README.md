# nimRasterizer

The Beginnings of a humble triangle rasterizer in Nim.

# Status

Draws a boring line...

![](docs/status.png)

# Installing
```bash
nimble install sdl2
git clone https://github.com/BracketMaster/nimRasterizer
cd nimRasterizer
nim c -r src/nimRasterizer
```

## MacOS Dependencies

```bash
brew install sdl2{,_gfx,_image,_mixer,_net,_ttf}
```

If the resulting ``nimRasterizer`` binariy can't find
the `sdl2` library, consider modifying ``config.nims``.