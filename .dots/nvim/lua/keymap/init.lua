require('keymap.remap')
local keymap = require('core.keymap')
local nmap, imap, xmap, tmap = keymap.nmap, keymap.imap, keymap.xmap, keymap.tmap
local silent, noremap, expr, remap = keymap.silent, keymap.noremap, keymap.expr, keymap.remap
local opts = keymap.new_opts
local cmd = keymap.cmd
local home = os.getenv('HOME')
require('keymap.config')

-- imap({
--   -- tab key
--   { '<TAB>', _G.smart_tab, opts(expr, silent, remap) },
--   { '<S-TAB>', _G.smart_shift_tab, opts(expr, silent, remap) },
-- })

nmap({
  -- packer
  { '<Leader>pu', cmd('PackerUpdate'), opts(noremap, silent) },
  { '<Leader>pi', cmd('PackerInstall'), opts(noremap, silent) },
  { '<Leader>pc', cmd('PackerCompile'), opts(noremap, silent) },
  -- Lsp
  { '<Leader>li', cmd('LspInfo'), opts(noremap, silent) },
  { '<Leader>ll', cmd('LspLog'), opts(noremap, silent) },
  { '<Leader>lr', cmd('LspRestart'), opts(noremap, silent) },
  -- Lspsaga
  { '[e', cmd('Lspsaga diagnostic_jump_next'), opts(noremap, silent) },
  { ']e', cmd('Lspsaga diagnostic_jump_prev'), opts(noremap, silent) },
  { 'K', cmd('Lspsaga hover_doc'), opts(silent) },
  { 'ga', cmd('CodeActionMenu'), opts(noremap, silent) },
  { 'gd', cmd('Glance definitions'), opts(noremap, silent) },
  { 'gs', cmd('Glance references'), opts(noremap, silent) },
  { 'gr', cmd('Glance implementations'), opts(noremap, silent) },
  { 'gh', cmd('Glance type_definitions'), opts(noremap, silent) },
  { '<Leader>o', cmd('LSoutlineToggle'), opts(noremap, silent) },
  { '<Leader>g', cmd('Lspsaga open_floaterm lazygit'), opts(noremap, silent) },
  -- dashboard create file
  { '<Leader>n', cmd('DashboardNewFile'), opts(noremap, silent) },
  { '<Leader>ss', cmd('SessionSave'), opts(noremap, silent) },
  { '<Leader>sl', cmd('SessionLoad'), opts(noremap, silent) },
  -- nvimtree
  { '<Leader>e', cmd('Neotree toggle float reveal'), opts(noremap, silent) },
  -- dadbodui
  -- { '<Leader>d', cmd('DBUIToggle'), opts(noremap, silent) },
  -- Telescope
  { '<Leader>b', cmd('Telescope buffers'), opts(noremap, silent) },
  { '<Leader>fa', cmd('Telescope live_grep'), opts(noremap, silent) },
  { '<Leader>fb', cmd('Telescope file_browser'), opts(noremap, silent) },
  { '<Leader>ff', cmd('Telescope find_files'), opts(noremap, silent) },
  { '<Leader>fw', cmd('Telescope grep_string'), opts(noremap, silent) },
  { '<Leader>fh', cmd('Telescope help_tags'), opts(noremap, silent) },
  { '<Leader>gc', cmd('Telescope git_commits'), opts(noremap, silent) },
  { '<Leader>gc', cmd('Telescope dotfiles path' .. home .. '/.dotfiles'), opts(noremap, silent) },
  -- vim-operator-surround
  { 'sa', '<Plug>(operator-surround-append)', opts(noremap, silent) },
  { 'sd', '<Plug>(operator-surround-delete)', opts(noremap, silent) },
  { 'sr', '<Plug>(operator-surround-replace)', opts(noremap, silent) },
})

nmap({ 'gcc', cmd('ComComment'), opts(noremap, silent) })
xmap({ 'gcc', ':ComComment<CR>', opts(noremap, silent) })
nmap({ 'gcj', cmd('ComAnnotation'), opts(noremap, silent) })

-- Lspsaga floaterminal
nmap({ '<A-d>', cmd('Lspsaga open_floaterm'), opts(noremap, silent) })
tmap({ '<A-d>', [[<C-\><C-n>:Lspsaga close_floaterm<CR>]], opts(noremap, silent) })

xmap({ 'ga', cmd('Lspsaga code_action'), opts(noremap, silent) })
