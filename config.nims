import distros

if defined(macosx):
    var default_sdl2 = "/usr/local/lib/libSDL2.dylib"
    var opt_homebrew_sdl2 = "/opt/homebrew/lib/libSDL2.dylib"
    var macports_sdl2 = "/opt/local/lib/libSDL2.dylib"
    if(not fileExists(default_sdl2)):
        if (fileExists(opt_homebrew_sdl2)):
            echo "using homebrew's sdl2"
            switch("dynlibOverride", "sdl2")
            switch("passL", opt_homebrew_sdl2)
        if (fileExists(macports_sdl2)):
            echo "using macports sdl2"
            switch("dynlibOverride", "sdl2")
            switch("passL", macports_sdl2)