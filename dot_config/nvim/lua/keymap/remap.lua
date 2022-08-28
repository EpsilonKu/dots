local keymap = require('core.keymap')
local nmap = keymap.nmap
local silent, noremap = keymap.silent, keymap.noremap
local opts = keymap.new_opts
local cmd = keymap.cmd

-- noremal remap
nmap({
  -- close buffer
  { '<C-x>k', cmd('bdelete'), opts(noremap, silent) },
  -- save
  { '<C-s>', cmd('write'), opts(noremap) },
  -- yank
  { 'Y', 'y$', opts(noremap) },
  -- buffer jump
  { ']b', cmd('bp'), opts(noremap) },
  { '[b', cmd('bp'), opts(noremap) },
  -- remove trailing white space
  -- { '<Leader>t', cmd('TrimTrailingWhitespace'), opts(noremap) },
  -- window jump
  { '<C-h>', '<C-w>h', opts(noremap) },
  { '<C-l>', '<C-w>l', opts(noremap) },
  { '<C-j>', '<C-w>j', opts(noremap) },
  { '<C-k>', '<C-w>k', opts(noremap) },
  -- resize window
  { '<A-[>', cmd('vertical resize -5'), opts(noremap, silent) },
  { '<A-]>', cmd('vertical resize +5'), opts(noremap, silent) },
})

vim.keymap.set('n', '<Space>ff', '<Cmd>Telescope find_files<CR>', { desc = 'Telescope find files' })
vim.keymap.set('n', '<Space>fa', '<Cmd>Telescope live_grep<CR>', { desc = 'Telescope live grep' })
vim.keymap.set('n', '<Space>fb', '<Cmd>Telescope buffers<CR>', { desc = 'Telescope buffers' })

vim.keymap.set('n', '<Space>pu', '<Cmd>PackerUpdate<CR>', { desc = 'Packer Update' })
vim.keymap.set('n', '<Space>pi', '<Cmd>PackerInstall<CR>', { desc = 'Packer Install' })
vim.keymap.set('n', '<Space>pc', '<Cmd>PackerCompile<CR>', { desc = 'Packer Compile' })

vim.keymap.set('n', '<Space>ss', '<Cmd>SessionSave<CR>', { desc = 'Session Save' })
vim.keymap.set('n', '<Space>sl', '<Cmd>SessionLoad<CR>', { desc = 'Session Load' })

vim.keymap.set('n', '<Space>te', '<Cmd>Neotree float toggle<CR>', { desc = 'Tree toggle' })
vim.keymap.set('n', '<Space>td', '<Cmd>Neotree diagnostics bottom toggle<CR>', { desc = 'Diagnostics toggle' })

vim.keymap.set('n', '<Space>sw', '<Cmd>w<CR>', { desc = 'Save' })
vim.keymap.set('n', '<Space>sq', '<Cmd>q<CR>', { desc = 'Quit' })

vim.keymap.set('n', '<Space>j', '<Cmd>bp<CR>', { desc = 'Buffer next' })
vim.keymap.set('n', '<Space>k', '<Cmd>bn<CR>', { desc = 'Buffer prev' })
vim.keymap.set('n', '<Space>bd', '<Cmd>bd<CR>', { desc = 'Buffer delete' })

vim.keymap.set('v', '<C-c>', '<Plug>(comment_toggle_linewise_visual)', { desc = 'Comment toggle' })

-- Dap
vim.keymap.set('n', '<Space>ds', '<Cmd>lua require"dap".step_over()<CR>', { desc = '  Step Over' })
vim.keymap.set('n', '<Space>dd', '<Cmd>lua require"dap".step_into()<CR>', { desc = '  Step Into' })
vim.keymap.set('n', '<Space>do', '<Cmd>lua require"dap".step_out()<CR>', { desc = '  Step Out' })
vim.keymap.set('n', '<Space>dc', '<Cmd>lua require"dap".continue()<CR>', { desc = '  Continue' })
vim.keymap.set('n', '<Space>dd', '<Cmd>lua require"dap".close()<CR>', { desc = ' 栗Stop Process' })

-- Lsp saga
vim.keymap.set('n', '<Space>la', '<Cmd>Lspsaga code_action<CR>', { desc = ' Code action' })
vim.keymap.set('n', '<Space>lf', '<Cmd>Lspsaga lsp_finder<CR>', { desc = ' Lsp finder' })
vim.keymap.set('n', '<Space>ld', '<Cmd>Lspsaga hover_doc<CR>', { desc = ' Hover doc' })
vim.keymap.set('n', '<Space>lf', '<Cmd>Lspsaga signature_help<CR>', { desc = ' Signature help' })
vim.keymap.set('n', '<Space>lr', '<Cmd>Lspsaga rename<CR>', { desc = ' Rename' })
vim.keymap.set('n', '<Space>lp', '<Cmd>Lspsaga preview_definition<CR>', { desc = ' Preview definition' })
vim.keymap.set('n', '<Space>lt', '<Cmd>LSoutlineToggle<CR>', { desc = ' Outline' })
require('keymap.config')
