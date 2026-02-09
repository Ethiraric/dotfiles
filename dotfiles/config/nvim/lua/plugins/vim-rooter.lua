-- {{@@ header() @@}}

return {
  {
    "airblade/vim-rooter",
    enabled = false,
    init = function()
      vim.g.rooter_patterns = { '.git' }
    end,
  },
}
