-- {{@@ header() @@}}

return {
  {
    "Pocco81/true-zen.nvim",
    keys = {
      { "<leader>A", ":TZNarrow<CR>", mode = "n", desc = "True Zen Narrow" },
      { "<leader>A", ":'<,'>TZNarrow<CR>", mode = "v", desc = "True Zen Narrow selection" },
      { "<leader>a", ":TZFocus<CR>", mode = "n", desc = "True Zen Focus" },
    },
  },
}
