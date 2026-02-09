-- {{@@ header() @@}}

return {
  { "nvim-lua/plenary.nvim" },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      keywords = {
        FIX =  { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, },
        TODO = { icon = " ", color = "info" },
        HACK = { icon = " ", color = "warning", alt = { "XXX" } },
        WARN = { icon = " ", color = "warning", alt = { "WARNING" } },
        PERF = { icon = " ", color = "perf", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
        TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
        INVR = { icon = " ", color = "invariant", alt = { "INVARIANT", "PRECOND", "PRECONDITION" } }
      },
      highlight = {
        -- pattern = [[.*<(KEYWORDS)\s*:]],
        -- pattern = [[.*<(KEYWORDS)(\([a-zA-Z_0-9]+(, (\d|\/)+)?\))?\s*:]]
        pattern =
        [[.*<((KEYWORDS)]] ..
            -- Optional "(name, date)"
            [[(\(]] ..
            [[[a-zA-Z_0-9]+]] .. -- name
            [[(, [0-9/]+)?]] .. -- date
            [[\))?]] ..
          [[:)]]
      },
      colors = {
        error =     { "DiagnosticError", "ErrorMsg",   "#DC2626" },
        warning =   { "DiagnosticWarn",  "WarningMsg", "#FBBF24" },
        info =      { "DiagnosticInfo",  "#2563EB" },
        hint =      { "DiagnosticHint",  "#10B981" },
        default =   { "Identifier",      "#7C3AED" },
        test =      { "Identifier",      "#FF00FF" },
        perf =      { "#BB9AF7" },
        invariant = { "#7C3AED" }
      },
      search = {
        pattern = [[(///?|--|#) (KEYWORDS)(\(\w+(, [0-9/]+)?\))?:]], -- ripgrep regex
      },
    }
  }
}
