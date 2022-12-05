local keymap = require('core.keymap')
local nmap, imap, cmap = keymap.nmap, keymap.imap, keymap.cmap
local silent, noremap = keymap.silent, keymap.noremap
local opts = keymap.new_opts
local cmd = keymap.cmd
local wk = require("which-key")

-- noremal remap
nmap({
  -- close buffer
  { '<C-x>k', cmd('bdelete'), opts(noremap, silent) },
  -- save
  { '<C-s>', cmd('write'), opts(noremap) },
  -- remove trailing white space
  { '<Leader>t', cmd('TrimTrailingWhitespace'), opts(noremap) },
  -- window jump
  -- { '<C-h>', '<C-w>h', opts(noremap) },
  -- { '<C-l>', '<C-w>l', opts(noremap) },
  { '<C-k>', ':bn<CR>', opts(noremap) },
  { '<C-j>', ':bp<CR>', opts(noremap) },
  -- resize window
  { '<A-[>', cmd('vertical resize -5'), opts(noremap, silent) },
  { '<A-]>', cmd('vertical resize +5'), opts(noremap, silent) },
})

-- insertmode remap
imap({
  { '<C-h>', '<left>', opts(noremap) },
  { '<C-l>', '<right>', opts(noremap) },
  { '<C-k>', '<up>', opts(noremap) },
  { '<C-j>', '<down>', opts(noremap) },
  { '<C-s>', '<ESC>:w<CR>', opts(noremap) },
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

-- KeybindingsCompetiTestAdd
vim.keymap.set('n', "<A-h>", '<CMD>NavigatorLeft<CR>')
vim.keymap.set('n', "<A-l>", '<CMD>NavigatorRight<CR>')
vim.keymap.set('n', "<A-k>", '<CMD>NavigatorUp<CR>')
vim.keymap.set('n', "<A-j>", '<CMD>NavigatorDown<CR>')
vim.keymap.set('n', "<A-p>", '<CMD>NavigatorPrevious<CR>')
wk.register({
  d = {
    name = "Debug", -- optional group name
    e = { function()
      require 'dap'.continue()
    end, "Debug run" },
    c = { ":lua require('jdtls').update_project_config()<CR>", "Debug continue" }, -- create a binding with label
    h = { ":JdtHotReplace<CR>" },
    r = { ":lua require'dap'.toggle_breakpoint()<CR>", "Toggle breakpoinst" }, -- additional options for creating the keymap
  },
  c = {
    r = { ":w<CR>:CompetiTestRun<CR>", " Run test" },
    d = { ":CompetiTestDelete<CR>", "﯊ Delete test" },
    e = { ":CompetiTestEdit<CR>", " Edit test" },
    a = { ":CompetiTestAdd<CR>", " Add test" },
    w = { ":w<CR>:RunCode<CR>", " Compile and Run" }
  },
  w = {
    name = "Window",
    d = { function()
      local cBuf = vim.current.buffer;

    end, "Close window" }
  }
}, { prefix = "<Space>" })
