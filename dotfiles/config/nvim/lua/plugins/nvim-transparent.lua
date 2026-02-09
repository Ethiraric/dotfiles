-- {{@@ header() @@}}

return {{
  "xiyaowong/nvim-transparent",
  opts = {
    extra_groups = {
      "TelescopeNormal",
      "TelescopeBorder",
      "TelescopePreviewNormal",
      "TelescopeResultsNormal",
    },
    exclude_groups = {},
  },
  build = ":TransparentEnable"
}}
