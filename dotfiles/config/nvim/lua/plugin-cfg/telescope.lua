-- {{@@ header() @@}}

return function()
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
      },
      file_ignore_patterns = {
        'deps/.*'
      },
    },
    extensions = {
      ethi = {
      }
    },
  }

  telescope.load_extension('fzf')
  telescope.load_extension('ethi')

  map('n', '<C-p>', ':lua require(\'telescope.builtin\').find_files()<CR>')
  -- map('n', '<C-j>', ':lua require(\'telescope\').extensions.fzf_writer.grep()<CR>')
  map('n', '<C-k>s', ':Telescope lsp_document_symbols<CR>')
  map('n', '<C-k>r', ':Telescope lsp_references<CR>')
  map('n', '<C-k>S', ':Telescope lsp_workspace_symbols<CR>')
  map('n', 'gs', ':lua require(\'telescope\').extensions.ethi.git_show()<CR>')
end
