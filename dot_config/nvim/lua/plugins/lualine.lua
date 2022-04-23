local M = {}

function M.config()
	--TODO: Consider to migrate Wildline
    local colors = {
        black = "#3c3836",
        white = "#f9f5d7",
        orange = "#af3a03",
        green = "#427b58",
        blue = "#076678",
        gray = "#d5c4a1",
        darkgray = "#7c6f64",
        lightgray = "#ebdbb2",
        inactivegray = "#a89984"
    } --gruvbox
    local bubbles_theme = {
        normal = {
            a = {bg = colors.darkgray, fg = colors.white, gui = "bold"},
            b = {bg = colors.gray, fg = colors.darkgray},
            c = {bg = colors.lightgray, fg = colors.darkgray}
        },
        insert = {
            a = {bg = colors.blue, fg = colors.white, gui = "bold"},
            b = {bg = colors.gray, fg = colors.darkgray},
            c = {bg = colors.gray, fg = colors.black}
        },
        visual = {
            a = {bg = colors.orange, fg = colors.white, gui = "bold"},
            b = {bg = colors.gray, fg = colors.darkgray},
            c = {bg = colors.darkgray, fg = colors.white}
        },
        replace = {
            a = {bg = colors.green, fg = colors.white, gui = "bold"},
            b = {bg = colors.gray, fg = colors.darkgray},
            c = {bg = colors.gray, fg = colors.black}
        },
        command = {
            a = {bg = colors.darkgray, fg = colors.white, gui = "bold"},
            b = {bg = colors.gray, fg = colors.darkgray},
            c = {bg = colors.lightgray, fg = colors.darkgray}
        },
        inactive = {
            a = {bg = colors.lightgray, fg = colors.inactivegray},
            b = {bg = colors.lightgray, fg = colors.inactivegray},
            c = {bg = colors.lightgray, fg = colors.inactivegray}
        }
    }
    local gps = require("nvim-gps")
    gps.setup(
        {
            icons = {
                ["class-name"] = "  ", -- Classes and class-like objects
                ["function-name"] = "  ", -- Functions
                ["method-name"] = "  ", -- Methods (functions inside class-like objects)
                ["container-name"] = "⛶  "
            },
            separator = " | "
        }
    )
	-- log (gps.get_location() )
    local lsp_status = require("lsp-status")
    local config = {
        indicator_errors = " ",
        indicator_warnings = " ",
        indicator_info = "i ",
        indicator_hint = "?",
        indicator_ok = " ",
        status_symbol = ""
    }
    -- config.capabilities = vim.tbl_extend('keep', config.capabilities or {}, lsp_status.capabilities)
    lsp_status.config(config)
    require("lualine").setup {
        options = {
            theme = bubbles_theme,
            component_separators = "|",
            section_separators = {left = "", right = ""}
        },
        sections = {
            lualine_a = {
                {"mode", separator = {left = ""}, left_padding = 4}
            },
            lualine_b = {"filename", "branch"},
            lualine_c = {{gps.get_location, condition = gps.is_available}},
            lualine_x = {"filetype", "progress"},
            lualine_y = {lsp_status.status},
            lualine_z = {
                {"location", separator = {right = ""}, right_padding = 4}
            }
        },
        extensions = {"nvim-tree", "toggleterm"},
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = {},
            lualine_x = {},
            lualine_y = {},
            lualine_z = {}
        }
    }
end

return M
