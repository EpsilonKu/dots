-- autostart.lua
-- Autostart Stuff Here
local awful = require("awful")

-- Add apps to autostart here
local autostart_apps = {
  "xset -b", -- Disable bell
  "blueman-applet", -- Bluetooth Systray Applet
  "nm-applet"
}
nyuu = require("animation.workspace")

for app = 1, #autostart_apps do awful.spawn(autostart_apps[app], false) end

-- EOF ------------------------------------------------------------------------
