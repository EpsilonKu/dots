local package = require('core.pack').package
local conf = require('modules.lsp.config')

package({
  'neovim/nvim-lspconfig',
  lazy = true,
  config = conf.nvim_lsp,
})

-- package({ 'glepnir/lspsaga.nvim', after = 'nvim-lspconfig', config = conf.lspsaga })
package({ 'weilbith/nvim-code-action-menu', config = conf.code_action, cmd = 'CodeActionMenu' })

package({ 'mfussenegger/nvim-dap', lazy = true })

package({ 'rcarriga/nvim-dap-ui', config = conf.dap_ui, lazy = true })


package(
  { 'onsails/lspkind.nvim', after = 'nvim-cmp', config = conf.lspkind }
)
package({
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  config = conf.nvim_cmp,
  dependencies = {
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-path' },
    { 'hrsh7th/cmp-buffer' },
    { 'saadparwaiz1/cmp_luasnip' },
  },
})
package({
  'folke/trouble.nvim', config = conf.trouble, cmd = 'Trouble'
})
package({
  "folke/todo-comments.nvim",
  dependencies = {"nvim-lua/plenary.nvim", "folke/trouble.nvim"},
  lazy = true,
  config = conf.todo
})

package({ url = 'https://git.sr.ht/~whynothugo/lsp_lines.nvim', config = conf.lsp_lines, lazy = true })

package({ 'L3MON4D3/LuaSnip', event = 'InsertCharPre', config = conf.lua_snip })

package({ 'windwp/nvim-autopairs', event = 'InsertEnter', config = conf.auto_pairs })

package({ 'mfussenegger/nvim-jdtls', ft = 'java' })

package({ 'dnlhc/glance.nvim', after = 'nvim-lspconfig', event = 'BufRead', config = conf.glance })
