local keymap = require('core.keymap')
local nmap, imap, cmap, tmap = keymap.nmap, keymap.imap, keymap.cmap, keymap.tmap
local silent, noremap = keymap.silent, keymap.noremap
local expr = keymap.expr
local opts = keymap.new_opts
local cmd = keymap.cmd
local wk = require("which-key")

-- noremal remap
nmap({
  -- close buffer
  { '<C-x>k', cmd('bdelete'), opts(noremap, silent) },
  -- save
  { '<C-s>', cmd('write'), opts(noremap) },
  -- yank
  { 'Y', 'y$', opts(noremap) },
  -- buffer jump
  { ']b', cmd('bn'), opts(noremap) },
  { '[b', cmd('bp'), opts(noremap) },
  -- remove trailing white space
  { '<Leader>t', cmd('TrimTrailingWhitespace'), opts(noremap) },
  -- window jump
  { '<C-h>', '<C-w>h', opts(noremap) },
  { '<C-l>', '<C-w>l', opts(noremap) },
  { '<C-j>', ':bn<CR>', opts(noremap) },
  { '<C-k>', ':bp<CR>', opts(noremap) },
  -- resize window
  { '<A-[>', cmd('vertical resize -5'), opts(noremap, silent) },
  { '<A-]>', cmd('vertical resize +5'), opts(noremap, silent) },
})

-- insertmode remap
imap({
  { '<C-w>', '<C-[>diwa', opts(noremap) },
  { '<C-h>', '<Bs>', opts(noremap) },
  { '<C-d>', '<Del>', opts(noremap) },
  { '<C-u>', '<C-G>u<C-u>', opts(noremap) },
  { '<C-b>', '<Left>', opts(noremap) },
  { '<C-f>', '<Right>', opts(noremap) },
  -- { '<C-a>', '<Esc>^i', opts(noremap) },
  -- { '<C-j>', '<Esc>o', opts(noremap) },
  -- { '<C-k>', '<Esc>O', opts(noremap) },
  -- { '<C-s>', '<ESC>:w<CR>', opts(noremap) },
  {
    '<C-e>',
    function()
      return vim.fn.pumvisible() == 1 and '<C-e>' or '<End>'
    end,
    opts(expr),
  },
})

-- commandline remap
cmap({
  { '<C-b>', '<Left>', opts(noremap) },
  { '<C-f>', '<Right>', opts(noremap) },
  { '<C-a>', '<Home>', opts(noremap) },
  { '<C-e>', '<End>', opts(noremap) },
  { '<C-d>', '<Del>', opts(noremap) },
  { '<C-h>', '<BS>', opts(noremap) },
})

-- tmap({ '<Esc>', [[<C-\><C-n>]], opts(silent) })

-- Keybindings
vim.keymap.set('n', "<A-h>", '<CMD>NavigatorLeft<CR>')
vim.keymap.set('n', "<A-l>", '<CMD>NavigatorRight<CR>')
vim.keymap.set('n', "<A-k>", '<CMD>NavigatorUp<CR>')
vim.keymap.set('n', "<A-j>", '<CMD>NavigatorDown<CR>')
vim.keymap.set('n', "<A-p>", '<CMD>NavigatorPrevious<CR>')
wk.register({
  d = {
    name = "Debug", -- optional group name
    e = { ":lua require'dap'.continue()<CR>", "Debug continue" }, -- create a binding with label
    r = { ":lua require'dap'.toggle_breakpoint()", "Toggle breakpoinst" }, -- additional options for creating the keymap
  },
}, { prefix = "<Space>" })