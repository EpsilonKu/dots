-- keys.lua
-- Contains Global Keys
local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")
local helpers = require("helpers")
-- Custom modules
local bling = require("module.bling")
local naughty = require("naughty")

local function saved_screenshot(args)
  local ss = awful.screenshot(args)

  local function notify(self)
    naughty.notification {
      title = self.file_name,
      message = "Screenshot saved",
      app_name = "AwesomeWM",
      icon = self.surface,
      icon_size = 128
    }
  end

  if args.auto_save_delay > 0 or args.interactive then
    ss:connect_signal("file::saved", notify)
  else
    notify(ss)
  end

  return ss
end

local function delayed_screenshot(args)
  local ss = saved_screenshot(args)
  local notif = naughty.notification {
    title = "Screenshot in:",
    message = tostring(args.auto_save_delay) .. " seconds"
  }

  ss:connect_signal("timer::tick", function(_, remain)
    notif.message = tostring(remain) .. " seconds"
  end)

  ss:connect_signal("timer::timeout",
    function() if notif then notif:destroy() end end)

  return ss
end

-- Mouse Bindings
awful.mouse.append_global_mousebindings({
  awful.button({}, 4, awful.tag.viewprev),
  awful.button({}, 5, awful.tag.viewnext)
})
-- Client and Tabs Bindings
awful.keyboard.append_global_keybindings({
  awful.key({ "Mod1" }, "a",
    function() bling.module.tabbed.pick_with_dmenu() end,
    { description = "pick client to add to tab group", group = "tabs" }),
  awful.key({ "Mod1" }, "s", function() bling.module.tabbed.iter() end,
    { description = "iterate through tabbing group", group = "tabs" }),
  awful.key({ "Mod1" }, "e", function() bling.module.tabbed.pop() end, {
    description = "remove focused client from tabbing group",
    group = "tabs"
  }),
  awful.key({ modkey, "Shift" }, "Down", function()
    nyuu.switch_tag(1)
  end, { description = "focus down", group = "client" }),
  awful.key({ modkey, "Shift" }, "Up", function()
    nyuu.switch_tag(-1)
  end, { description = "focus down", group = "client" }),
  awful.key({ modkey }, "Down", function()
    awful.client.focus.bydirection("down")
    bling.module.flash_focus.flashfocus(client.focus)
  end, { description = "focus down", group = "client" }),
  awful.key({ modkey }, "Up", function()
    awful.client.focus.bydirection("up")
    bling.module.flash_focus.flashfocus(client.focus)
  end, { description = "focus up", group = "client" }),
  awful.key({ modkey }, "Left", function()
    awful.client.focus.bydirection("left")
    bling.module.flash_focus.flashfocus(client.focus)
  end, { description = "focus left", group = "client" }),
  awful.key({ modkey }, "Right", function()
    awful.client.focus.bydirection("right")
    bling.module.flash_focus.flashfocus(client.focus)
  end, { description = "focus right", group = "client" }),
  awful.key({ modkey }, "h", function() awful.client.focus.byidx(1) end,
    { description = "focus next by index", group = "client" }),
  awful.key({ modkey }, "l", function() awful.client.focus.byidx(-1) end,
    { description = "focus previous by index", group = "client" }),
  awful.key({ modkey }, "j", function() awful.tag.viewnext() end,
    { description = "focus next by index", group = "client" }),
  awful.key({ modkey }, "k", function() awful.tag.viewprev() end,
    { description = "focus previous by index", group = "client" }),
  awful.key({ modkey, "Shift" }, "j", function() awful.client.swap.byidx(1) end,
    { description = "swap with next client by index", group = "client" }),
  awful.key({ modkey, "Shift" }, "k",
    function() awful.client.swap.byidx(-1) end, {
    description = "swap with previous client by index",
    group = "client"
  }), awful.key({ modkey }, "u", awful.client.urgent.jumpto,
    { description = "jump to urgent client", group = "client" }),
  awful.key({ altkey }, "Tab", function()
    awesome.emit_signal("oof::window_switcher::turn_on")
  end, { description = "Window Switcher", group = "client" })
})

-- Awesomewm
awful.keyboard.append_global_keybindings({
  -- Volume control
  awful.key({}, "XF86AudioRaiseVolume",
    function() awful.spawn("pamixer -i 3") end,
    { description = "increase volume", group = "awesome" }),
  awful.key({}, "XF86AudioLowerVolume",
    function() awful.spawn("pamixer -d 3") end,
    { description = "decrease volume", group = "awesome" }),
  awful.key({}, "XF86AudioMute", function() awful.spawn("pamixer -t") end,
    { description = "mute volume", group = "awesome" }), -- Media Control
  awful.key({}, "XF86AudioPlay",
    function() awful.spawn("playerctl play-pause") end,
    { description = "toggle playerctl", group = "awesome" }),
  awful.key({}, "XF86AudioPrev",
    function() awful.spawn("playerctl previous") end,
    { description = "playerctl previous", group = "awesome" }),
  awful.key({}, "XF86AudioNext", function() awful.spawn("playerctl next") end,
    { description = "playerctl next", group = "awesome" }),

  -- Screen Shots/Vids
  awful.key({}, "Print",
    function() saved_screenshot { auto_save_delay = 0 } end,
    { description = "take screenshot", group = "client" }),
  awful.key({ "Shift" }, "Print", function()
    saved_screenshot { auto_save_delay = 0, interactive = true }
  end, { description = "take interactive screenshot", group = "client" }),
  awful.key({ "Control" }, "Print",
    function() delayed_screenshot { auto_save_delay = 5 } end,
    { description = "take screenshot in 5 seconds", group = "client" }),
  awful.key({ "Shift", "Control" }, "Print", function()
    delayed_screenshot { auto_save_delay = 5, interactive = true }
  end, {
    description = "take interactive screenshot in 5 seconds",
    group = "client"
  }), -- Brightness
  awful.key({}, "XF86MonBrightnessUp",
    function() awful.spawn("brightnessctl s +5%") end,
    { description = "increase brightness", group = "awesome" }),
  awful.key({}, "XF86MonBrightnessDown",
    function() awful.spawn("brightnessctl s 5%-") end,
    { description = "decrease brightness", group = "awesome" }),

  -- Awesome stuff
  awful.key({ modkey }, "F1", hotkeys_popup.show_help,
    { description = "show help", group = "awesome" }),
  awful.key({ modkey }, "Escape", awful.tag.history.restore,
    { description = "go back", group = "tag" }),
  awful.key({ modkey }, "x",
    function() require("ui.pop.exitscreen").exit_screen_show() end,
    { description = "show exit screen", group = "awesome" }),
  awful.key({ modkey, "Shift" }, "d",
    function() awesome.emit_signal("panel::open") end,
    { description = "show panel", group = "awesome" }),
  awful.key({ modkey, "Control" }, "r", awesome.restart,
    { description = "reload awesome", group = "awesome" }),
  awful.key({ modkey, "Shift", "Control" }, "q", awesome.quit,
    { description = "quit awesome", group = "awesome" })

})

-- Launcher and screen
awful.keyboard.append_global_keybindings({
  awful.key({ modkey, "Control" }, "j",
    function() awful.screen.focus_relative(1) end,
    { description = "focus the next screen", group = "screen" }),
  awful.key({ modkey, "Control" }, "k",
    function() awful.screen.focus_relative(-1) end,
    { description = "focus the previous screen", group = "screen" }),
  awful.key({ modkey }, "t", function() awful.spawn(terminal) end,
    { description = "open a terminal", group = "launcher" }),
  awful.key({ modkey }, "z", function() require("ui.pop.peek").run() end,
    { description = "peek", group = "client" }),
  awful.key({ modkey }, "f", function() awful.spawn(filemanager) end,
    { description = "open file browser", group = "launcher" }),
  awful.key({ modkey }, "v",
    function() awesome.emit_signal("scratch::chat") end,
    { description = "open chats", group = "scratchpad" }),
  awful.key({ modkey }, "s",
    function() awesome.emit_signal("scratch::teams") end,
    { description = "open teams", group = "scratchpad" }),
  awful.key({ modkey }, "w", function() awful.spawn.with_shell(browser) end,
    { description = "open firefox", group = "launcher" }),

  awful.key({ modkey }, "l", function() awful.tag.incmwfact(0.05) end,
    { description = "increase master width factor", group = "layout" }),
  awful.key({ modkey }, "h", function() awful.tag.incmwfact(-0.05) end,
    { description = "decrease master width factor", group = "layout" }),
  awful.key({ modkey, "Shift" }, "h",
    function() awful.tag.incnmaster(1, nil, true) end, {
    description = "increase the number of master clients",
    group = "layout"
  }), awful.key({ modkey, "Shift" }, "l",
    function() awful.tag.incnmaster(-1, nil, true) end, {
    description = "decrease the number of master clients",
    group = "layout"
  }), awful.key({ modkey, "Control" }, "h",
    function() awful.tag.incncol(1, nil, true) end, {
    description = "increase the number of columns",
    group = "layout"
  }), awful.key({ modkey, "Control" }, "l",
    function() awful.tag.incncol(-1, nil, true) end, {
    description = "decrease the number of columns",
    group = "layout"
  }), awful.key({ modkey }, "space", function() awful.layout.inc(1) end,
    { description = "select next", group = "layout" }),
  awful.key({ modkey, "Shift" }, "space", function() awful.layout.inc(-1) end,
    { description = "select previous", group = "layout" }), -- Set Layout
  awful.key({ modkey, "Control" }, "w",
    function() awful.layout.set(awful.layout.suit.max) end,
    { description = "set max layout", group = "tag" }),
  awful.key({ modkey }, "s",
    function() awful.layout.set(awful.layout.suit.tile) end,
    { description = "set tile layout", group = "tag" }),
  awful.key({ modkey, shift }, "s",
    function() awful.layout.set(awful.layout.suit.floating) end,
    { description = "set floating layout", group = "tag" }),

  awful.key({ modkey, "Control" }, "n", function()
    local c = awful.client.restore()
    -- Focus restored client
    if c then
      c:emit_signal("request::activate", "key.unminimize", { raise = true })
    end
  end, { description = "restore minimized", group = "client" })
})

-- Client management keybinds
client.connect_signal("request::default_keybindings", function()
  awful.keyboard.append_client_keybindings({
    awful.key({ modkey }, "Print", function(c)
      saved_screenshot { auto_save_delay = 0, client = c }
    end, { description = "take client screenshot", group = "client" }),
    awful.key({ modkey, "Shift" }, "Print", function(c)
      saved_screenshot {
        auto_save_delay = 0,
        interactive = true,
        client = c
      }
    end, {
      description = "take interactive client screenshot",
      group = "client"
    }), awful.key({ modkey, "Control" }, "Print", function(c)
      delayed_screenshot { auto_save_delay = 5, client = c }
    end, { description = "take screenshot in 5 seconds", group = "client" }),
    awful.key({ modkey, "Shift", "Control" }, "Print", function(c)
      delayed_screenshot {
        auto_save_delay = 5,
        interactive = true,
        client = c
      }
    end, {
      description = "take interactive screenshot in 5 seconds",
      group = "client"
    }), awful.key({ modkey, "Shift" }, "f", function(c)
      c.fullscreen = not c.fullscreen

      --[[
            if not c.fullscreen then
                c.shape = helpers.rrect(beautiful.border_radius)
            else
                c.shape = require("gears.shape").rectangle
            end
	    --]]

      c:raise()
    end, { description = "toggle fullscreen", group = "client" }),
    awful.key({ modkey, "Shift" }, "q", function(c) c:kill() end,
      { description = "close", group = "client" }),
    awful.key({ modkey, "Control" }, "space", awful.client.floating.toggle,
      { description = "toggle floating", group = "client" }),
    awful.key({ modkey, "Control" }, "Return",
      function(c) c:swap(awful.client.getmaster()) end,
      { description = "move to master", group = "client" }),
    awful.key({ modkey }, "o", function(c) c:move_to_screen() end,
      { description = "move to screen", group = "client" }),
    --  awful.key({ modkey, "Shift"   }, "t",      function (c) c.ontop = not c.ontop            end,
    --            {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey, shift }, "b", function(c)
      c.floating = not c.floating
      c.width = 400
      c.height = 200
      awful.placement.bottom_right(c)
      c.sticky = not c.sticky
    end, { description = "toggle keep on top", group = "client" }),

    awful.key({ modkey }, "n", function(c)
      -- The client currently has the input focus, so it cannot be
      -- minimized, since minimized clients can't have the focus.
      c.minimized = true
    end, { description = "minimize", group = "client" }),
    awful.key({ modkey }, "m", function(c)
      c.maximized = not c.maximized
      c:raise()
    end, { description = "(un)maximize", group = "client" }),
    awful.key({ modkey, "Control" }, "m", function(c)
      c.maximized_vertical = not c.maximized_vertical
      c:raise()
    end, { description = "(un)maximize vertically", group = "client" }),
    awful.key({ modkey, "Shift" }, "m", function(c)
      c.maximized_horizontal = not c.maximized_horizontal
      c:raise()
    end, { description = "(un)maximize horizontally", group = "client" }),

    -- On the fly padding change
    awful.key({ modkey, shift }, "=",
      function() helpers.resize_padding(5) end,
      { description = "add padding", group = "screen" }),
    awful.key({ modkey, shift }, "-",
      function() helpers.resize_padding(-5) end,
      { description = "subtract padding", group = "screen" }),

    -- On the fly useless gaps change
    awful.key({ modkey }, "=", function() helpers.resize_gaps(5) end,
      { description = "add gaps", group = "screen" }),

    awful.key({ modkey }, "-", function() helpers.resize_gaps(-5) end,
      { description = "subtract gaps", group = "screen" }),
    -- Single tap: Center client
    -- Double tap: Center client + Floating + Resize
    awful.key({ modkey }, "c", function(c)
      awful.placement.centered(c, {
        honor_workarea = true,
        honor_padding = true
      })
      helpers.single_double_tap(nil, function()
        helpers.float_and_resize(c, screen_width * 0.25,
          screen_height * 0.28)
      end)
    end)
  })
end)

-- Num row keybinds
awful.keyboard.append_global_keybindings({
  awful.key {
    modifiers = { modkey },
    keygroup = "numrow",
    description = "only view tag",
    group = "tag",
    on_press = function(index)
      local screen = awful.screen.focused()
      local tag = screen.tags[index]
      if tag then tag:view_only() end
    end
  }, awful.key {
    modifiers = { modkey, "Control" },
    keygroup = "numrow",
    description = "toggle tag",
    group = "tag",
    on_press = function(index)
      local screen = awful.screen.focused()
      local tag = screen.tags[index]
      if tag then awful.tag.viewtoggle(tag) end
    end
  }, awful.key {
    modifiers = { modkey, "Shift" },
    keygroup = "numrow",
    description = "move focused client to tag",
    group = "tag",
    on_press = function(index)
      if client.focus then
        local tag = client.focus.screen.tags[index]
        if tag then client.focus:move_to_tag(tag) end
      end
    end
  }, awful.key {
    modifiers = { modkey, "Control", "Shift" },
    keygroup = "numrow",
    description = "toggle focused client on tag",
    group = "tag",
    on_press = function(index)
      if client.focus then
        local tag = client.focus.screen.tags[index]
        if tag then client.focus:toggle_tag(tag) end
      end
    end
  }, awful.key {
    modifiers = { modkey },
    keygroup = "numpad",
    description = "select layout directly",
    group = "layout",
    on_press = function(index)
      local t = awful.screen.focused().selected_tag
      if t then t.layout = t.layouts[index] or t.layout end
    end
  }
})

client.connect_signal("request::default_mousebindings", function()
  awful.mouse.append_client_mousebindings({
    awful.button({}, 1, function(c)
      c:activate { context = "mouse_click" }
    end), awful.button({ modkey }, 1, function(c)
      c:activate { context = "mouse_click", action = "mouse_move" }
    end), awful.button({ modkey }, 3, function(c)
      c:activate { context = "mouse_click", action = "mouse_resize" }
    end)
  })
end)

-- EOF ------------------------------------------------------------------------
