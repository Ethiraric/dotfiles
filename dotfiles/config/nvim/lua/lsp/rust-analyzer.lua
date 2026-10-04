-- {{@@ header() @@}}

local root_pattern = require('lspconfig.util').root_pattern

function create_cargo_feature_commands()
  vim.api.nvim_create_user_command(
    'Ft',
    function(opts)
      print('=== Ft '..table.concat(opts.fargs, " ").." ===")
      local rustAnalyzerSettings = vim.lsp.get_clients({ name = 'rust_analyzer' })[1].config.settings
      if rustAnalyzerSettings == nil then
        print('Ft: No configuration for `rust_analyzer`. Is the LSP running?')
        return
      end
      local default_features = not rustAnalyzerSettings['rust-analyzer'].cargo.noDefaultFeatures
      local features = rustAnalyzerSettings['rust-analyzer'].cargo.features
      local args = opts.fargs
      if type(args) ~= 'table' or #args == 0 then
        print('Ft <list|set|default>')
        return
      elseif args[1] == 'list' or args[1] == 'l' then
        if default_features then
          print('Default features enabled')
        else
          print('Default features disabled')
        end
        if features == nil then
          print('No additional features')
        elseif features == 'all' then
          print('All features enabled')
        elseif type(features) == 'table' then
          print('Additional features: ['..table.concat(rustAnalyzerSettings['rust-analyzer'].cargo.features, ', ')..']')
        else
          print('Additional features: '..type(features)..': "'..tostring(features)..'"')
        end
        return
      elseif args[1] == 'set' then
        table.remove(args, 1)
        features = args
        print('Setting features to '..table.concat(features,', '))
      elseif args[1] == 'default' or args[1] == 'd' then
        if args[2] == 'toggle' then
          default_features = not default_features
        elseif args[2] == 'on' or args[2] == 'true' then
          default_features = true
        elseif args[2] == 'off' or args[2] == 'false' then
          default_features = false
        else
          print('Ft default <toggle|on|off|true|false>')
          return
        end
        if default_features then
          print('Enabling default features')
        else
          print('Disabling default features')
        end
      else
        print('Ft '..args[1]..': Unknown command')
        return
      end
      rustAnalyzerSettings['rust-analyzer'].cargo.noDefaultFeatures = not default_features
      rustAnalyzerSettings['rust-analyzer'].cargo.features = features
      vim.lsp.enable('rust_analyzer', false)
      vim.lsp.config('rust_analyzer', { settings = rustAnalyzerSettings })
      vim.lsp.enable('rust_analyzer')
    end,
    { desc = 'Manipulate cargo features', nargs = '*' }
  )
end

return {
  name = 'rust_analyzer',
  cmd = { '/usr/lib/rustup/bin/rust-analyzer' },
  filetypes = { 'rust' },
  {%@@ if profile != "protea" @@%}
  root_dir = root_pattern('Cargo.toml'),
  {%@@ endif @@%}
  settings = {
    ['rust-analyzer'] = {
      diagnostics = {
        disabled = {
          'inactive-code'
        },
        styleLints = {
          enable = true,
        }
      },
      check = {
        command = 'clippy',
        {%@@ if profile != "protea" @@%}
        extraArgs = { '--', '-Wclippy::pedantic', '-Aclippy::redundant_else' },
        {%@@ else @@%}
        extraArgs = { '--', '-Wclippy::pedantic', '-Aclippy::redundant_else', '-Aclippy::too_many_lines' },
        workspace = false,
        {%@@ endif @@%}
      },
      checkOnSave = true,
      rustc = {
        source = 'discover'
      },
      assist = {
        importPrefix = 'crate'
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
