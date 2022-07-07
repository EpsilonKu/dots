local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local helpers = require("helpers")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local ruled = require("ruled")
local bling = require("module.bling")
local dpi = xresources.apply_dpi

local art = wibox.widget {
    image = "default_image.png",
    resize = true,
    forced_height = dpi(80),
    forced_width = dpi(80),
    widget = wibox.widget.imagebox
}

local name_widget = wibox.widget {
    markup = 'No players',
    align = 'center',
    valign = 'center',
    widget = wibox.widget.textbox
}

local title_widget = wibox.widget {
    markup = 'Nothing Playing',
    align = 'center',
    valign = 'center',
    widget = wibox.widget.textbox
}

local artist_widget = wibox.widget {
    markup = 'Nothing Playing',
    align = 'center',
    valign = 'center',
    widget = wibox.widget.textbox
}

-- Get Song Info
local playerctl = bling.signal.playerctl.lib()
playerctl:connect_signal("metadata",
                       function(_, title, artist, album_path, album, new, player_name)
    -- Set art widget
    art:set_image(gears.surface.load_uncached(album_path))

    -- Set player name, title and artist widgets
    name_widget:set_markup_silently(player_name)
    title_widget:set_markup_silently(title)
    artist_widget:set_markup_silently(artist)
end)
