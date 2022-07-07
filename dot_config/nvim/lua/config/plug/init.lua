--[[
This init file loads all of the plugin configuration files
--]]

return {
	require('config.plug.hop'),
	require('config.plug.cmp'),
	require('config.plug.yanky'),
	require('config.plug.cutlass'),
	require('config.plug.lualine'),
	require('config.plug.lspkind'),
	require('config.plug.tabline'),
	require('config.plug.tree'),
	require('config.plug.gitsigns'),
	require('config.plug.ultisnips'),
	require('config.plug.dashboard'),
	require('config.plug.autopairs'),
	require('config.plug.telescope'),
	require('config.plug.which-key'),
	require('config.plug.nvimcomment'),
	require('config.plug.nvimcolorizer'),
	require('config.plug.treesitter'),
	require('config.plug.wilder')
	-- require('config.plug.cokeline'),
	-- require('config.plug.tabby')
}

-- # vim foldmethod=marker
