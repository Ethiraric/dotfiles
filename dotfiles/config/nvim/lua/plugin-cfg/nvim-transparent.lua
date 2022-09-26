-- {{@@ header() @@}}

return function()
  require("transparent").setup({
    enable = true,
    extra_groups = {
      -- example of akinsho/nvim-bufferline.lua
      -- "BufferLineTabClose",
      -- "BufferlineBufferSelected",
      -- "BufferLineFill",
      -- "BufferLineBackground",
      -- "BufferLineSeparator",
      -- "BufferLineIndicatorSelected",
      'TelescopeNormal',
      'TelescopeBorder',
      'TelescopePreviewNormal',
      'TelescopeResultsNormal',
    },
    exclude = {},
  })
end
