require 'key-menu'.set('n', '<Space>a',
  { desc = 'Flutter', buffer = true })
vim.keymap.set('n', '<Space>ar', '<cmd>FlutterRun<CR>', { desc = 'Flutter Run', buffer = true })
vim.keymap.set('n', '<Space>ad', '<cmd>FlutterDevices<CR>', { desc = 'Flutter Devices', buffer = true })
vim.keymap.set('n', '<Space>ae', '<cmd>FlutterEmulators<CR>', { desc = 'Flutter Emulators', buffer = true })
vim.keymap.set('n', '<Space>aa', '<cmd>FlutterReload<CR>', { desc = 'Flutter Reload', buffer = true })
vim.keymap.set('n', '<Space>as', '<cmd>FlutterRestart<CR>', { desc = 'Flutter Restart', buffer = true })
vim.keymap.set('n', '<Space>ao', '<cmd>FlutterOutlineToggle<CR>', { desc = 'Flutter Outline', buffer = true })
vim.keymap.set('n', '<Space>aq', '<cmd>FlutterQuit<CR>', { desc = 'Flutter Quit', buffer = true })
