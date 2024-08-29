# (pbo)Nuke: xplr file opener

open files from xplr with you favorite applications by mime or mime-regexp

plugin for [xplr](https://github.com/sayanarijit/xplr)

forked from [Junker](https://github.com/Junker) [nuke.xplr](https://github.com/Junker/nuke.xplr)
  
## Install with [xpm](https://github.com/dtomvan/xpm.xplr)

```lua
require("xpm").setup({
  plugins = {
    'dtomvan/xpm.xplr',
    'pbosab/nuke.xplr'
  }
})
```

## Place this in .config/xplr/init.lua
  
```lua
require("nuke").setup({
        open = {
                custom = {
                        { mime_regex = "^image/.*", command = "imv {}" },
                        { mime_regex = "^text/.*", command = "foot nvim {}" },
                        { mime_regex = "^video/.*", command = "mpv {}" },
                        { mime = "application/pdf", command = "zathura {}" },
                },
        },
})

local key = xplr.config.modes.builtin.default.key_bindings.on_key
key["enter"] = xplr.config.modes.custom.nuke.key_bindings.on_key.o
```
