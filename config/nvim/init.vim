" nvimrc
" Plugins ------------------------------------------------------------------ {{{

filetype plugin indent on
syntax on

call plug#begin('~/.nvim/plugged')

Plug 'ctrlpvim/ctrlp.vim'
Plug 'airblade/vim-gitgutter'
Plug 'tomtom/tcomment_vim'
Plug 'Konfekt/FastFold'
Plug 'embear/vim-localvimrc'

" Go
Plug 'fatih/vim-go'

" Snippets
Plug 'SirVer/ultisnips'

" tpope
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'

" vim-scripts
Plug 'vim-scripts/vim-stay'                 " Open a previously closed file where you left it

" Colors
Plug 'nanotech/jellybeans.vim'
Plug 'w0ng/vim-hybrid'
Plug 'luochen1990/rainbow'
Plug 'octol/vim-cpp-enhanced-highlight'

" Completion
" Plug 'Valloric/YouCompleteMe', {'do' : './install.py --clang-completer'}
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'Valloric/ListToggle'
Plug 'rdnetto/YCM-Generator', {'branch' : 'stable'}
Plug 'neomake/neomake'

" Cosmetics
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'

" }}}

call plug#end()

" Options ------------------------------------------------------------------ {{{

""" Basic ------------------------------------------------------------------ {{{

let mapleader = ","

set clipboard=unnamed
set completeopt-=preview    " Hide scratch buffer on completion
set cursorline              " Highlight current line
set foldmethod=syntax
set notimeout               " No timeout on key codes
set number
set relativenumber
set scrolloff=999           " Keep the cursor centered
set showbreak=↪             " Show line wrapping character

" set background=dark
colorscheme jellybeans
highlight Normal ctermbg=none
highlight NonText ctermbg=none
" highlight CursorLine ctermbg=none

""" }}}

""" Search ----------------------------------------------------------------- {{{

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

""" Search ----------------------------------------------------------------- {{{

set ignorecase
set smartcase

""" }}}

""" Tabs ------------------------------------------------------------------- {{{

set shiftwidth=2            " Number of spaces for auto-indent
set smartindent
set tabstop=2
set expandtab               " Insert spaces instead of tabs

""" }}}

" }}}

" Functions ---------------------------------------------------------------- {{{

let s:highlight_flag = 0

" Visual search. Stolen from @sjl.
function! s:VSetSearch()
  let temp = @@
  norm! gvy
  let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
  let @@ = temp
endfunction

" }}}

" Mappings ----------------------------------------------------------------- {{{

" Stop pressing that shift button (qwerty keyboards)
nnoremap ; :
vnoremap ; :

" Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y

" Buffer switching
nnoremap <leader>n :bnext<CR>
nnoremap <leader>p :bprevious<CR>

" Remove search highlight with //
nnoremap <silent> // :nohlsearch<CR>

" Switch to alternate file.
nnoremap <Leader><Leader> <C-^>

" Splits
nnoremap <silent> ss :split<CR><C-W>j
nnoremap <silent> vv :vsplit<CR><C-W>l

" Search
nnoremap / /\v
vnoremap / /\v
nnoremap ? ?\v
vnoremap ? ?\v

" Tabs
nnoremap T :tabnew<cr>
nnoremap H :tabprev<cr>
nnoremap L :tabnext<cr>

" Convenience
command! W w
command! Q q

" Exit insert mode
inoremap jk <ESC>

" Folds
nnoremap <Space> za

" TComment
map <Leader>c <C-_><C-_>

" Clang-format

noremap <leader>x :pyf ~/.config/nvim/clang-format.py<CR>

" Misc
nnoremap <Up><Up><Down><Down><Left><Right><Left><Right>ba<space> :wq<ENTER>
nnoremap Y ggVG"+y

" }}}

" Plugin configuration ----------------------------------------------------- {{{

""" Ctrl-P ----------------------------------------------------------------- {{{

let g:ctrlp_working_path_mode = 'ra'
" Ignore files in .gitignore
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_mruf_relative = 1
let g:ctrlp_clear_cache_on_exit = 0

""" }}}

""" FastFold --------------------------------------------------------------- {{{

let g:fastfold_savehook = 0
let g:fastfold_fold_command_suffixes = []

""" }}}

""" Hybrid ------------------------------------------------------------------ {{{

let g:hybrid_custom_term_colors = 1

""" }}}


""" ListToggle ------------------------------------------------------------- {{{

let g:lt_location_list_toggle_map = '<leader>l'
let g:lt_quickfix_list_toggle_map = '<leader>q'

""" }}}

""" rainbow ---------------------------------------------------------------- {{{

let g:rainbow_active = 1
let g:rainbow_conf = {
                      \'parentheses': 
                          \['start=/(/ end=/)/',
                           \'start=/\[/ end=/\]/',
                           \'start=/{/ end=/}/ fold'],
                    \}

""" }}}

""" UltiSnips -------------------------------------------------------------- {{{

autocmd BufEnter * if &filetype == "" | setlocal ft=text | endif
let g:UltiSnipsSnippetDirectories = [$HOME.'/.config/nvim/UltiSnips/']
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'

""" }}}

""" vim-airline ------------------------------------------------------------ {{{

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline_powerline_fonts = 1

nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9

""" }}}

""" vim-cpp-enhanced-highlight --------------------------------------------- {{{

let g:cpp_class_scope_highlight = 1

""" }}}

""" vim-go --------------------------------------------- {{{

let g:go_fmt_command = "goimports"
let g:go_fmt_experimental = 1

""" }}}

""" YouCompleteMe ---------------------------------------------------------- {{{

nnoremap <leader>d :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>f :YcmCompleter GoToDefinition<CR>
nnoremap <leader>e :YcmCompleter GoToInclude<CR>
nnoremap <leader>t :YcmCompleter GetType<CR>

let g:ycm_key_list_select_completion = ['<C-j>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-k>', '<Up>']
let g:ycm_always_populate_location_list = 1
let g:ycm_extra_conf_globlist = ['~/*']
" basic config
let g:ycm_global_ycm_extra_conf = '~/.config/nvim/.ycm_extra_conf.py'

""" }}}

""" neomake ---------------------------------------------------------------- {{{

call neomake#configure#automake('nrwi', 500)
let g:neomake_c_enabled_makers = ['clangtidy']
let g:neomake_cpp_enabled_makers = ['clangtidy']

""" }}}

let g:python3_host_prog = "/usr/bin/python3"
let g:python_host_prog = "/usr/bin/python2"

" }}}
