-- {{@@ header() @@}}

local map = require("utils").map

vim.g.mapleader = ','

-- Remap ; to : (avoid SHIFTing)
map('n', ';', ':')
map('v', ';', ':')

-- Copy to clipboard
map('v', '<leader>y', '"+y')
map('n', '<leader>y', '"+y')
map('n', '<leader>Y', '"+yg_')

-- Buffer switching
map('n', '<leader>n', ':bnext<CR>')
map('n', '<leader>p', ':bprevious<CR>')

-- Remove search highlight with //
map('n', '//', ':nohlsearch<CR>')

-- Switch to alternate file.
map('n', '<Leader><Leader>', '<C-^>')

-- Splits
map('n', 'ss', ':split<CR><C-W>j')
map('n', 'vv', ':vsplit<CR><C-W>l')

-- Search
map('n', '/', '/\\v')
map('v', '/', '/\\v')
map('n', '?', '?\\v')
map('v', '?', '?\\v')

-- Tabs
map('n', 'T', ':tabnew<cr>')
map('n', 'H', ':tabprev<cr>')
map('n', 'L', ':tabnext<cr>')

-- Exit insert mode
map('i', 'jk', '<ESC>')

-- Folds
map('n', '<Space>', 'za')

-- TComment
map('', '<Leader>c', '<C-_><C-_>')

map('n', '<Up><Up><Down><Down><Left><Right><Left><Right>ba<space>', ':wq<ENTER>')
