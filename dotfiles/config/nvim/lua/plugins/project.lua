-- {{@@ header() @@}}

return {
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup({
        silent_chdir = false,
        detection_methods = { "pattern", "lsp" },
        patterns = { ".project.nvim", ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },
      })
    end,
  },
}
