
local cmp = require("cmp")
local cmp_autopairs = require('nvim-autopairs.completion.cmp')

require("nvim-autopairs").setup {
    disable_filetype = {"TelescopePrompt", "guihua", "clap_input"},
    autopairs = {enable = true},
    check_ts = false
}
vim.cmd [[
set pumheight=10
]]
local lspkind = require('lspkind')
cmp.setup {
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end
    },
	mapping = {
		['<C-Space>'] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
		['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' })
	},
    sources = {
        { name = "nvim_lsp"},
        { name = "buffer"},
		{ name = 'path' },
		{ name = 'rg' },
    },
	formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol', -- show only symbol annotations
      maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)

      -- The function below will be called before any actual modifications from lspkind
      -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
    })
  }
}
--[[ cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))
cmp_autopairs.lisp[#cmp_autopairs.lisp+1] = "racket" ]]
