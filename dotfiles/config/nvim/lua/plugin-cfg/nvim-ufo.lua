-- {{@@ header() @@}}

function handler(virt_text, fold_start_line, fold_end_line, width, truncate)
  local new_virt_text = {}
  local suffix = ('  %d '):format(fold_end_line - fold_start_line)
  local suf_width = vim.fn.strdisplaywidth(suffix)
  local target_width = width - suf_width
  local cur_width = 0

  local fold_hl_group = nil

  for _, chunk in ipairs(virt_text) do
    local chunk_text = chunk[1]
    local chunk_width = vim.fn.strdisplaywidth(chunk_text)

    fold_hl_group = chunk[2] -- Not 100% guarantee to have the good hl group if
    -- there is something after the fold character but most likely to.

    if target_width > cur_width + chunk_width then
      table.insert(new_virt_text, chunk)
    else
      chunk_text = truncate(chunk_text, target_width - cur_width)
      local hl_group = chunk[2]

      table.insert(new_virt_text, { chunk_text, hl_group })
      chunk_width = vim.fn.strdisplaywidth(chunk_text)
      -- str width returned from truncate() may less than 2nd argument, need padding
      if cur_width + chunk_width < target_width then
        suffix = suffix .. (' '):rep(target_width - cur_width - chunk_width)
      end
      break
    end
    cur_width = cur_width + chunk_width
  end
  table.insert(new_virt_text, { suffix, 'MoreMsg' })
  table.insert(new_virt_text, { vim.fn.trim(vim.fn.getline(fold_end_line)), fold_hl_group })

  return new_virt_text
end

return function()
  require('ufo').setup({
    open_fold_hl_timeout = 100,
    provider_selector = function(bufnr, filetype, buftype)
      return { 'treesitter' }
    end,
    fold_virt_text_handler = handler,
  })

  local bufnr = vim.api.nvim_get_current_buf()
  require('ufo').setFoldVirtTextHandler(bufnr, handler)
end
