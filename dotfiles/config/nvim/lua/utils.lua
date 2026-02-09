-- {{@@ header() @@}}

--- Default options that are applied to every key mapping. These can be
--- overridden in the mapping functions below if necessary.
local default_map_opts = {
  noremap = true,
  silent = true
}

--- @alias Mode 'n' | 'i' | 'v' | 'x' | 's' | 'o' | 'c' | 't'
--- @alias Modes Mode | Mode[]

--- Create a function which adds mappings with the given default options.
---
--- @param opts? vim.api.keyset.keymap Default options the returned mapping
---   function will set for bindings. This has more precedence than the global
---   default options, but less than the options set as parameter of the
---   returned function.
--- @return fun(mode:Mode, key_seq:string, action:function|string, opts?: vim.api.keyset.keymap)
local function make_keymap_setter(opts)
  return function(mode, key_seq, action, o)
    local options = vim.tbl_extend("force", default_map_opts, opts or {}, o or {})
    vim.keymap.set(mode, key_seq, action, options)
  end
end

--- Create the given key mapping. This wrapper around |vim.keymap.set|
--- automatically adds the `noremap` and `silent` options. Extra options can be
--- specified in `opts`. Values in `opts` take precedence over defaults.
---
--- @param mode Mode The mode in which to create the mapping.
--- @param key_seq string The key-sequence to map.
--- @param action string The action to take when the mapping is invoked.
--- @param opts? vim.api.keyset.keymap Options of the mapping.
local function map(mode, key_seq, action, opts)
  make_keymap_setter()(mode, key_seq, action, opts)
end

--- Create the given key mapping for the given buffer only. This wrapper around
--- |vim.keymap.set| automatically adds the `noremap` and `silent` options.
--- Extra options can be specified in `opts`. Values in `opts` take precedence
--- over defaults.
---
--- @param buffer integer The buffer ID for which to create the mapping. `0`
---   means the current buffer.
--- @param mode Mode The mode in which to create the mapping.
--- @param key_seq string The key-sequence to map.
--- @param action function|string The action to execute when the mapping is
---   invoked.
--- @param opts? vim.api.keyset.keymap Options of the mapping.
local function buf_map(buffer, mode, key_seq, action, opts)
  make_keymap_setter({ buffer = buffer })(mode, key_seq, action, opts)
end

--- Create a function which adds mappings to a buffer with the given default
--- options.
---
--- @param opts? vim.api.keyset.keymap Default options the returned mapping
---   function will set for bindings. This has more precedence than the global
---   default options, but less than the options set as parameter of the
---   returned function.
--- @return fun(mode:Mode, key_seq:string, action:function|string, opts?: vim.api.keyset.keymap)
local function make_buf_keymap_setter(buffer, opts)
  local fn_options = vim.tbl_extend("force", { buffer = buffer }, opts or {})
  return make_keymap_setter(fn_options)
end

return {
  map = map,
  buf_map = buf_map,
  make_keymap_setter = make_keymap_setter,
  make_buf_keymap_setter = make_buf_keymap_setter
}
