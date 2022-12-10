local awful = require("awful")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local gears = require("gears")
local wibox = require("wibox")
local helpers = require("helpers")

local function generate_filter(t)
    return function(c, scr)
        local ctags = c:tags()
        for _, v in ipairs(ctags) do if v == t then return true end end
        return false
    end
end

local function get_tasklist(s)
    local screen_for_tasklist = s or awful.screen.focused()

    local tasklist = awful.widget.tasklist {
        screen = screen_for_tasklist,
        filter = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
        layout = {spacing = dpi(10), layout = wibox.layout.fixed.horizontal},
        widget_template = {
            {
                {id = "clienticon", widget = awful.widget.clienticon},
                top = dpi(12),
                bottom = dpi(12),
                widget = wibox.container.margin
            },
            create_callback = function(self, c, _, _)
                self:get_children_by_id("clienticon")[1]:connect_signal(
                    'mouse::enter', function()
                        awesome.emit_signal("bling::task_preview::visibility",
                                            screen_for_tasklist, true, c)
                    end)
                self:get_children_by_id("clienticon")[1]:connect_signal(
                    'mouse::leave', function()
                        awesome.emit_signal("bling::task_preview::visibility",
                                            screen_for_tasklist, false, c)
                    end)
            end,
            layout = wibox.layout.align.horizontal
        }
    }

    return tasklist
end

return get_tasklist
