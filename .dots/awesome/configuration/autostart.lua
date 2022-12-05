-- autostart.lua
-- Autostart Stuff Here
local awful = require("awful")

-- Add apps to autostart here
local autostart_apps = {
	-- "xset -b", -- Disable bell
	-- "blueman-applet", -- Bluetooth Systray Applet
	"nm-applet",
	"blueman-applet",
	"picom",
	-- 'xautolock -time 12 -locker "dm-tool lock"', -- TODO: Auto lock
}

for app = 1, #autostart_apps do
	awful.spawn.single_instance(autostart_apps[app], awful.rules.rules)
end

-- EOF ------------------------------------------------------------------------
