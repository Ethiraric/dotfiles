-- {{@@ header() @@}}

local function config()
  local treesitter = require("nvim-treesitter")
  treesitter.setup {}
  treesitter.install({
    "bash",
    "c",
    "cpp",
    "csv",
    "diff",
    "dockerfile",
    "gitcommit",
    "git_config",
    "git_rebase",
    "gitignore",
    "go",
    "html",
    "json",
    "latex",
    "lua",
    "make",
    "markdown",
    "markdown_inline",
    "mermaid",
    "python",
    "regex",
    "ron",
    "rust",
    "sql",
    "toml",
    "xml",
  })
  vim.o.foldmethod = "expr"
  vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"

  -- main-branch nvim-treesitter no longer enables highlighting via setup();
  -- start it per-buffer for any filetype that has a parser installed.
  vim.api.nvim_create_autocmd("FileType", {
    callback = function(args)
      pcall(vim.treesitter.start, args.buf)
    end,
  })
end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    -- cmd = { "TSInstall", "TSInstallInfo", "TSUninstall", "TSUpdate" },
    config = config,
  },
}
