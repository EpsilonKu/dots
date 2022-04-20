local M = {}

function M.config()
    -- local U = require "utils"
    local g = vim.g
	require'nvim-treesitter.configs'.setup {
		rainbow = {
			enable = true
		},
		highlight = {
			enable = true,
			disable = {}
		},
		indent = {
			enable = true,
		}
	}
	require('nvim-ts-autotag').setup()
end
return M
