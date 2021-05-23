return function ()
  require('compe').setup {
    enabled = true,
    autocomplete = true,
    debug = false,
    min_length = 1,
    preselect = 'enable',
    throttle_time = 80,
    source_timeout = 200,
    incomplete_delay = 400,
    max_abbr_width = 100,
    max_kind_width = 100,
    max_menu_width = 100,
    documentation = true,

    source = {
      path = true,
      buffer = true,
      calc = false,
      nvim_lsp = true,
      nvim_lua = false,
      ultisnips = true
    },
  }

  local map = require('utils').map
  local options = { expr = true }

  map('i', '<C-Space>', 'compe#complete()',      options)
  map('i', '<C-e>',     'compe#close("<C-e>")',  options)
  map('i', '<CR>',      'compe#confirm("<CR>")', options)
  map('i', '<Tab>',     'pumvisible() ? "<C-n>" : "<Tab>"',   options)
  map('i', '<S-Tab>',   'pumvisible() ? "<C-p>" : "<S-Tab>"', options)
end
