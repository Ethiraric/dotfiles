-- {{@@ header() @@}}

return function ()
  local map = require('utils').map

  require('trouble').setup {
    use_lsp_diagnostic_signs = true,
  }

  map('n', '<leader>l', ':LspTroubleToggle<CR>')
end
