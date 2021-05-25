local actions = require('telescope.actions')
local finders = require('telescope.finders')
local make_entry = require('telescope.make_entry')
local utils = require('telescope.utils')
local pickers = require('telescope.pickers')
local previewers = require('telescope.previewers')
local action_state = require('telescope.actions.state')

local conf = require('telescope.config').values

return require('telescope').register_extension {
  setup = function(_)
  end,
  exports = {
    git_commit_diff = function(opts)
      opts = opts or {}
      local results = utils.get_os_command_output({
        'git', 'log', '--pretty=oneline', '--abbrev-commit', '--', '.'
      }, opts.cwd)
      pickers.new(opts, {
        prompt_title = 'Show diff',
        finder = finders.new_table {
          results = results,
          entry_maker = opts.entry_maker or make_entry.gen_from_git_commits(opts),
        },
        previewer = previewers.git_commit_diff.new(opts),
        sorter = conf.file_sorter(opts),
        attach_mappings = function()
          actions.select_default:replace(function (prompt_bufnr)
            local commit_uid = action_state.get_selected_entry().value
            actions.close(prompt_bufnr)
            local diff = utils.get_os_command_output({
              'git', 'show', commit_uid
            }, opts.cwd)
            local buf = vim.api.nvim_create_buf(true, true)
            vim.api.nvim_buf_set_lines(buf, 0, -1, false, diff)
            vim.api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')
            vim.api.nvim_buf_set_option(buf, 'filetype', 'diff')
            vim.cmd('bnext')
          end)
          return true
        end
      }):find()
    end
  }
}
