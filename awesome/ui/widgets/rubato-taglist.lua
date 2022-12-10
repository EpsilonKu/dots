local awful = require("awful")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local gears = require("gears")
local wibox = require("wibox")
local helpers = require("helpers")
local rubato = require("module.rubato")

local taglist_buttons = gears.table.join(
                            awful.button({}, 1, function(t) t:view_only() end),
                            awful.button({modkey}, 1, function(t)
        if client.focus then client.focus:move_to_tag(t) end
    end), awful.button({}, 3, awful.tag.viewtoggle),
                            awful.button({modkey}, 3, function(t)
        if client.focus then client.focus:toggle_tag(t) end
    end), awful.button({}, 4, function(t) awful.tag.viewnext(t.screen) end),
                            awful.button({}, 5, function(t)
        awful.tag.viewprev(t.screen)
    end))

-- Function to update the tags
local update_tags = function(self, c3)
    if c3.selected then
        self:get_children_by_id("indicator_id")[1].bg = beautiful.xcolor6
        self.anim.target = 32
    elseif #c3:clients() == 0 then
        self:get_children_by_id("indicator_id")[1].bg = beautiful.lighter_bg
        self.anim.target = 8
    else
        self:get_children_by_id("indicator_id")[1].bg = beautiful.xcolor4
        self.anim.target = 16
    end
end

local function get_taglist(s)
    local screen_for_taglist = s or awful.screen.focused()

    local taglist = awful.widget.taglist({
        screen = screen_for_taglist,
        filter = awful.widget.taglist.filter.all,
        layout = {spacing = dpi(10), layout = wibox.layout.fixed.horizontal},
        widget_template = {
            valign = "center",
            {
                id = 'indicator_id',
                forced_height = dpi(6),
                shape = helpers.rrect(beautiful.border_radius - 3),
                widget = wibox.container.background
            },
            id = "place_id",
            widget = wibox.container.place,
            create_callback = function(self, c3, _, _)
                self.anim = rubato.timed {
                    intro = 0.1,
                    duration = 0.2,
                    easing = rubato.quadratic,
                    subscribed = function(width)
                        self:get_children_by_id("indicator_id")[1].forced_width =
                            dpi(width)
                    end
                }

                update_tags(self, c3)
            end,
            update_callback = function(self, c3, _, _)
                update_tags(self, c3)
            end
        },
        buttons = taglist_buttons
    })

    return {
        taglist,
        top = dpi(14),
        bottom = dpi(14),
        right = dpi(5),
        left = dpi(5),
        widget = wibox.container.margin
    }
end

return get_taglist
