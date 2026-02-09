-- {{@@ header() @@}}

return {
  { "junegunn/fzf" },
  {
    "junegunn/fzf.vim",
    dependencies = { "junegunn/fzf" },
    keys = {
      {
        "/",
        ":BLines<CR>",
        desc = "Fzf through buffer lines",
      },
      {
        "<C-j>",
        ':call fzf#vim#grep(\'ag --ignore deps --ignore .git --color -- "^(?=.)"\')<CR>',
        desc = "Fzf through project lines",
      },
      {
        "<C-b>",
        ":Buffer<CR>",
        desc = "Fzf through opened buffers",
      }
    }
  }
}
