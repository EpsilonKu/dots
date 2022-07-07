
				require("flutter-tools").setup {
					debugger = {
						enabled = true,
						run_via_dap = true,
					},
					dev_log = {
						enabled = true,
						open_cmd = "30vnew"
					},
				}
