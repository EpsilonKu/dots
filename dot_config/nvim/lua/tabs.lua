local U = {}

local tabs = nil
function U.bufNew(file)
	if (tabs == nil) then
		bufInit()
	end
end

function U.bufInit()

	-- local cur_bufid = vim.api.nvim_get_current_buf()
	for _, bufid in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_valid(bufid) and vim.bo[bufid].buflisted then
			--[[ if (vim.api.nvim_buf_get_option(bufid, "icon") ~= nil) then
				vim.api.nvim_buf_set_option(bufid, "icon", '1-' .. bufid)
			end ]]
			vim.bo[bufid].number = "test"
		else
			print(bufid)
		end
	end
end

return U
