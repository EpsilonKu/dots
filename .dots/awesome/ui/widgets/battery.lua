local wibox = require("wibox")
local xresources = require("beautiful.xresources")
local timer = require("gears.timer")

-- Create the textbox that will be used to print the battery percentage and initialize it with an empty string
local percentage = ""
-- Create the imagebox that will be used to show battery icon and initialize it
-- with "empty battery" one
-- batteryicon = wibox.widget.imagebox()
-- batteryicon:set_image(theme.widget_bat_empty)
-- Create the timer which will allow to repeat battery status command (every 5 sec)
timer = timer({ timeout = 5 })
-- Initialize the timer and execute the function every 5 seconds
timer:connect_signal("timeout",
  function()

    -- Cut the 'acpi' output, so that it only remains the percentage number;
    -- Put it into the file 'fperc', then put its content into the numeric
    -- variable 'perc'
    local fperc = assert(io.popen("acpi | cut -d' ' -f 4 | cut -d% -f 1", "r"))
    local perc = fperc:read("*number")
    -- Set 'batterywidget' textbox with the percentage
    percentage = perc
    -- Cut the 'acpi' output, so that it only remains the status string (which
    -- Can be " Full", " Charging" or " Discharging"; put it into the file
    -- 'fstatus', then put its content into the variable 'status'
    fstatus = assert(io.popen("acpi | cut -d: -f 2,2 | cut -d, -f 1,1", "r"))
    local status = fstatus:read("*l")

    awesome.emit_signal("signal::battery",
      tonumber(percentage),
      status,
      tonumber("50"),
      tonumber("60"))
    -- if status is " Discharging", set batteryicon imagebox with the proper
    -- icon, depending charge status (0-19, 20-49, 50-79, 80-100). If the
    -- status is different (" Full" or " Charging"), set it with "A/C" icon
    -- Close the files
    fperc:close()
    fstatus:close()
  end
)
-- Start the timer
timer:start()
return percentage
