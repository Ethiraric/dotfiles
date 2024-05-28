return function()
  require("actions-preview").setup {
    telescope = {
      initial_mode = "normal",
      layout_strategy = "vertical",
      layout_config = {
        width = 0.8,
        height = 0.9,
        preview_height = function(_, _, max_lines)
          return max_lines - 15
        end,
      },
    },
  }
end
