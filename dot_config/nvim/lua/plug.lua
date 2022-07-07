require('packer').startup({
	function(use)
		-- packer self management
		use('wbthomason/packer.nvim')

		-- {{{ lsp/autocompletion/snippets
		-- lsp plugins
		use({ 'neovim/nvim-lspconfig' })
		use({ 'onsails/lspkind-nvim' })
		use({ 'akinsho/flutter-tools.nvim'})

		-- autocompletion
		use({
			'hrsh7th/nvim-cmp',
			requires = {
				{ 'hrsh7th/cmp-nvim-lsp' },
				{ 'hrsh7th/cmp-path' },
				{ 'hrsh7th/cmp-buffer' },
				{ 'hrsh7th/vim-vsnip'}
			},
		})
		use({'mfussenegger/nvim-jdtls'})

		-- snippets
		-- use({ 'sirver/ultisnips', commit = 'c6ace8c' })
		--use({ 'quangnguyen30192/cmp-nvim-ultisnips', commit = 'c6ace8c' })
		-- }}}

		-- {{{ utility plugins
		-- these plugins are all realted to editor configs
		use({
			'nvim-lualine/lualine.nvim',
			requires = { 'kyazdani42/nvim-web-devicons', opt = true },
			commit = '18a07f7',
		})
		use({ 'kdheepak/tabline.nvim' })
		use({
			'nvim-telescope/telescope.nvim',
			requires = {
				{ 'nvim-lua/popup.nvim', commit = 'b7404d3' },
				{ 'nvim-lua/plenary.nvim', commit = '9069d14' },
			},
			commit = '6e7ed1b',
		})
		use({ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', commit = '8ec164b' })
		use({ 'windwp/nvim-autopairs', commit = '38d486a' })
		use({ 'terrortylor/nvim-comment', commit = '8619217' })
		use({ 'sbdchd/neoformat', commit = '06920fa' })
		use({ 'phaazon/hop.nvim', commit = 'e2f978b' })
		use({ 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' }, commit = '565b94d' })
		use({ 'folke/which-key.nvim', commit = 'a3c19ec' })
		-- use({ 'noib3/nvim-cokeline'})
		use({ 'mfussenegger/nvim-dap'})
		use({ 'rcarriga/nvim-dap-ui', requires = { 'mfussenegger/nvim-dap'}})
		use({ 'gbprod/cutlass.nvim'})
		use({ 'gbprod/yanky.nvim'})
		use({ 'gelguy/wilder.nvim'})
		-- use({ 'nanozuki/tabby.nvim'}) TODO: Configure whe update come
		-- }}}

		-- {{{ file manager
		use {
			"nvim-neo-tree/neo-tree.nvim",
			branch = "v2.x",
			requires = {
				"nvim-lua/plenary.nvim",
				"kyazdani42/nvim-web-devicons",
				"MunifTanjim/nui.nvim"
			}
		}
		-- }}}

		-- {{{ imporved syntax plugins
		-- these add in a bit more bling and flair to nvim
		use({ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' })
		use({ 'glepnir/dashboard-nvim', disable = false})
		use({'norcalli/nvim-colorizer.lua', commit = '36c610a'})
		-- }}}

		-- {{{ themes
		-- popular themes incoming
		use({'joshdick/onedark.vim'})
		use({'sickill/vim-monokai'})
		use({'morhetz/gruvbox'})
		use({'shaunsingh/nord.nvim'})
		use({'sainnhe/gruvbox-material'})

		-- neesh themes
		use({'sainnhe/everforest'})
		use({'relastle/bluewery.vim'})
		use({'haishanh/night-owl.vim'})

		-- my themes
		use ({'savq/melange'})
		use ({'lmburns/kimbox'})
		-- }}}
		--
	end,
	-- display packer dialouge in the center in a floating window
	config = {
		display = {
			open_fn = require('packer.util').float,
		},
	},
})

-- # vim foldmethod=marker
