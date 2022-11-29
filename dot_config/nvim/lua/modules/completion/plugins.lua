local package = require('core.pack').package
local conf = require('modules.completion.config')

local enable_lsp_filetype = {
  'go',
  'lua',
  'sh',
  'rust',
  'c',
  'cpp',
  'zig',
  'typescript',
  'typescriptreact',
  'json',
  'python',
  'java',
  'html',
}

package({
  'neovim/nvim-lspconfig',
  ft = enable_lsp_filetype,
  config = conf.nvim_lsp,
})

package({ 'glepnir/lspsaga.nvim', after = 'nvim-lspconfig', config = conf.lspsaga })

package({ 'mfussenegger/nvim-dap', after = 'nvim-lspconfig' })

package({ 'rcarriga/nvim-dap-ui', after = 'nvim-dap', config = conf.dap_ui })

package({
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  config = conf.nvim_cmp,
  requires = {
    { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-lspconfig' },
    { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
    { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
    { 'saadparwaiz1/cmp_luasnip', after = 'LuaSnip' },
  },
})
package({
  'folke/trouble.nvim', config = conf.trouble
})
package({
  "folke/todo-comments.nvim",
  requires = "nvim-lua/plenary.nvim",
  config = conf.todo
})

package({ 'https://git.sr.ht/~whynothugo/lsp_lines.nvim', config = conf.lsp_lines })

package({ 'L3MON4D3/LuaSnip', event = 'InsertCharPre', config = conf.lua_snip })

package({ 'windwp/nvim-autopairs', event = 'InsertEnter', config = conf.auto_pairs })

package({ 'mfussenegger/nvim-jdtls', after = 'nvim-dap' })
