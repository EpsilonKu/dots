local dapui = require "dapui"
local dap = require("dap")

dapui.setup(
	{
		icons = {
			expanded = "↴",
			collapsed = "»"
		},
		mappings = {
			-- Use a table to apply multiple mappings
			expand = { "<CR>", "<2-LeftMouse>" },
			open = "o",
			remove = "d",
			edit = "e",
			repl = "r"
		},
		layouts = {
			{
				elements = {
					-- Elements can be strings or table with id and size keys.
					{ id = "scopes", size = 0.25 },
					"breakpoints",
					"stacks",
					"watches",
				},
				size = 40,
				position = "left",
			},
			{
				elements = {
					"repl",
					"console",
				},
				size = 10,
				position = "bottom",
			},
		},
		floating = {
			border = "rounded",
			max_height = 0.4, -- These can be integers or a float between 0 and 1.
			max_width = 0.3, -- Floats will be treated as percentage of your screen.
			mappings = {
				close = { "q", "<Esc>" }
			}
		}
	}
)
dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end
