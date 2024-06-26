-- {{@@ header() @@}}

return function()
  local map = require('utils').map

  require('trouble').setup {
    mode = 'document_diagnostics',
    use_diagnostic_signs = true,
  }

  map('n', '<leader>l', ':Trouble diagnostics toggle filter.buf=0<CR>')
  map('n', '<leader>L', ':Trouble diagnostics toggle<CR>')
  map('n', '<leader>s', ':Trouble symbols toggle pinned=true results.win.relative=win results.win.position=right<CR>')
end
