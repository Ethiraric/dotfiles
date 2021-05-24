-- {{@@ header() @@}}

return function ()
  vim.cmd('autocmd BufEnter * if &filetype == "" | setlocal ft=text | endif')
  vim.cmd('let g:UltiSnipsSnippetDirectories = [$HOME.\'/.config/nvim/UltiSnips/\']')
end
