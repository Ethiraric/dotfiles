" {{@@ header() @@}}

source $HOME/.config/nvim/settings.vim
luafile $HOME/.config/nvim/lua/config.lua

colorscheme tokyonight-night

" Presenterm comment command helper
if executable('presenterm') && executable('fzf')
  inoremap <expr> <c-k> fzf#vim#complete(fzf#wrap({
        \ 'source':  'presenterm --list-comment-commands',
        \ 'options': '--header "Comment Command Selection" --no-hscroll',
        \ 'reducer': { lines -> lines[0] } }))
endif
