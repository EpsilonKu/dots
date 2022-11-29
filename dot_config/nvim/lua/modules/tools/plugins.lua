local package = require('core.pack').package
local conf = require('modules.tools.config')

package({
  'kristijanhusak/vim-dadbod-ui',
  cmd = { 'DBUIToggle', 'DBUIAddConnection', 'DBUI', 'DBUIFindBuffer', 'DBUIRenameBuffer' },
  config = conf.vim_dadbod_ui,
  requires = { { 'tpope/vim-dadbod', opt = true } },
})

package({
  'editorconfig/editorconfig-vim',
  ft = { 'go', 'typescript', 'javascript', 'vim', 'rust', 'zig', 'c', 'cpp' },
})
package({
  'folke/which-key.nvim',
  config = conf.which_key
})
package({
  'rmagatti/auto-session',
  config = conf.auto_session
})
package({
  'numToStr/Comment.nvim',
  config = conf.comment
})
package({
  'gbprod/cutlass.nvim',
  config = conf.cutlass
})
package({
  'numToStr/Navigator.nvim',
  config = conf.navigator
})
package({
  'folke/noice.nvim',
  config = conf.noice,
  -- event = "VmEnter",
  requires = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  module = {
    "nui.nvim",
    "nvim-notify"
  }
})

package({
  'CRAG666/code_runner.nvim',
  config = conf.code_runner
})
package({
  'xeluxee/competitest.nvim',
  config = conf.competitest
})
