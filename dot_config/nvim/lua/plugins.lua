vim.cmd [[packadd packer.nvim]]
vim.cmd [[ autocmd bufwritepost plugins.lua PackerCompile ]]

return require("packer").startup(function()
    use {"wbthomason/packer.nvim", opt = true}

    -- {{ neovim lspsaga
    use {
        "shaeinst/penvim",
        config = function()
            require("penvim").setup({
                project_env = {enable = true, config_name = ".__nvim__.lua"},
                rooter = {
                    enable = true,
                    patterns = {
                        "init.lua", ".__nvim__.lua", ".git", "node_modules",
                        ".sln", ".svn"
                    }
                }
            })
        end
    }
    use {
        "neovim/nvim-lspconfig",
        config = function()
            require("plugins.lsp.lsp")
            require("plugins.lsp.servers")
        end
    }
	use {
		"rcarriga/nvim-notify",
		config = function ()
			require("notify").setup({
  level = "info",
  stages = "fade_in_slide_out",
  on_open = nil,
  on_close = nil,
  render = "default",
  timeout = 5000,
  background_colour = "Normal",

  minimum_width = 50,

})
		end
	}
    use {"tjdevries/nlua.nvim"}
    use {"onsails/lspkind-nvim"}
    use {
        "ray-x/lsp_signature.nvim",
        config = function()
            local cfg = {
                bind = true, -- This is mandatory, otherwise border config won't get registered.
                hint_prefix = "🐼 ",
                handler_opts = {border = "rounded"}
            } -- add you config here
            require"lsp_signature".setup(cfg)
        end
    }
    use {"tami5/lspsaga.nvim"}
    use {"nvim-lua/lsp-status.nvim"}
    use {
        "ahmedkhalf/project.nvim",
        config = function()
local project_nvim = require("project_nvim")
			project_nvim.setup ({})
			--[[ local recent_projects = project_nvim.get_recent_projects()
print("recent")
print(vim.inspect(recent_projects)) ]]
		end
    }
    use {"hrsh7th/vim-vsnip"}
    use {"hrsh7th/vim-vsnip-integ"}
    use {"rafamadriz/friendly-snippets"}
    use {"hrsh7th/cmp-nvim-lsp"}
    use {"uga-rosa/cmp-dictionary"}
    use "lukas-reineke/cmp-rg"
    use {"hrsh7th/cmp-path", after = "nvim-cmp"}
    use {"hrsh7th/cmp-buffer", after = "nvim-cmp"}
    use {
        "hrsh7th/nvim-cmp",
        config = function()
            -- your config
            require("plugins.cmp")
        end
    }

    use {
        "folke/trouble.nvim",
        config = function() require("plugins.trouble") end
    }
    use {
        "folke/todo-comments.nvim",
        requires = {"folke/trouble.nvim"},
        config = function() require("plugins.todo-comments") end
    }
    use {"mfussenegger/nvim-jdtls"}
    use {
        "rcarriga/nvim-dap-ui",
        requires = {
            "mfussenegger/nvim-dap", "theHamsta/nvim-dap-virtual-text",
            "nvim-telescope/telescope-dap.nvim"
        },
        config = function() require("plugins.dap") end
    }
    -- }}
    -- {{ keybinding stuff
    use {
        "folke/which-key.nvim",
        config = function() require("plugins.whichkey") end
    }
    use {"stevearc/dressing.nvim", config = function() end}
    use {
        "nanozuki/tabby.nvim",
        config = function() require("plugins.tabby") end
    }
    use {
        "max397574/better-escape.nvim",
        config = function()
            -- lua, default settings
            require("better_escape").setup {
                mapping = {"jj"}, -- a table with mappings to use
                timeout = 500, -- the time in which the keys must be hit in ms. Use option timeoutlen by default
                clear_empty_lines = false, -- clear line after escaping if there is only whitespace
                keys = "<Esc>" -- keys used for escaping, if it is a function will use the result everytime
            }
        end
    }
    use {"wakatime/vim-wakatime"}
    use {
        "ur4ltz/surround.nvim",
        config = function()
            require"surround".setup {mappings_style = "sandwich"}
        end
    }

    use {
        "gbprod/cutlass.nvim",
        config = function() require("cutlass").setup({cut_key = "c"}) end
    }
    use {
        "b3nj5m1n/kommentary",
        config = function() require("plugins.comment") end
    }
use {
		"lukas-reineke/lsp-format.nvim",
		config = function ()
			require("lsp-format").setup {}
		end
	}
    -- use {"sbdchd/neoformat", config = function() end}
    use {
        "gelguy/wilder.nvim",
        config = function() require("plugins.wilder") end
    }
    use {"simrat39/symbols-outline.nvim"}
    use {
        "rmagatti/auto-session",
        config = function() require("plugins.session") end
    }
    use {
        "mvllow/modes.nvim",
        config = function()
            -- Pass colors through setup
            require("modes").setup({
                colors = {
                    copy = "#f5c359",
                    delete = "#c75c6a",
                    insert = "#78ccc5",
                    visual = "#9745be"
                },
                line_opacity = 0.1,
            })

            -- Or use highlight groups (useful for themes)
            vim.cmd("hi ModesCopy guibg=#f5c359")
            vim.cmd("hi ModesDelete guibg=#c75c6a")
            vim.cmd("hi ModesInsert guibg=#78ccc5")
            vim.cmd("hi ModesVisual guibg=#9745be")
        end
    }
    use {"nanotee/sqls.nvim"}

    -- use {
    --     "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    --     config = function()
    --         require("lsp_lines").register_lsp_virtual_lines()
    --     end
    -- } NOTE:I guess it need to be disabled any virtual text plugins
    use {
        "rmagatti/session-lens",
        requires = {"rmagatti/auto-session", "nvim-telescope/telescope.nvim"},
        config = function()
            require("session-lens").setup({
                prompt_title = "YEAH SESSIONS",
                path_display = {"shorten"},
                previewer = true
            })
        end
    }
    use {"ldelossa/litee.nvim"}
    use {"ldelossa/litee-filetree.nvim"}
    use {"ldelossa/litee-symboltree.nvim"}
    use {"ldelossa/litee-calltree.nvim"}
    use {
        "ldelossa/litee-bookmarks.nvim",
        config = function() require("plugins.litee") end
    }
    -- }}

    -- {{ interface
    use {
        "beauwilliams/focus.nvim",
        config = function() require("focus").setup() end
    }
    use {
        "https://gitlab.com/yorickpeterse/nvim-window.git",
        config = function()
            require("nvim-window").setup({
                -- The characters available for hinting windows.
                chars = {"a", "s", "d", "f", "j", "k", "l", "g", "h"},
                -- A group to use for overwriting the Normal highlight group in the floating
                -- window. This can be used to change the background color.
                normal_hl = "Normal",
                -- The highlight group to apply to the line that contains the hint characters.
                -- This is used to make them stand out more.
                hint_hl = "Bold",
                -- The border style to use for the floating window.
                border = "single"
            })
        end
    }
    use {
        "danymat/neogen",
        config = function() require("neogen").setup {enabled = true} end,
        requires = "nvim-treesitter/nvim-treesitter"
    }
    use {
        "nvim-neorg/neorg",
        setup = vim.cmd(
            "autocmd BufRead,BufNewFile *.norg setlocal filetype=norg"),
        after = {"nvim-treesitter"}, -- you may also specify telescope
        ft = "norg",
        config = function() require("plugins.neorg") end,
        requires = "nvim-lua/plenary.nvim"
    }

    use {
        "luukvbaal/stabilize.nvim",
        config = function() require("stabilize").setup() end
    }
    use {
        -- colorscheme
        "ellisonleao/gruvbox.nvim",
        config = function() require("plugins.theme") end
    }
    use {
        "andweeb/presence.nvim",
        config = function() require("presence"):setup({}) end
    }
    use {
        "lukas-reineke/indent-blankline.nvim",
        config = function() require("plugins.indent") end
    }
    --[[ use {
        -- status line
        "nvim-lualine/lualine.nvim",
        config = require("plugins.lualine").config
    } ]]
    use {
        "windwp/windline.nvim",
        config = function() require("plugins.windline") end
    }

    use {
        "numToStr/Navigator.nvim",
        config = function() require("Navigator").setup() end
    }
    use {
        -- starting screen
        "goolord/alpha-nvim",
        config = function() require("plugins.alpha") end
    }
    -- use {
    -- "sidebar-nvim/sidebar.nvim",
    -- rocks = {"luatz"},
    -- config = require("plugins._navigator").config
    -- }
    --[[ use {
        "kyazdani42/nvim-tree.lua",
        config = function() require("plugins.tree") end
    } ]]
    use {
        "nvim-neo-tree/neo-tree.nvim",
        config = function() require("plugins.tree") end,
        branch = "v2.x",
        requires = {
            "nvim-lua/plenary.nvim", "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim"
        }
    }
    -- use {
    --     "kevinhwang91/rnvimr",
    --     config = require("plugins._ranger").config
    -- }
    use {
        -- auto pairing
        "windwp/nvim-autopairs"
    }
    use {"windwp/nvim-ts-autotag"}
    use {"epsilonku/fterm.nvim"}
    use {
        "akinsho/toggleterm.nvim",
        config = function() require("toggleterm").setup({}) end
    }
    use {
        "wfxr/minimap.vim",
        config = function()
            vim.g.minimap_width = 10
            vim.g.minimap_auto_start = 0
        end
    }
    use {
        "windwp/nvim-spectre",
        config = require("plugins.spectre").config,
        require = {"nvim-lua/plenary.nvim"}
    }
    -- }}

    -- {{ integration
    -- use {
    -- 	'vhyrro/neorg',
    -- 	config = require("plugins.neorg").config
    -- }
    use {"sindrets/diffview.nvim"}
    use {
        -- terminal in neovim
        "voldikss/vim-floaterm",
        config = require("plugins.floaterm").config
    }
    use {"kyazdani42/nvim-web-devicons"}
    -- }}

    -- {{ telescope
    use {
        -- file finder
        "nvim-telescope/telescope.nvim",
        requires = {{"nvim-lua/popup.nvim"}, {"nvim-lua/plenary.nvim"}},
        config = function() require("plugins.telescope") end
    }
    use {"LinArcX/telescope-command-palette.nvim"}
    use {"nvim-telescope/telescope-media-files.nvim"}
    use {
        "AckslD/nvim-neoclip.lua",
        requires = {
            {"nvim-telescope/telescope.nvim"},
            {"tami5/sqlite.lua", module = "sqlite"}
        },
        config = function()
            require("neoclip").setup({enable_persistent_history = false})
        end
    }

    use {
        "nvim-telescope/telescope-frecency.nvim",
        config = function() require"telescope".load_extension("frecency") end,
        requires = {"tami5/sqlite.lua"}
    }
    -- use {'nvim-telescope/telescope-file-browser.nvim'}
    -- }}

    -- {{ treesitter highlight
    use {
        "nvim-treesitter/nvim-treesitter",
        run = {":TSUpdate"},
        config = require("plugins.treesitter").config
    }
    -- use {"p00f/nvim-ts-rainbow"}
    use {"SmiteshP/nvim-gps"}
    use {"David-Kunz/treesitter-unit"}
    -- }}
end)
