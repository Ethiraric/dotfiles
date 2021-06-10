-- {{@@ header() @@}}

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
    file_ignore_patterns = {
     'deps/.*'
    },
    extensions = {
      fzf_writer = {
          minimum_grep_characters = 0,
          minimum_files_characters = 0,
          use_highlighter = true,
      },
      ethi = {
      }
    },
  }

  telescope.load_extension('fzf_writer')
  telescope.load_extension('ethi')

  map('n', '<C-p>', ':lua require(\'telescope\').extensions.fzf_writer.files()<CR>')
  -- map('n', '<C-j>', ':lua require(\'telescope\').extensions.fzf_writer.grep()<CR>')
  map('n', '<C-k>s', ':Telescope lsp_document_symbols<CR>')
  map('n', 'gs', ':lua require(\'telescope\').extensions.ethi.git_show()<CR>')
end
