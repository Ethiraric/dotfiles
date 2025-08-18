-- {{@@ header() @@}}

return function()
  require("tokyonight").setup({
    style = "night",
    transparent = true,
    styles = {
      comments = {
        italic = false,
      },
      keywords = {
        italic = false,
      },
    }
  })
  vim.cmd("colorscheme tokyonight-night")
end
