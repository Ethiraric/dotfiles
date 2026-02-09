-- {{@@ header() @@}}

return {
  {
    "vim-scripts/vim-stay",
    init = function()
      -- When using vim-stay, save only cursor position.
      vim.opt.viewoptions = "cursor"
    end,
  },
}
