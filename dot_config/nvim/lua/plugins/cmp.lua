
local cmp = require("cmp")
local cmp_autopairs = require('nvim-autopairs.completion.cmp')

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end
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
        {name = "nvim_lsp"},
        {name = "buffer"},
		{ name = 'path' },
    	{
    		name = "dictionary",
    		keyword_length = 2,
    	},
		{ name = 'rg' }
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
require("cmp_dictionary").setup({
    dic = {
        ["*"] = { "/usr/share/dict/words" },
        ["css"] = os.getenv("HOME") .. ("/.config/nvim/dictionary/css.dic"),
    },
    -- The following are default values, so you don't need to write them if you don't want to change them
    exact = 2,
    first_case_insensitive = false,
    document = false,
    document_command = "wn %s -over",
    async = true,
    capacity = 5,
    debug = false,
})
-- highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6
-- highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6
-- highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0
-- highlight! CmpItemKindMethod guibg=NONE guifg=#C586C0
-- highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE
-- highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4
cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))
cmp_autopairs.lisp[#cmp_autopairs.lisp+1] = "racket"
