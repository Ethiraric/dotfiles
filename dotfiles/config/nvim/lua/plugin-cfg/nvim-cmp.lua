return function ()
  local cmp = require('cmp')

  local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

  local feedkey = function(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
  end

  local next_entry = function(behavior)
    return function(fallback)
      if cmp.visible() then
        cmp.select_next_item(behavior)
      elseif vim.fn["vsnip#available"](1) == 1 then
        feedkey("<Plug>(vsnip-expand-or-jump)", "")
      elseif has_words_before() then
        cmp.complete()
      else
        fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
      end
    end
  end

  local prev_entry = function(behavior)
    return function(fallback)
      if cmp.visible() then
        cmp.select_prev_item(behavior)
      elseif vim.fn["vsnip#jumpable"](-1) == 1 then
        feedkey("<Plug>(vsnip-jump-prev)", "")
      end
    end
  end

  local confirm = function()
    cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true })
  end

  cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn['vsnip#anonymous'](args.body)
      end,
    },

    mapping = {
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ["<CR>"] = cmp.mapping({
        i = function(fallback)
          if cmp.visible() and (#cmp.get_entries() == 1 or cmp.get_selected_entry()) then
            confirm()
          else
            fallback()
          end
        end,
        s = confirm(),
        c = confirm(),
      }),
      ["<Tab>"] = cmp.mapping(next_entry({ behavior = cmp.SelectBehavior.Insert }), { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(prev_entry({ behavior = cmp.SelectBehavior.Insert }), { "i", "s" }),
      ['<C-n>'] = cmp.mapping(next_entry({ behavior = cmp.SelectBehavior.Insert }), { 'i', 'c' }),
      ['<C-p>'] = cmp.mapping(prev_entry({ behavior = cmp.SelectBehavior.Insert }), { 'i', 'c' }),
    },

    sources = {
      { name = 'nvim_lsp' },
      { name = 'vsnip' },
      { name = 'path' },
      { name = 'buffer' },
    },
  })

  vim.opt.completeopt = { 'menuone', 'noselect' }
  -- Remove cmp status display
  vim.opt.shortmess:append('c')
  return 3
end
