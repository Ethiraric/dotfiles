-- {{@@ header() @@}}

return {
  -- { "hrsh7th/vim-vsnip-integ" },
  {
    "hrsh7th/vim-vsnip",
    -- dependencies = { "hrsh7th/vim-vsnip-integ" }
    init = function()
      vim.g.vsnip_snippet_dir = vim.fn.expand('$HOME/.config/nvim/snippets')
    end,
    keys = {
      { "<C-l>", "vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<C-l>'", mode = { "i", "s" }, expr = true, remap = true },
      { "<C-h>", "vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-h>'", mode = { "i", "s" }, expr = true, remap = true },
    },
  },
}
