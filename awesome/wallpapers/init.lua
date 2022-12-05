
local bling = require("modules.bling")
--[[ local awful = require("awful")
awful.screen.connect_for_each_screen(function(s) -- that way the wallpaper is applied to every screen
    bling.module.tiled_wallpaper("x", s, {       -- call the actual function ("x" is the string that will be tiled)
        fg = "#ff0000", -- define the foreground color
        bg = "#00ffff", -- define the background color
        offset_y = 25,  -- set a y offset
        offset_x = 25,  -- set a x offset
        font = "BlexMono",  -- set the font (without the size)
        font_size = 14, -- set the font size
        padding = 100,  -- set padding (default is 100)
        zickzack = true -- rectangular pattern or criss cross
    })
end) ]]
bling.module.wallpaper.setup {
    wallpaper = {"/home/epsku/Pictures/wallpapers/mojave_dynamic_1.jpeg","/home/epsku/Pictures/wallpapers/mojave_dynamic_2.jpeg"},
    change_timer = 1800,background = "#424242"
}
bling.module.wallpaper.setup {
    set_function = bling.module.wallpaper.setters.simple_schedule,
    wallpaper = {
        ["06:22:00"] = "/home/epsku/Pictures/wallpapers/mojave_dynamic_1.jpeg",
        ["12:00:00"] = "/home/epsku/Pictures/wallpapers/mojave_dynamic_2.jpeg",
        ["17:58:00"] = "/home/epsku/Pictures/wallpapers/mojave_dynamic_3.jpeg",
        ["24:00:00"] = "/home/epsku/Pictures/wallpapers/mojave_dynamic_4.jpeg",
    },
    position = "maximized",
}
