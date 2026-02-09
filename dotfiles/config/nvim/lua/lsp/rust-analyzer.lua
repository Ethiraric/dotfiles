-- {{@@ header() @@}}

local root_pattern = require("lspconfig.util").root_pattern

function create_cargo_feature_commands()
  vim.api.nvim_create_user_command(
    'FtSet',
    function(opts)
      local rustAnalyzerSettings = vim.lsp.get_clients({ name = "rust_analyzer" })[1].config.settings
      if rustAnalyzerSettings ~= nil then
        rustAnalyzerSettings["rust-analyzer"].cargo.features = opts.fargs
        vim.lsp.enable('rust_analyzer', false)
        vim.lsp.config('rust_analyzer', { settings = rustAnalyzerSettings })
        vim.lsp.enable('rust_analyzer')
      end
    end,
    { desc = 'Set rust-analyzer features to the provided list', nargs = '*' }
  )
  vim.api.nvim_create_user_command(
    'FtSetAll',
    function(opts)
      local rustAnalyzerSettings = vim.lsp.get_clients({ name = "rust_analyzer" })[1].config.settings
      if rustAnalyzerSettings ~= nil then
        rustAnalyzerSettings["rust-analyzer"].cargo.features = "all"
        vim.lsp.enable('rust_analyzer', false)
        vim.lsp.config('rust_analyzer', { settings = rustAnalyzerSettings })
        vim.lsp.enable('rust_analyzer')
      end
    end,
    { desc = 'Set all rust-analyzer features', nargs = 0 }
  )
  vim.api.nvim_create_user_command(
    'FtToggleAll',
    function(opts)
      local rustAnalyzerSettings = vim.lsp.get_clients({ name = "rust_analyzer" })[1].config.settings
      if rustAnalyzerSettings ~= nil then
        if rustAnalyzerSettings["rust-analyzer"].cargo.features ~= nil then
          rustAnalyzerSettings["rust-analyzer"].cargo.features = nil
        else
          rustAnalyzerSettings["rust-analyzer"].cargo.features = "all"
        end
        vim.lsp.enable('rust_analyzer', false)
        vim.lsp.config('rust_analyzer', { settings = rustAnalyzerSettings })
        vim.lsp.enable('rust_analyzer')
      end
    end,
    { desc = 'Set all rust-analyzer features', nargs = 0 }
  )
  vim.api.nvim_create_user_command(
    'FtList',
    function(opts)
      local rustAnalyzerSettings = vim.lsp.get_clients({ name = "rust_analyzer" })[1].config.settings
      if rustAnalyzerSettings == 'all' then
        print("all features enabled")
      elseif rustAnalyzerSettings ~= nil then
        print('['..table.concat(rustAnalyzerSettings["rust-analyzer"].cargo.features, ', ')..']')
      end
    end,
    { desc = "List rust-analyzer active features.", nargs = 0 }
  )
end

return {
  name = 'rust_analyzer',
  cmd = { '/usr/lib/rustup/bin/rust-analyzer' },
  filetypes = { "rust" },
  {%@@ if profile != "protea" @@%}
  root_dir = root_pattern("Cargo.toml"),
  {%@@ endif @@%}
  settings = {
    ["rust-analyzer"] = {
      diagnostics = {
        styleLints = {
          enable = true,
        }
      },
      check = {
        command = "clippy",
        {%@@ if profile != "protea" @@%}
        extraArgs = { "--", "-Wclippy::pedantic", "-Aclippy::redundant_else" },
        {%@@ else @@%}
        extraArgs = { "--", "-Wclippy::pedantic", "-Aclippy::redundant_else", "-Aclippy::too_many_lines" },
        workspace = false,
        {%@@ endif @@%}
      },
      checkOnSave = true,
      rustc = {
        source = "discover"
      },
      assist = {
        importPrefix = "crate"
      },
      cargo = {
        autoreload = true
      },
      diagnostics = {
        enable = true,
        enableExperimental = true,
      },
    }
  },
  on_attach = function(client, bufnr)
    -- vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
  end,
  from_my_config = function()
    create_cargo_feature_commands()
  end
}
