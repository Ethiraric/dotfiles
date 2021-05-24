-- {{@@ header() @@}}

local root_pattern = require("utils").root_pattern

return {
  name = 'rust_analyzer',
  filetypes = { "rust" },
  root_dir = root_pattern("Cargo.toml"),
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        autoreload = true
      },
      diagnostics = {
        enable = true,
        disabled = {},
        enableExperimental = true,
      },
    }
  }
}
