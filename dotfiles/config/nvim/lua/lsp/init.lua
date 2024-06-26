-- {{@@ header() @@}}

local format_on_save_enabled = true

return {
  config = function()
    local lsp = require('lspconfig')

    local utils = require('utils')

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    local make_on_attach = function(ls_on_attach)
      return function(client, bufnr)
        local function buf_set_keymap(...) utils.buf_map(bufnr, ...) end

        buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.declaration()<CR>')
        buf_set_keymap('n', '<leader>d', '<cmd>lua vim.lsp.buf.implementation()<CR>')
        buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
        buf_set_keymap('n', '<leader>ys', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
        buf_set_keymap('n', '<leader>t', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
        buf_set_keymap('n', '<leader>r', '<cmd>lua vim.lsp.buf.references()<CR>')
        buf_set_keymap('n', '<leader>yd', '<cmd>lua vim.lsp.buf.document_symbol()<CR>')
        buf_set_keymap('n', '<leader>yw', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>')
        buf_set_keymap('n', '<C-k>k', '<cmd>lua require("actions-preview").code_actions()<CR>')
        -- buf_set_keymap('n', '<C-k>k',    '<cmd>lua vim.lsp.buf.code_action()<CR>')
        -- buf_set_keymap('n', '<leader>L', '<cmd>lua vim.diagnostic.open_float()<CR>')
        -- vim.api.nvim_buf_del_keymap(bufnr, 'n', '<leader>l') -- why the fuck not
        buf_set_keymap('n', '<leader>R', '<cmd>lua vim.lsp.buf.rename()<CR>')

        if client.server_capabilities.documentFormattingProvider then
          buf_set_keymap('n', '<leader>F', '<cmd>lua vim.lsp.buf.format({ async = true })<CR>')
          buf_set_keymap('n', '<leader><leader>F', '<cmd>lua require(\'lsp\').toggle_format_on_save()<CR>')
          require('lsp').set_format_on_save(true)
        end

        if client.server_capabilities.documentRangeFormattingProvider then
          buf_set_keymap('v', '<leader>F', '<cmd>lua vim.lsp.buf.format({ async = true })<CR>')
        end

        require('illuminate').on_attach(client)
      end
    end

    local servers = {
      require('lsp.html'),
      require('lsp.lua_ls'),
      require('lsp.rust-analyzer'),
      require('lsp.texlab'),
      { name = 'pyright' },
      { name = 'clangd' },
      { name = 'cmake' },
      { name = 'bashls' },
      { name = 'hls' },
    }

    vim.lsp.protocol.CompletionItemKind = {
      "   (Text) ",
      "   (Method)",
      "   (Function)",
      "   (Constructor)",
      " ﴲ  (Field)",
      "   (Variable)",
      "   (Class)",
      " ﰮ  (Interface)",
      "   (Module)",
      " 襁 (Property)",
      "   (Unit)",
      "   (Value)",
      " 練 (Enum)",
      "   (Keyword)",
      "   (Snippet)",
      "   (Color)",
      "   (File)",
      "   (Reference)",
      "   (Folder)",
      "   (EnumMember)",
      " ﲀ  (Constant)",
      " ﳤ  (Struct)",
      "   (Event)",
      "   (Operator)",
      "   (TypeParameter)"
    }

    capabilities.textDocument.completion.completionItem.snippetSupport = true

    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
      vim.lsp.diagnostic.on_publish_diagnostics, {
        underline = true,
        update_in_insert = false,
        virtual_text = {
          prefix = ' '
        },
      }
    )

    vim.lsp.handlers['textDocument/codeAction'] = require 'lsputil.codeAction'.code_action_handler

    vim.fn.sign_define('DiagnosticSignError', { text = ' ', texthl = 'DiagnosticSignError' })
    vim.fn.sign_define('DiagnosticSignWarn', { text = ' ', texthl = 'DiagnosticSignWarn' })
    vim.fn.sign_define('DiagnosticSignInfo', { text = ' ', texthl = 'DiagnosticSignInfo' })
    vim.fn.sign_define('DiagnosticSignHint', { text = ' ', texthl = 'DiagnosticSignHint' })


    for _, server in ipairs(servers) do
      server.on_attach = make_on_attach(server.on_attach)
      server.capabilities = capabilities
      lsp[server.name].setup(server)
    end
  end,
  set_format_on_save = function(enabled)
    format_on_save_enabled = enabled
    local command = ''

    if enabled then command = 'autocmd BufWritePre * lua vim.lsp.buf.format({ async = false })\n' end
    vim.cmd([[
    augroup FormatOnSave
    autocmd!
    ]]
      .. command .. 'augroup END'
    )
  end,
  toggle_format_on_save = function()
    require('lsp').set_format_on_save(not format_on_save_enabled)
  end
}
