return function ()
  local map = require("utils").map
  local telescope = require('telescope')

  telescope.setup {
    defaults = {
      vimgrep_arguments = {
        'rg',
        '--color=never',
        '--no-heading',
        '--with-filename',
        '--line-number',
        '--column',
        '--smart-case'
      }
    },
    extensions = {
      fzf = {
        override_generic_sorter = false,
        override_file_sorter = true,
      },
    },
  }

  telescope.load_extension('fzf')

  map('n', '<c-p>', ':Telescope find_files<CR>')
  -- Commented the folder-wide search, using :Ag from fzf
  -- map('n', '<c-j>', ':Telescope live_grep<CR>')
  map('n', '<c-s>', ':Telescope lsp_references<CR>')
end
