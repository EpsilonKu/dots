local awful = require("awful")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local gears = require("gears")
local wibox = require("wibox")
local helpers = require("helpers")

-- local function generate_filter(t)
--     return function(c, scr)
--         local ctags = c:tags()
--         for _, v in ipairs(ctags) do if v == t then return true end end
--         return false
--     end
-- end
--
-- local tasklist_buttons = gears.table.join(
--                              awful.button({}, 1, function(c)
--         if c == client.focus then
--             c.minimized = true
--         else
--             c:emit_signal("request::activate", "tasklist", {raise = true})
--         end
--     end), awful.button({}, 4, function() awful.client.focus.byidx(1) end),
--                              awful.button({}, 5, function()
--         awful.client.focus.byidx(-1)
--     end))
--
-- -- Function to update the tags
-- local update_tags = function(self, c3)
--     local bgbox = self:get_children_by_id('background_role')[1]
--     local taskbox = self:get_children_by_id('tasklist_margin_role')[1]
--
--     if c3.selected then
--         bgbox.visible = true
--         taskbox.right = dpi(12)
--         if #c3:clients() == 0 then
--             taskbox.right = dpi(0)
--         end
--     elseif #c3:clients() == 0 then
--         bgbox.visible = false
--         taskbox.right = dpi(0)
--     else
--         bgbox.visible = true
--         taskbox.right = dpi(12)
--     end
-- end
--
-- local function get_taglist(s)
--     local screen_for_taglist = s or awful.screen.focused()
--
--     local tagsklist = awful.widget.taglist {
--         screen = screen_for_taglist,
--         filter = awful.widget.taglist.filter.all,
--         layout = {spacing = 0, layout = wibox.layout.fixed.horizontal},
--         widget_template = {
--             {
--                 {
--                     {
--                         {
--                             {id = 'text_role', widget = wibox.widget.textbox},
--                             halign = "center",
--                             valign = "center",
--                             widget = wibox.container.place
--                         },
--                         margins = {right = dpi(12), left = dpi(12)},
--                         widget = wibox.container.margin
--                     },
--                     {
--                         {
--                             id = "tasklist_role",
--                             layout = wibox.layout.fixed.horizontal
--                         },
--                         id = "tasklist_margin_role",
--                         widget = wibox.container.margin
--                     },
--                     spacing = dpi(0),
--                     layout = wibox.layout.fixed.horizontal
--                 },
--                 widget = wibox.container.background
--             },
--             id = "background_role",
--             widget = wibox.container.background,
--             create_callback = function(self, c3, index, _)
--                 update_tags(self, c3)
--                 local t = screen_for_taglist.tags[index]
--                 self:get_children_by_id("tasklist_role")[1]:add(awful.widget
--                                                                     .tasklist {
--                     screen = screen_for_taglist,
--                     filter = generate_filter(t),
--                     buttons = tasklist_buttons,
--                     layout = {
--                         spacing = dpi(8),
--                         layout = wibox.layout.fixed.horizontal
--                     },
--                     widget_template = {
--                         {
--                             {
--                                 id = "clienticon",
--                                 widget = awful.widget.clienticon
--                             },
--                             top = dpi(10),
--                             bottom = dpi(10),
--                             widget = wibox.container.margin
--                         },
--                         create_callback = function(self, c, _, _)
--                             self:get_children_by_id("clienticon")[1]:connect_signal(
--                                 'mouse::enter', function()
--                                     awesome.emit_signal(
--                                         "bling::task_preview::visibility",
--                                         screen_for_taglist, true, c)
--                                 end)
--                             self:get_children_by_id("clienticon")[1]:connect_signal(
--                                 'mouse::leave', function()
--                                     awesome.emit_signal(
--                                         "bling::task_preview::visibility",
--                                         screen_for_taglist, false, c)
--                                 end)
--                         end,
--                         layout = wibox.layout.align.horizontal
--                     }
--                 })
--                 self:get_children_by_id("text_role")[1]:connect_signal(
--                     'mouse::enter', function()
--                         if #c3:clients() > 0 then
--                             awesome.emit_signal("bling::tag_preview::update", c3)
--                             awesome.emit_signal(
--                                 "bling::tag_preview::visibility", s, true)
--                         end
--                     end)
--                 self:get_children_by_id("text_role")[1]:connect_signal(
--                     'mouse::leave', function()
--                         awesome.emit_signal("bling::tag_preview::visibility", s,
--                                             false)
--                     end)
--             end,
--             update_callback = function(self, c3, index, objects)
--                 update_tags(self, c3)
--             end
--         }
--     }
--
--     return tagsklist
-- end

local mytaglist = awful.widget.taglist {
  screen          = s,
  filter          = awful.widget.taglist.filter.all,
  style           = {
    shape = gears.shape.powerline
  },
  layout          = {
    spacing        = -12,
    spacing_widget = {
      color  = '#dddddd',
      shape  = gears.shape.powerline,
      widget = wibox.widget.separator,
    },
    layout         = wibox.layout.fixed.horizontal
  },
  widget_template = {
    {
      {
        {
          {
            {
              id     = 'index_role',
              widget = wibox.widget.textbox,
            },
            margins = 4,
            widget  = wibox.container.margin,
          },
          bg     = '#dddddd',
          shape  = gears.shape.circle,
          widget = wibox.container.background,
        },
        {
          {
            id     = 'icon_role',
            widget = wibox.widget.imagebox,
          },
          margins = 2,
          widget  = wibox.container.margin,
        },
        {
          id     = 'text_role',
          widget = wibox.widget.textbox,
        },
        layout = wibox.layout.fixed.horizontal,
      },
      left   = 18,
      right  = 18,
      widget = wibox.container.margin
    },
    id              = 'background_role',
    widget          = wibox.container.background,
    -- Add support for hover colors and an index label
    create_callback = function(self, c3, index, objects) --luacheck: no unused args
      self:get_children_by_id('index_role')[1].markup = '<b> ' .. index .. ' </b>'
      self:connect_signal('mouse::enter', function()

        -- BLING: Only show widget when there are clients in the tag
        if #c3:clients() > 0 then
          -- BLING: Update the widget with the new tag
          awesome.emit_signal("bling::tag_preview::update", c3)
          -- BLING: Show the widget
          awesome.emit_signal("bling::tag_preview::visibility", s, true)
        end

        if self.bg ~= '#ff0000' then
          self.backup     = self.bg
          self.has_backup = true
        end
        self.bg = '#ff0000'
      end)
      self:connect_signal('mouse::leave', function()

        -- BLING: Turn the widget off
        awesome.emit_signal("bling::tag_preview::visibility", s, false)

        if self.has_backup then self.bg = self.backup end
      end)
    end,
    update_callback = function(self, c3, index, objects) --luacheck: no unused args
      self:get_children_by_id('index_role')[1].markup = '<b> ' .. index .. ' </b>'
    end,
  },
  buttons         = taglist_buttons
}
return mytaglist
