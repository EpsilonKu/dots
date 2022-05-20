local lspsaga = require 'lspsaga'
lspsaga.setup { -- defaults ...
  debug = false,
  use_saga_diagnostic_sign = true,
  -- diagnostic sign
  error_sign = "",
  warn_sign = "",
  hint_sign = "",
  infor_sign = "",
  diagnostic_header_icon = "   ",
  -- code action title icon
  code_action_icon = " ",
  code_action_prompt = {
    enable = true,
    sign = true,
    sign_priority = 40,
    virtual_text = true,
  },
  finder_definition_icon = "  ",
  finder_reference_icon = "  ",
  max_preview_lines = 10,
  finder_action_keys = {
    open = "o",
    vsplit = "s",
    split = "i",
    quit = "q",
    scroll_down = "<C-f>",
    scroll_up = "<C-b>",
  },
  code_action_keys = {
    quit = "<Esc>",
    exec = "<CR>",
  },
  rename_action_keys = {
    quit = "<Esc>",
    exec = "<CR>",
  },
  definition_preview_icon = "  ",
  border_style = "single",
  rename_prompt_prefix = "➤",
  rename_output_qflist = {
    enable = false,
    auto_open_qflist = false,
  },
  server_filetype_map = {},
  diagnostic_prefix_format = "%d. ",
  diagnostic_message_format = "%m %c",
  highlight_prefix = false,
}
_G.auto_hover = true
_G.last_cursor_moved = vim.loop.now()
function AutoHover()
  -- don't bother if mode isn't normal and auto hover is disabled.
  --[[ if vim.fn.mode() ~= "n" or not _G.auto_hover then
    return
  end ]]

  local timer = vim.loop.new_timer()
  local job = function()
    -- if should ignore or mode is no longer normal. ignore
    if vim.loop.now() - last_cursor_moved < 3000 or vim.fn.mode() ~= "n" then
      return
    end
    local hover = require "lspsaga.hover"
    if not hover.has_saga_hover() then
      hover.render_hover_doc()
    end
  end

  -- Start the timer job
  timer:start(3000, 0, vim.schedule_wrap(job))
end

vim.cmd "autocmd CursorMoved <buffer> lua last_cursor_moved = vim.loop.now()"
vim.cmd "autocmd CursorHold <buffer> lua AutoHover()"
