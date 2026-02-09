-- {{@@ header() @@}}

-- Load mappings (including `vim.g.mapleader`)
require("mappings")
-- Load lazy
-- This loads all plugins in the `./plugins` directory
require("config.lazy")

vim.o.cmdheight = 0
vim.opt.mouse = ""
