-- {{@@ header() @@}}

return require('packer').startup(function (use)
  use 'wbthomason/packer.nvim'
  use 'kjwon15/vim-transparent'

  use 'airblade/vim-gitgutter'
  use 'tomtom/tcomment_vim'
  use 'Konfekt/FastFold'
  use 'embear/vim-localvimrc'
  use 'rhysd/vim-clang-format'
  use 'alx741/vim-rustfmt'

  -- Snippets
  use 'SirVer/ultisnips'

  -- tpope
  use 'tpope/vim-fugitive'
  use 'tpope/vim-surround'

  -- vim-scripts
  -- Open a previously closed file where you left it
  use 'vim-scripts/vim-stay'

  -- Colors
  use 'nanotech/jellybeans.vim'
  use 'w0ng/vim-hybrid'
  use 'luochen1990/rainbow'
  use 'octol/vim-cpp-enhanced-highlight'

  -- Completion
  use { 'neoclide/coc.nvim',
        branch = 'release' }
  -- use 'Valloric/ListToggle'
  use 'junegunn/fzf' -- , { 'dir':'~/.fzf','do':'./install --all' }
  use 'junegunn/fzf.vim'

  use {
  'nvim-telescope/telescope.nvim',
    requires = {
      { 'nvim-lua/popup.nvim' },
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
    },
    config = require('plugin-cfg.telescope')
  }

  -- Cosmetics
  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'
  use 'ryanoasis/vim-devicons'
  use 'mhinz/vim-startify'
end)
