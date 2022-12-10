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
        self:get_children_by_id("indicator_id")[1].bg = beautiful.taglist_fg_focus
        self.anim.target = 32
    elseif #c3:clients() == 0 then
        self:get_children_by_id("indicator_id")[1].bg = beautiful.taglist_fg_empty
        self.anim.target = 8
    else
        self:get_children_by_id("indicator_id")[1].bg = beautiful.taglist_fg_occupied
        self.anim.target = 16
    end
end

local function get_taglist(s)
    local screen_for_taglist = s or awful.screen.focused()

    local taglist = awful.widget.taglist({
        screen = screen_for_taglist,
        filter = awful.widget.taglist.filter.all,
        layout = {spacing = dpi(10), layout = wibox.layout.fixed.vertical},
        widget_template = {
            valign = "center",
            {
                id = 'indicator_id',
                forced_width = dpi(6),
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
                    subscribed = function(height)
                        self:get_children_by_id("indicator_id")[1].forced_height =
                            dpi(height)
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

    return taglist
end

return get_taglist
