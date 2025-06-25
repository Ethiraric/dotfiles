-- {{@@ header() @@}}

local user_bookmarks = vim.g.startup_bookmarks

local bookmark_texts = { "Bookmarks", "" }
local user_bookmark_mappings = {}

if not user_bookmarks then
  user_bookmarks = {}
  bookmark_texts = {}
end

local umbreon = {
  '                                              &xu.                      .  ',
  '                      .                      !MQ|?95.                 .JTJ.',
  '                     .dM                       JMh.&g=d..            .MM:JF',
  '                     MM"J                       JMF = .,=2           M"M:JF',
  '                    N#"g|dF                     .?b, JJf1,F        ..5 7u7!',
  '                    MNN&cv7r                       9gMMM#.?N       .b.. J  ',
  '                    MMM=dp,S,                        JMMNm?T.       M#".J  ',
  '                    ^MMM\'\'?3 :                         .7#MM+dNjb..JM#4.M   ',
  '                     F ?   .Tg                          bMMMMM5.`.JMNKF    ',
  '                     ^. .&,5 M                        JMMMMMM&,7gYgJ7#5.   ',
  '                      MNMn.E.!d                      .MMM@""WMNb ..J#..M.  ',
  '                       JMMNK!:d                     .JMMMF   .MMMMMY7.M J  ',
  '                       .JMMNJ:d   .........     ...NMMMMMF M! !MMMT6J,"J?  ',
  '                        .YMMN.cGg&MMiJN.M.dh+JggdMMMMMMMMNm... MMMiJs5."   ',
  '                          `MMMar7MMMMNe7g"QgMMMMMMMMMM\\dMMMMMMMMMMM\'\'`gF    ',
  '                           .MMMMMMMMMMMMMMMMMMMMMMMMNJ7h.BYMMMMMMMMMP3     ',
  '                           NMMMMMMMMMMMMMMMMMMMMMMMMNIlJ5Jx?dFJY"H         ',
  '                          .MMMMMMMMMMMMMMMMMMMMMMMMMMMg;?#?:d              ',
  '                          N.MMMMMMMMMMMMMMMMMMMMMMMMMMM#B.M+d              ',
  '                        .JNs?MMMF. dMMMMMMMMMMMMMMMMMMMNmjmM               ',
  '                       .JMMF M"i.M# ,TM#7MMaJ.gj?9TMMMMM#T.M               ',
  '                       JMMMF M .##B ..M@D     MMNM#.MM"""gM"               ',
  '                      dMMM#T.Mj, 5 JJMF!     .MMMM#.M!u+J?b                ',
  '                     #MMMMt MMMNN##""        MMMMMF.M JMF #                ',
  '                     NMMM   MMMMF$          gMMMMT!  J!``gb                ',
  '                     MMMd   MMMM$         ..#4&M?    .dMMMMM               ',
  '                     MMMM   MMMMF         Jb.F5       .4MMMMWW,.           ',
  '                      M:dM. MMMM@I,          `          @#?7dL.F           ',
  '                            ?4Mp.F\'\'                      "????\'\'            '
}

for key, file in pairs(user_bookmarks) do
  bookmark_texts[#bookmark_texts + 1] = key .. " " .. file
end

for key, file in pairs(user_bookmarks) do
  user_bookmark_mappings[key] = "<cmd>e " .. file .. "<CR>"
end


-- NOTE: lua dump(vim.fn.expand("#<1")) to get newest oldfile

vim.api.nvim_set_hl(0, 'StartupUmbreon', { fg = "#4493f8", bold = true })
vim.api.nvim_set_hl(0, 'StartupLocalOldFiles', { fg = "#779CE6", bold = false })
vim.api.nvim_set_hl(0, 'StartupOldFiles', { fg = "#808080", bold = false })

local settings = {
  header = {
    type = "text",
    oldfiles_directory = false,
    align = "center",
    fold_section = false,
    title = "Header",
    margin = 5,
    content = umbreon,
    highlight = "StartupUmbreon",
    default_color = "#4493f8",
    oldfiles_amount = 0,
  },
  local_old_files = {
    type = "oldfiles",
    oldfiles_directory = true,
    align = "center",
    fold_section = false,
    title = "Old files in CWD",
    margin = 5,
    content = "",
    highlight = "StartupLocalOldFiles",
    oldfiles_amount = 20,
  },
  old_files = {
    type = "oldfiles",
    oldfiles_directory = false,
    align = "center",
    fold_section = false,
    title = "Old files",
    margin = 5,
    content = "",
    highlight = "StartupOldFiles",
    default_color = "",
    oldfiles_amount = 10,
  },
  bookmarks = {
    type = "text",
    align = "left",
    margin = 5,
    content = bookmark_texts,
    highlight = "String",
  },
  options = {
    after = function()
      require("startup").create_mappings(user_bookmark_mappings)
      require("startup.utils").oldfiles_mappings()
    end,
    mapping_keys = false,
    cursor_column = 0.25,
    empty_line_between_mappings = 1,
    disable_statuslines = true,
    paddings = { 5, 10, 7, 3 },
  },
  mappings = {
    execute_command = "<CR>",
    open_file = "o",
    open_file_split = "<c-o>",
    open_section = "<TAB>",
    open_help = "?",
  },
  colors = {
    background = "#000000",
    folded_section = "#56b6c2",
  },
  parts = { "header", "local_old_files", "old_files", "bookmarks" },
}

return settings
