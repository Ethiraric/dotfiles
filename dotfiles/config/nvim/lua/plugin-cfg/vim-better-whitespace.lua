-- {{@@ header() @@}}

return function ()
  local map = require('utils').map

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

  map('n', '<leader><Space>', ':StripWhitespace<CR>')
  map('v', '<leader><Space>', ':StripWhitespace<CR>')
end
