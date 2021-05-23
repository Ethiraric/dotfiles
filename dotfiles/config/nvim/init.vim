" {{@@ header() @@}}

luafile $HOME/.config/nvim/lua/config.lua
source $HOME/.config/nvim/settings.vim

""" Basic ------------------------------------------------------------------ {{{

let mapleader = ","
colorscheme jellybeans

" Mappings ----------------------------------------------------------------- {{{
" Clang-format
autocmd FileType c,cpp nnoremap <leader>x :ClangFormat<CR>
autocmd FileType c,cpp ClangFormatAutoEnable

" }}}

" Plugin configuration ----------------------------------------------------- {{{

""" Vim-Stay --------------------------------------------------------------- {{{
" When using vim-stay, dont save the cwd and options/mappings to the buffer.
set viewoptions-=options
set viewoptions-=curdir

""" FZF -------------------------------------------------------------------- {{{

nnoremap / :BLines<CR>
" Much like :Ag, but ignoring the `deps` and `.git` folders
nnoremap <c-j> :call fzf#vim#grep('ag --ignore deps --ignore .git --color -- "^(?=.)"', 0, fzf#vim#with_preview())<CR>
nnoremap <c-b> :Buffer<CR>

""" }}}

""" FastFold --------------------------------------------------------------- {{{

let g:fastfold_savehook = 0
let g:fastfold_fold_command_suffixes = []

""" }}}

""" Hybrid ----------------------------------------------------------------- {{{

let g:hybrid_custom_term_colors = 1

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

