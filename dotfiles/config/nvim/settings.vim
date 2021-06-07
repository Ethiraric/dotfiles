" {{@@ header() @@}}

filetype plugin indent on   " https://vi.stackexchange.com/a/10125

syntax enable               " enable syntax highlighting

set termguicolors           " Enable 24-bit colors
set clipboard=unnamed       " Share system clipboard
set cursorline              " Highlight current line
set foldmethod=syntax       " Syntax based folding
set notimeout               " No timeout on key codes
" set timeoutlen=150          " To set a timeout
set number                  " Display line numbers
set relativenumber          " Print offset from highlighted line
set scrolloff=999           " Keep the cursor centered
set showbreak=↪             " Show line wrapping character
set inccommand=split        " Interactive search and replace

" set background=dark
" highlight Normal ctermbg=none
" highlight NonText ctermbg=none

set smartcase               " Use smartcase when searching

set shiftwidth=2            " Number of spaces for auto-indent
set tabstop=2               " Number of spaces per tab
set expandtab               " Insert spaces instead of tabs
set smartindent             " Automatically indents on patterns (e.g.: {, })

" Backup, undo and swapfiles
set backup
set undofile
set noswapfile
set undodir=~/.nvim/tmp/undo/
set backupdir=~/.nvim/tmp/backup/
set directory=~/.nvim/tmp/swap/

" Create those directories if needed
if !isdirectory(expand(&undodir))
  call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
  call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
  call mkdir(expand(&directory), "p")
endif
