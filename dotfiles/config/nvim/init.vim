" {{@@ header() @@}}

source $HOME/.config/nvim/settings.vim
luafile $HOME/.config/nvim/lua/config.lua

lua  vim.g.tokyonight_style = "night"
lua  vim.g.tokyonight_transparent = true
colorscheme tokyonight
