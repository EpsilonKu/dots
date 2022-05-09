local wibox = require("wibox")

local beautiful = require("beautiful")

local kbdcfg = {}
kbdcfg.layout = {
	{ "us", "" },
	{ "kz", "" }
}
kbdcfg.cmd = "setxkbmap"
kbdcfg.current = 2
kbdcfg.widget = wibox.widget {
    font = beautiful.font ,
    align = "center",
    valign = "center",
    widget = wibox.widget.textbox,
	markup = "<span foreground='" .. beautiful.xcolor12 .. "'>" .. kbdcfg.layout[kbdcfg.current][1] .. "</span>"
}
kbdcfg.switch = function ()
    kbdcfg.current = kbdcfg.current % #(kbdcfg.layout) + 1
    local t = kbdcfg.layout[kbdcfg.current]
    kbdcfg.widget:set_text("" .. t[1] .. "")
    os.execute( kbdcfg.cmd .. " " .. t[1] .. " " .. t[2] )
end

kbdcfg.switch()
return kbdcfg
