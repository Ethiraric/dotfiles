return function ()
  local cmp = require('cmp')

  cmp.setup {
    snippet = {
      expand = function(args)
        vim.fn['vsnip#anonymous'](args.body)
      end,
    },

    mapping = {
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
      ['<Tab>'] = cmp.mapping.select_next_item(),
      ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    },

    sources = {
      { name = 'nvim_lsp' },
      { name = 'vsnip' },
      { name = 'path' },
      { name = 'buffer' },
    },
  }

  vim.opt.completeopt = { 'menuone', 'noselect' }
  -- Remove cmp status display
  vim.opt.shortmess:append('c')
end
