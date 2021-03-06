local actions = require "telescope.actions"
local sorters = require "telescope.sorters"

local previewers = require('telescope.previewers')
local putils = require('telescope.previewers.utils')
local pfiletype = require('plenary.filetype')
local new_maker = function(filepath, bufnr, opts)
    opts = opts or {}
    if opts.use_ft_detect == nil then
        local ft = pfiletype.detect(filepath)
        -- Here for example you can say: if ft == "xyz" then this_regex_highlighing else nothing end
        opts.use_ft_detect = false
        putils.regex_highlighter(bufnr, ft)
    end
    previewers.buffer_previewer_maker(filepath, bufnr, opts)
end

require("telescope").setup({
    defaults = {
        buffer_previewer_maker = new_maker, -- custom preview which will optimize telescope
        prompt_prefix = " ❯ ",
        sorting_strategy = "ascending",
        file_ignore_patterns = {"node_modules", "target", "dependencies", "modules"},
        mappings = {
            i = {
                ["<ESC>"] = actions.close,
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                ["<TAB>"] = actions.toggle_selection +
                    actions.move_selection_next,
                ["<C-s>"] = actions.send_selected_to_qflist,
                ["<C-q>"] = actions.send_to_qflist
            }
        },
        file_sorter = sorters.get_fzy_sorter,
        generic_sorter = sorters.get_fzy_sorter,
        path_display = {shorten = 5}
    },
    extensions = {
media_files = {
      -- filetypes whitelist
      -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
      filetypes = {"png", "webp", "jpg", "jpeg"},
      find_cmd = "rg" -- find command (defaults to `fd`)
    },
        frecency = {
            show_scores = false,
            show_unindexed = true,
            ignore_patterns = {"*.git/*", "*/tmp/*"},
            disable_devicons = false,
            workspaces = {["conf"] = "~/.config"}
        },
    }
})

require('telescope').load_extension('dap')
require('telescope').load_extension('media_files')
