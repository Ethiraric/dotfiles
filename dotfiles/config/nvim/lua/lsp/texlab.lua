return {
  name = 'texlab',
  settings = {
    texlab = {
      build = {
        executable = 'tectonic',
        args = {
          '%f',
          '--synctex',
          '--keep-logs',
          '--keep-intermediates',
        },
        latexFormatter = 'texlab'
      },
    },
  },
  on_attach = function ()
    vim.cmd('autocmd BufWritePost *.tex TexlabBuild')
  end
}
