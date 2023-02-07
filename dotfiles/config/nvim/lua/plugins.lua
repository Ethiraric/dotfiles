-- {{@@ header() @@}}

local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({ 'git', 'clone', 'https://github.com/wbthomason/packer.nvim', '--depth', '1', install_path })
  execute 'packadd packer.nvim'
end

return require('packer').startup({
  function(use)
    ----------  Package manager
    use 'wbthomason/packer.nvim'

    ----------  Cosmetics
    use {
      'xiyaowong/nvim-transparent',
      config = require('plugin-cfg.nvim-transparent')
    }
    use { 'p00f/nvim-ts-rainbow', config = require('plugin-cfg.ts-rainbow') }
    use 'ryanoasis/vim-devicons'
    use {
      'nvim-lualine/lualine.nvim',
      requires = 'nvim-tree/nvim-web-devicons',
      config = require('plugin-cfg.lualine')
    }
    use 'RRethy/vim-illuminate' -- Highlight occurences of hovered word
    -- Themes
    use {
      'folke/tokyonight.nvim',
      config = require('plugin-cfg.tokyonight')
    }
    --{%@@ if profile == "Jotho" @@%}
    -- Mindustry asm
    use 'purofle/vim-mindustry-logic'
    -- {%@@ endif @@%}

    ---------- LSP
    use {
      'neovim/nvim-lspconfig',
      config = require('lsp').config,
      requires = {
        {
          'RishabhRD/nvim-lsputils',
          requires = 'RishabhRD/popfix',
        },
      },
    }
    use {
      'weilbith/nvim-code-action-menu',
      cmd = 'CodeActionMenu'
    }
    use {
      'j-hui/fidget.nvim', -- Display progress of LSP
      config = require('plugin-cfg.fidget')
    }

    -- Completion menu
    use {
      'hrsh7th/nvim-cmp',
      requires = {
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-vsnip',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-nvim-lsp',
      },
      config = require('plugin-cfg.nvim-cmp'),
    }
    -- Diagnostics menu
    use {
      'folke/trouble.nvim',
      requires = 'nvim-tree/nvim-web-devicons',
      config = require('plugin-cfg.trouble'),
    }
    -- Snippets
    use { 'hrsh7th/vim-vsnip', config = require('plugin-cfg.vsnip') }

    -- Folds & highlighting
    use {
      {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = require('plugin-cfg.treesitter'),
      },
      'nvim-treesitter/playground'
    }
    use {
      'kevinhwang91/nvim-ufo',
      requires = { 'kevinhwang91/promise-async' },
      config = require('plugin-cfg.nvim-ufo')
    }
    -- Todo
    use {
      'folke/todo-comments.nvim',
      requires = "nvim-lua/plenary.nvim",
      config = require('plugin-cfg.todo-comments')
    }

    ---------- Git things
    use 'tpope/vim-fugitive' -- Gblame and such
    use 'airblade/vim-gitgutter'

    ---------- Search utilities
    use {
      'junegunn/fzf.vim',
      requires = 'junegunn/fzf',
      config = require('plugin-cfg.fzf')
    }
    use {
      'nvim-telescope/telescope.nvim',
      requires = {
        { 'nvim-lua/popup.nvim' },
        { 'nvim-lua/plenary.nvim' },
        { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
        { '~/.config/nvim/lua/ethi' },
      },
      config = require('plugin-cfg.telescope')
    }

    ---------- Misc
    -- Highlight color patterns like #RRGGBB
    use {
      'norcalli/nvim-colorizer.lua',
      config = require('plugin-cfg.nvim-colorizer')
    }
    use {
      'vim-scripts/vim-stay', -- Open a previously closed file where you left it
      config = require('plugin-cfg.vim-stay')
    }
    use 'tomtom/tcomment_vim' -- Commenting and uncommenting bindings
    use "ahmedkhalf/lsp-rooter.nvim" -- `cd` to the LSP root
    use {
      "airblade/vim-rooter", -- `cd` to an identified root directory
      config = require('plugin-cfg.vim-rooter')
    }
    use {
      'rhysd/git-messenger.vim', -- Insteractive git blame  in a floating window
      config = require('plugin-cfg.git-messenger')
    }
    -- Welcome screen
    use {
      'mhinz/vim-startify',
      config = require('plugin-cfg.startify')
    }
    -- Highlight trailing whitespace
    use {
      'ntpeters/vim-better-whitespace',
      config = require('plugin-cfg.vim-better-whitespace')
    }
    -- In-browser markdown previewer
    use {
      'iamcco/markdown-preview.nvim',
      run = function() vim.fn['mkdp#util#install']() end,
      ft = { 'markdown' }
    }
    -- Zen mode
    use {
      'Pocco81/true-zen.nvim',
      config = require('plugin-cfg.true-zen')
    }
  end,
  config = {
    display = {
      open_fn = require('packer.util').float,
    }
  }
})
