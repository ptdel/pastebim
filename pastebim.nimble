# Package

version       = "0.1.0"
author        = "Patrick Delaney"
description   = "A Pastebim in Nim"
license       = "MIT"
srcDir        = "src"
installExt    = @["nim"]
bin           = @["pastebim"]



# Dependencies

requires [
    "nim >= 1.0.4", 
    "rosencrantz >= 0.4.3", 
    "sysrandom >= 1.1.0",
    "parsetoml >= 0.5.0"
]
