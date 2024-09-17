-- {{@@ header() @@}}

return function()
  require("tokyonight").setup({
    style = "night",
    transparent = true,
    styles = {
      comment = {
        italic = false,
      },
      keywords = {
        italic = false,
      },
    }
  })
end
