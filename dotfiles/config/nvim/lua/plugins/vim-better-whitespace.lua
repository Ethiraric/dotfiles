-- {{@@ header() @@}}

return {
  {
    "ntpeters/vim-better-whitespace",
    init = function()
      vim.g.better_whitespace_filetypes_blacklist = {
        'diff',
        'fugitive',
        'git',
        'gitcommit',
        'help',
        'markdown',
        'qf',
        'startify',
        'unite',
      }
    end,
    keys = {
      { "<leader><Space>", ":StripWhitespace<CR>", mode = "n", desc = "Strip whitespace" },
      { "<leader><Space>", ":StripWhitespace<CR>", mode = "v", desc = "Strip whitespace" },
    },
  },
}
