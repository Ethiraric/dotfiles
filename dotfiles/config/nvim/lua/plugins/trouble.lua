-- {{@@ header() @@}}

return {
  { "nvim-tree/nvim-web-devicons" },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      warn_no_results = false,
      open_no_results = true,
      modes = {
        file_diagnostics = {
          mode = "diagnostics",
          filter = { buf = 0 },
          preview = {
            type = "split",
            relative = "win",
            position = "right",
            size = 0.3,
          },
          groups = {
            { "filename", format = "{file_icon} {basename:Title} {count}" },
          },
        },
        {%@@ if profile == "protea" @@%}
        oracle_diagnostics = {
          mode = "diagnostics",
          filter = function(items)
            return vim.tbl_filter(function(item)
              return item.dirname:find('/home/ethiraric/SWAAP/oracle.rs/src/rust/oracle', 1, true)
            end, items)
          end,
          preview = {
            type = "split",
            relative = "win",
            position = "right",
            size = 0.3,
          },
          groups = {
            { "filename", format = "{file_icon} {basename:Title} {count}" },
          },
        },
        oracle_todo = {
          mode = "todo",
          filter = function(items)
            return vim.tbl_filter(function(item)
              return item.dirname:find('/home/ethiraric/SWAAP/oracle.rs/src/rust/oracle', 1, true)
            end, items)
          end,
          groups = {
            "directory",
          },
        },
        {%@@ endif @@%}
      },
    },
    keys = {
      {
        "<leader>l",
        ":Trouble file_diagnostics toggle<CR>",
        desc = "File Diagnostics"
      },
      {
        "<leader>L",
        ":Trouble diagnostics toggle<CR>",
        desc = "Diagnostics"
      },
      {
        "<leader>s",
        ":Trouble symbols toggle focus=false pinned=true results.win.relative=win results.win.position=right<CR>",
        desc = "Symbols"
      },
      {
        "<leader>S",
        ":Trouble lsp toggle focus=false pinned=true results.win.relative=win results.win.position=right<CR>",
        desc = "LSP Definitions, References, ..."
      },
      {%@@ if profile == "protea" @@%}
      {
        "<leader>O",
        ":Trouble oracle_diagnostics toggle<CR>",
        desc = "`oracle` diagnostics"
      },
      {
        "<leader>T",
        ":Trouble oracle_todo toggle<CR>",
        desc = "`oracle` TODOs"
      },
      {%@@ endif @@%}
    },
  }
}
