-- {{@@ header() @@}}

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    bufdelete = { enabled = true },
    indent = { enabled = true },
    scope = { enabled = true },
    toggle = { enabled = true },
  },
}
