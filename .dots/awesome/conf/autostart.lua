-- autostart.lua
-- Autostart Stuff Here
local awful = require("awful")

-- Add apps to autostart here
local autostart_apps = {
    -- "xset -b", -- Disable bell
	"nm-applet",
	-- "blueman-applet",
	"picom --config " .. os.getenv("HOME") .. "/.config/picom/picom.conf --experimental-backends",
}

for app = 1, #autostart_apps do
    awful.spawn.single_instance(autostart_apps[app], awful.rules.rules)
end

-- EOF ------------------------------------------------------------------------
