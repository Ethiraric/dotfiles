-- {{@@ header() @@}}

return require('packer').startup(function (use)
  ----------  Package manager
  use 'wbthomason/packer.nvim'

  ----------  Cosmetics
  use 'kjwon15/vim-transparent'
  use { 'p00f/nvim-ts-rainbow', config = require('plugin-cfg.ts-rainbow') }
  use 'ryanoasis/vim-devicons'
  use {
    'vim-airline/vim-airline',
    requires = 'vim-airline/vim-airline-themes',
    config = require('plugin-cfg.vim-airline')
  }
  use 'RRethy/vim-illuminate' -- Highlight occurences of hovered word
  -- Themes
  use { 'folke/tokyonight.nvim', config = require('plugin-cfg.tokyonight') }
  use 'tomasiser/vim-code-dark'
  use 'nanotech/jellybeans.vim'

  ---------- LSP
  use {
    'neovim/nvim-lspconfig',
    config = require('lsp'),
    requires = { {
        'RishabhRD/nvim-lsputils',
        requires = 'RishabhRD/popfix',
      }, },
  }
  -- Completion menu
  use { 'hrsh7th/nvim-compe', config = require('plugin-cfg.compe') }
  -- Diagnostics menu
  use {
    'folke/lsp-trouble.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = require('plugin-cfg.lsp-trouble'),
  }
  -- Snippets
  use {
    'SirVer/ultisnips',
    config = require('plugin-cfg.ultisnips')
  }
  -- Folds & highlighting
  use {
    {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
      config = require('plugin-cfg.treesitter'),
    },
    'nvim-treesitter/playground'
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
      { 'nvim-telescope/telescope-fzf-writer.nvim'},
    },
    config = require('plugin-cfg.telescope')
  }

  ---------- Misc
  use {
    'vim-scripts/vim-stay',        -- Open a previously closed file where you left it
    config = require('plugin-cfg.vim-stay')
  }
  use 'tomtom/tcomment_vim'        -- Commenting and uncommenting bindings
  use "ahmedkhalf/lsp-rooter.nvim" -- `cd` to the LSP root
  use {
    'mhinz/vim-startify',          -- Welcom screen
    config = require('plugin-cfg.startify')
  }
end)
