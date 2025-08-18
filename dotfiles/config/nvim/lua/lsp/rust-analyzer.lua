-- {{@@ header() @@}}

local root_pattern = require("utils").root_pattern

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
  end
}
