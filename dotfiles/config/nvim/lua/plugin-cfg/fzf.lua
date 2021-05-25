-- {{@@ header() @@}}

return function ()
  local map = require('utils').map

  map('n', '/', ':BLines<CR>')
  -- Much like :Ag, but ignoring the `deps` and `.git` folders
  -- map('n', '<c-j>', ':call fzf#vim#grep(\'ag --ignore deps --ignore .git --color -- "^(?=.)"\', 0, fzf#vim#with_preview())<CR>')
  map('n', '<c-b>', ':Buffer<CR>')
end
