local package = require('core.pack').package
local conf = require('modules.ui.config')

package({ 'lmburns/kimbox', config = conf.kimbox })

package({ 'goolord/alpha-nvim', config = conf.alpha })

-- package({
--   'glepnir/galaxyline.nvim',
--   branch = 'main',
--   config = conf.galaxyline,
--   requires = 'kyazdani42/nvim-web-devicons',
-- })
package({
  'windwp/windline.nvim',
  config = conf.windline,
  requires = 'kyazdani42/nvim-web-devicons',
})


local enable_indent_filetype = {
  'lua',
  'cpp',
  'javascript',
  'json',
  'java'
}

package({
  'lukas-reineke/indent-blankline.nvim',
  ft = enable_indent_filetype,
  config = conf.indent_blankline,
})

package({
  'NvChad/nvim-colorizer.lua',
  config = conf.colorizer,
})

-- package({
--   'levouh/tint.nvim',
--   config = conf.tint
-- })

package({
  'nvim-neo-tree/neo-tree.nvim',
  cmd = 'Neotree',
  config = conf.neo_tree,
  requires = {
    "nvim-lua/plenary.nvim",
    "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  }
})

package({
  'lewis6991/gitsigns.nvim',
  event = { 'BufRead', 'BufNewFile' },
  config = conf.gitsigns,
  requires = { 'nvim-lua/plenary.nvim', opt = true },
})

-- package({
--   'akinsho/bufferline.nvim',
--   config = conf.bufferline
-- })
package({
  'nanozuki/tabby.nvim',
  config = conf.tabby
})

-- package({
--   'romgrk/barbar.nvim',
--   config = conf.barbar
-- })
package({
  'tiagovla/scope.nvim',
  config = conf.scope
})

package({
  'TheBlob42/drex.nvim',
  config = conf.drex
})
-- package({
--   'SidOfc/carbon.nvim',
--   config = conf.carbon
-- })
