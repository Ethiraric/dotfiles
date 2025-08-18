-- {{@@ header() @@}}

return function()
  local map = require('utils').map

  require('trouble').setup {
    warn_no_results = false,
    open_no_results = true,
    modes = {
      file_diagnostics = {
        mode = "diagnostics",
        filter = { buf = 0 },
        preview = {
          type = "split",
          relative = "win",
          position = "right",
          size = 0.3,
        },
        groups = {
          { "filename", format = "{file_icon} {basename:Title} {count}" },
        },
      },
    },
  }

  map('n', '<leader>l', ':Trouble file_diagnostics toggle<CR>')
  map('n', '<leader>L', ':Trouble diagnostics toggle<CR>')
  map('n', '<leader>s', ':Trouble symbols toggle pinned=true results.win.relative=win results.win.position=right<CR>')
end
