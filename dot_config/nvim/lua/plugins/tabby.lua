-- TODO: Recolor bg with gray
local colors = {
	black        = '#3c3836',
	white        = '#f9f5d7',
	orange       = '#af3a03',
	green        = '#427b58',
	blue         = '#076678',
	gray         = '#d5c4a1',
	darkgray     = '#7c6f64',
	lightgray    = '#ebdbb2',
	inactivegray = '#a89984'
} --gruvbox
local hl_inactive = { bg = colors.darkgray, fg = colors.white }
local hl_normal = { bg = colors.lightgray, fg = colors.darkgray }
local hl_active = { bg = colors.white, fg = colors.darkgray }
local hl_sep_active = { bg = colors.lightgray, fg = colors.white }
local hl_sep_inactive = { bg = colors.lightgray, fg = colors.darkgray }

local function buffer_render(bufid, is_current)
	local modified = vim.bo[bufid].modified
	local modified_icon = modified and '' or ' '
	local path = vim.fn.bufname(bufid);
	local extension = vim.fn.fnamemodify(path, ":e")
	local filename = vim.fn.fnamemodify(path, ":t")
	local fileicon = require 'nvim-web-devicons'.get_icon(filename, extension, { default = true })
	local buf_name = fileicon .. ' ' .. filename .. modified_icon
	local buf_color = is_current and hl_active or hl_normal
	return {
		type = 'text',
		text = {
			string.format(' %s', buf_name),
			hl = buf_color,
		}
	}

end

local components = function()
	local coms = {
		{
			type = 'text',
			text = {
				'',
				hl = hl_sep_inactive
			}
		},
		{
			type = 'text',
			text = {
				'  ',
				hl = hl_inactive
			}
		},
		{
			type = 'text',
			text = {
				' ',
				hl = hl_sep_inactive
			}
		}
	}
	local tabs = vim.api.nvim_list_tabpages()
	local current_tab = vim.api.nvim_get_current_tabpage()
	for _, tabid in ipairs(tabs) do -- TODO: Fix when opening two tabs
		if tabid == current_tab then
			table.insert(coms, {
				type = 'tab',
				tabid = tabid,
				label = {
					'  ' .. vim.api.nvim_tabpage_get_number(tabid) .. '  ',
					hl = hl_active
				},
				left_sep = { '', hl = hl_sep_active },
				right_sep = { '', hl = hl_sep_active },
			})
		end
		if tabid ~= current_tab then
			table.insert(coms, {
				type = 'tab',
				tabid = tabid,
				label = {
					'  ' .. vim.api.nvim_tabpage_get_number(tabid) .. '  ',
					hl = hl_inactive
				},
			})
		end
	end

	table.insert(coms, { type = 'spring' })
	local cur_bufid = vim.api.nvim_get_current_buf()
	for _, bufid in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_valid(bufid) and vim.bo[bufid].buflisted then
			-- local buf_name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufid), ':~:.')
			local is_current = false;
			if bufid == cur_bufid then
				is_current = true
			end
			local buf_render = buffer_render(bufid, is_current)
			local buf_sep_color_front = is_current and { '', hl = hl_sep_active } or { ' ', hl = hl_normal }
			local buf_sep_color_end = is_current and { '', hl = hl_sep_active } or { ' ', hl = hl_normal }
			table.insert(coms,
				{
					type = 'text',
					text = buf_sep_color_front
				})
			table.insert(coms, buf_render)
			table.insert(coms,
				{
					type = 'text',
					text = buf_sep_color_end
				})
		end
	end
	return coms
end
require('tabby').setup({ components = components })
