-- {{@@ header() @@}}

local utils = require("utils")

local format_on_save_enabled = true
--- Enable or disable formatting of buffers upon saving.
---
--- @param enabled boolean Whether to enable formatting on save.
local function set_format_on_save(enabled)
  format_on_save_enabled = enabled
  local command = enabled and ""
      or "autocmd BufWritePre * lua vim.lsp.buf.format({ async = false })\n"
  vim.cmd("augroup FormatOnSave\nautocmd!\n" .. command .. "augroup END")
end

local function toggle_format_on_save()
  set_format_on_save(not format_on_save_enabled)
end

local function format_selection()
  -- Go back to normal mode, updates '< and '>
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<esc>', true, false, true), 'x', true)

  local range = {
    start = vim.api.nvim_buf_get_mark(0, '<'),
    ['end'] = vim.api.nvim_buf_get_mark(0, '>'),
  }

  vim.lsp.buf.format({ async = true, range = range })
end

--- Create a valid |Client:on_attach()| function wrapping `ls_on_attach` and
--- adding language-server-agnostic configuration.
---
--- @param ls_on_attach fun(client:vim.lsp.Client, bufnr:integer)|nil
---   The `on_attach` function of the given language server. If specified, this
---   will be called prior to any other code in `make_on_attach`. It allows the
---   setting of language-server-specific bindings in their configuration files.
--- @return fun(client:vim.lsp.Client, bufnr:integer)
local function make_on_attach(ls_on_attach)
  return function(client, bufnr)
    -- Call LS-specific configuration.
    if ls_on_attach ~= nil then
      ls_on_attach(client, bufnr)
    end

    local buf_map = utils.make_buf_keymap_setter(bufnr)

    -- Set generic LSP bindings. This is a table since otherwise the formatter
    -- folds whitespace.
    local bindings = {
      { "n", "K",          vim.lsp.buf.hover },
      { "n", "<leader>ys", vim.lsp.buf.signature_help },
      { "n", "<leader>t",  vim.lsp.buf.type_definition },
      { "n", "<leader>f",  vim.lsp.buf.declaration },
      { "n", "<leader>d",  vim.lsp.buf.implementation },
      { "n", "<leader>r",  vim.lsp.buf.references },
      { "n", "<leader>yd", vim.lsp.buf.document_symbol },
      { "n", "<leader>yw", vim.lsp.buf.workspace_symbol },
      { "n", "<leader>R",  vim.lsp.buf.rename },
      { "n", "<C-k>k",     require("actions-preview").code_actions },
    }
    for _, binding in ipairs(bindings) do
      buf_map(binding[1], binding[2], binding[3])
    end

    if client.server_capabilities.documentFormattingProvider then
      buf_map("n", "<leader>F", function() vim.lsp.buf.format({ async = true }) end)
      buf_map("n", "<leader><leader>F", toggle_format_on_save)
      set_format_on_save(true)
    end

    if client.server_capabilities.documentRangeFormattingProvider then
      buf_map("v", "<leader>F", function() vim.lsp.buf.format({ async = true }) end)
    end

    require("illuminate").on_attach(client)
  end
end

local function set_completion_item_kinds()
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
end

--- Set up configuration for the different registered language servers.
local function config()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
  -- Add support for snippets.
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  if false then
    -- Temporarily disabling this, I don't think it does anything.
    vim.lsp.handlers["textDocument/codeAction"] = require "lsputil.codeAction".code_action_handler
    set_completion_item_kinds()
  end


  -- Set pretty diagnostics
  vim.diagnostic.config({
    underline = true,
    update_in_insert = false,
    virtual_text = {
      prefix = " "
    },
  })
  vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
  vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
  vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
  vim.fn.sign_define("DiagnosticSignHint", { text = " ", texthl = "DiagnosticSignHint" })

  -- List configurations for known language-servers.
  local language_servers = {
    -- require("lsp.html"),
    require("lsp.lua_ls"),
    require("lsp.rust-analyzer"),
    { name = "gopls" },
    -- require("lsp.texlab"),
    -- { name = "pyright" },
    -- { name = "clangd" },
    -- { name = "cmake" },
    -- { name = "bashls" },
    -- { name = "hls" },
    -- { name = "marksman" },
  }

  -- Using `ipairs` is idiomatic, even if we don"t use the index.
  for _, ls in ipairs(language_servers) do
    -- Register language server into nvim's LSP configuration.
    ls.on_attach = make_on_attach(ls.on_attach)
    ls.capabilities = capabilities
    if ls.from_my_config ~= nil then
      ls.from_my_config()
    end
    vim.lsp.config(ls.name, ls)
    -- Bake in lspconfig's shipped defaults (cmd, root_markers, ...) while it is
    -- still on 'rtp'; reading `vim.lsp.config[name]` resolves but does not cache.
    vim.lsp.config(ls.name, vim.lsp.config[ls.name])
    vim.lsp.enable(ls.name)
  end

  -- Allowlist: the configs above are now resolved and cached, so drop
  -- nvim-lspconfig from 'runtimepath'. Its ~350 other `lsp/*.lua` configs become
  -- undiscoverable, and commands like `:LspStart` can no longer enable servers we
  -- never asked for (e.g. gitlab_duo, which attaches to rust buffers).
  vim.opt.runtimepath:remove(vim.fn.fnamemodify(vim.api.nvim_get_runtime_file("lsp/gopls.lua", false)[1], ":h:h"))
end

return {
  -- Dependencies first
  { "RishabhRD/popfix" },
  { "RishabhRD/nvim-lsputils", dependencies = { "RishabhRD/popfix" } },
  -- `nvim-lspconfig`
  {
    "neovim/nvim-lspconfig",
    dependencies = { 'RishabhRD/nvim-lsputils' },
    config = config,
  },
}
