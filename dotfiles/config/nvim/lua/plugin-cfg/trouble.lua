-- {{@@ header() @@}}

return function ()
  local map = require('utils').map

  require('trouble').setup {
    mode = 'document_diagnostics',
    use_diagnostic_signs = true,
  }

  map('n', '<leader>l', ':TroubleToggle<CR>')
end
