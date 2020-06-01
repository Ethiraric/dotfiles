" nvimrc
" Plugins ------------------------------------------------------------------ {{{

filetype plugin indent on
syntax on

call plug#begin('~/.nvim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'tomtom/tcomment_vim'
Plug 'Konfekt/FastFold'
Plug 'embear/vim-localvimrc'
Plug 'rhysd/vim-clang-format'

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
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'Valloric/ListToggle'
Plug 'junegunn/fzf', { 'dir':'~/.fzf','do':'./install --all' }
Plug 'junegunn/fzf.vim',

" Cosmetics
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'
Plug 'mhinz/vim-startify'

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
set inccommand=split        " Interactive search and replace

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

" Exit insert mode
inoremap jk <ESC>

" Folds
nnoremap <Space> za

" TComment
map <Leader>c <C-_><C-_>

" Clang-format
autocmd FileType c,cpp nnoremap <leader>x :ClangFormat<CR>
autocmd FileType c,cpp ClangFormatAutoEnable

" Misc
nnoremap <Up><Up><Down><Down><Left><Right><Left><Right>ba<space> :wq<ENTER>
nnoremap Y ggVG"+y

" Stop randomly `chdir`ing
augroup AutoChdir
  autocmd!
augroup END
set noautochdir

" }}}

" Plugin configuration ----------------------------------------------------- {{{

""" FZF -------------------------------------------------------------------- {{{

" Show FZF when pressing ctrl-p
noremap <c-p> :FZF<CR>
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git --ignore deps -g ""'
nnoremap / :BLines<CR>

""" }}}

""" FastFold --------------------------------------------------------------- {{{

let g:fastfold_savehook = 0
let g:fastfold_fold_command_suffixes = []

""" }}}

""" Hybrid ----------------------------------------------------------------- {{{

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

""" coc -------------------------------------------------------------------- {{{

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr><C-Space> pumvisible() ? "\<C-n>" : coc#refresh()
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
nnoremap <silent> <leader>t :call CocActionAsync('doHover')<CR>
nnoremap <silent> K :CocAction<CR>
nmap <silent> <leader>f <Plug>(coc-declaration)

""" }}}

let g:python3_host_prog = "/usr/bin/python3"

autocmd FileType json syntax match Comment +\/\/.\+$+

" }}}

""" startify-vim ----------------------------------------------------------- {{{

" Shamelessly stolen from https://forums.glitchcity.info/index.php?topic=617.0
let g:startify_custom_header = [
  \   '                                              &xu.                      .  ',
  \   '                      .                      !MQ|?95.                 .JTJ.',
  \   '                     .dM                       JMh.&g=d..            .MM:JF',
  \   '                     MM"J                       JMF = .,=2           M"M:JF',
  \   '                    N#"g|dF                     .?b, JJf1,F        ..5 7u7!',
  \   '                    MNN&cv7r                       9gMMM#.?N       .b.. J  ',
  \   '                    MMM=dp,S,                        JMMNm?T.       M#".J  ',
  \   '                    ^MMM''?3 :                         .7#MM+dNjb..JM#4.M   ',
  \   '                     F ?   .Tg                          bMMMMM5.`.JMNKF    ',
  \   '                     ^. .&,5 M                        JMMMMMM&,7gYgJ7#5.   ',
  \   '                      MNMn.E.!d                      .MMM@""WMNb ..J#..M.  ',
  \   '                       JMMNK!:d                     .JMMMF   .MMMMMY7.M J  ',
  \   '                       .JMMNJ:d   .........     ...NMMMMMF M! !MMMT6J,"J?  ',
  \   '                        .YMMN.cGg&MMiJN.M.dh+JggdMMMMMMMMNm... MMMiJs5."   ',
  \   '                          `MMMar7MMMMNe7g"QgMMMMMMMMMM\dMMMMMMMMMMM''`gF    ',
  \   '                           .MMMMMMMMMMMMMMMMMMMMMMMMNJ7h.BYMMMMMMMMMP3     ',
  \   '                           NMMMMMMMMMMMMMMMMMMMMMMMMNIlJ5Jx?dFJY"H         ',
  \   '                          .MMMMMMMMMMMMMMMMMMMMMMMMMMMg;?#?:d              ',
  \   '                          N.MMMMMMMMMMMMMMMMMMMMMMMMMMM#B.M+d              ',
  \   '                        .JNs?MMMF. dMMMMMMMMMMMMMMMMMMMNmjmM               ',
  \   '                       .JMMF M"i.M# ,TM#7MMaJ.gj?9TMMMMM#T.M               ',
  \   '                       JMMMF M .##B ..M@D     MMNM#.MM"""gM"               ',
  \   '                      dMMM#T.Mj, 5 JJMF!     .MMMM#.M!u+J?b                ',
  \   '                     #MMMMt MMMNN##""        MMMMMF.M JMF #                ',
  \   '                     NMMM   MMMMF$          gMMMMT!  J!``gb                ',
  \   '                     MMMd   MMMM$         ..#4&M?    .dMMMMM               ',
  \   '                     MMMM   MMMMF         Jb.F5       .4MMMMWW,.           ',
  \   '                      M:dM. MMMM@I,          `          @#?7dL.F           ',
  \   '                            ?4Mp.F''                      "????''            '
  \ ]

""" }}}

