-- Provides:
-- squeal::battery
--      percentage (integer)

local awful = require "awful"

local update_interval = 30

local bat_script = [[sh -c '
  echo "$(cat /sys/class/power_supply/BAT0/capacity)" "$(cat /sys/class/power_supply/BAT0/status)"
']]

awful.widget.watch(bat_script, update_interval, function(_, stdout)
  local capacity = string.sub(stdout, 1, 2)
  local status = string.sub(stdout, 4)
  awesome.emit_signal("squeal::battery", tonumber(capacity), status)
end)
--[[ local upower_widget = require("module.battery_widget")
local battery_listener = upower_widget {
    device_path = '/org/freedesktop/UPower/devices/battery_BAT0',
    instant_update = true
}

battery_listener:connect_signal("upower::update", function(_, device)
    awesome.emit_signal("squeal::battery", device.percentage, device.state)
end) ]]
