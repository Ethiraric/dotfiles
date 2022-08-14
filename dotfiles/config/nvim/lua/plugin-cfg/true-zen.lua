-- {{@@ header() @@}}

return function ()
  local map = require('utils').map

  map('n', '<leader>A', ':TZNarrow<CR>')
  map('v', '<leader>A', ':\'<,\'>TZNarrow<CR>')
  map('n', '<leader>a', ':TZFocus<CR>')
end
