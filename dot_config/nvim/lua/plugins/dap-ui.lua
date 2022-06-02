local U = {}
local term
U.openFloat = function()
	term = require('dap.ui.widgets').new_centered_float_win(vim.api.nvim_create_buf(false, true))
end
U.toggleFloat = function()
	term.toggle()
end
U.closeFloat = function()
	term.close()
end
return U
