local awful     = require("awful")
local beautiful = require("beautiful")
local gears     = require("gears")
local wibox     = require("wibox")
local cairo     = require("lgi").cairo
local rubato    = require("module.rubato")
local gdebug    = require('gears.debug')
local client    = client
local helpers   = require("helpers")
local icons     = require("icons")
local naughty   = require("naughty")

local output = {}

tag.connect_signal("property::selected", function(t)
  gears.timer
  {
    timeout     = 0.1,
    call_now    = false,
    autostart   = true,
    single_shot = true,
    callback    = function()
      if t.selected == true then
        for _, c in ipairs(t:clients()) do
          c.prev_content = gears.surface.duplicate_surface(c.content)
        end
      end
    end
  }
end)

awful.screen.connect_for_each_screen(function(s)
  s.nyoom = awful.popup {
    widget = wibox.widget.textbox("this is a placeholder widget lmfao"),
    screen = s,
    visible = false,
    ontop = true,
    bg = "#00000000",
  }


end)

function img_draw(c, content, client_list)

  local cr = cairo.Context(content)
  local x, y, w, h = cr:clip_extents()
  local img = cairo.ImageSurface.create(
    cairo.Format.ARGB32,
    w - x,
    h - y
  )
  cr = cairo.Context(img)
  cr:set_source_surface(content, 0, 0)
  cr.operator = cairo.Operator.SOURCE
  cr:paint()

  local img_box = wibox.widget({
    image = gears.surface.load(img),
    resize = true,
    widget = wibox.widget.imagebox,
  })

  local client_box = wibox.widget {
    {
      {
        img_box,
        layout = wibox.layout.fixed.vertical,
      },
      widget = wibox.container.margin,
    },
    forced_height = c.height,
    forced_width = c.width,
    bg = beautiful.bg,
    widget = wibox.container.background
  }

  client_box.point = {
    x = c.x - c.screen.geometry.x,
    y = c.y - c.screen.geometry.y
  }

  client_list:add(client_box)
end

function to_surface(t)
  local client_list = wibox.layout.manual()
  local focus_history = awful.client.focus.history.list
  for i = #focus_history, 1, -1 do
    local c = focus_history[i]

    if not c.minimized and not c.hidden and c.first_tag == t then
      if t.selected then
        img_draw(c, gears.surface(c.content), client_list)
      else
        img_draw(c, gears.surface(c.prev_content), client_list)
      end
    end
  end
  return client_list
end

function switch_tag(i)

  local t1 = awful.screen.focused().selected_tag
  -- local t2 = awful.screen.focused().tags[(t1.index + i + 4) % 5 + 1];
  local t2i = t1.index + i
  if t2i == 7 then t2i = 1
  elseif t2i == 0 then t2i = 6 end
  local t2 = awful.screen.focused().tags[t2i]

  local s = t1.screen

  local transbox, go_to

  if math.min(0, i) == 0 then
    transbox = wibox.widget {
      {
        wibox.widget.imagebox(wibox.widget.draw_to_image_surface(to_surface(t1), s.geometry.width, s.geometry.height),
          false),
        wibox.widget.imagebox(wibox.widget.draw_to_image_surface(to_surface(t2), s.geometry.width, s.geometry.height),
          false),
        layout = wibox.layout.fixed.vertical,
      },
      widget = wibox.container.margin,
      forced_width = s.geometry.width,
      top = 0,
    }
    go_to = -s.geometry.height
  else
    transbox = wibox.widget {
      {
        wibox.widget.imagebox(wibox.widget.draw_to_image_surface(to_surface(t2), s.geometry.width, s.geometry.height),
          false),
        wibox.widget.imagebox(wibox.widget.draw_to_image_surface(to_surface(t1), s.geometry.width, s.geometry.height),
          false),
        layout = wibox.layout.fixed.vertical,
      },
      widget = wibox.container.margin,
      forced_width = s.geometry.width,
      top = -s.geometry.height,
    }
    go_to = 0
  end

  s.nyoom.widget = wibox.container.constraint(transbox, "max", nil, s.geometry.height)
  s.nyoom.visible = true

  local anim = rubato.timed {
    duration = 0.2,
    intro = 0.0,
    rate = 60,
    pos = transbox.top,
    easing = rubato.linear,
    override_dt = true, -- penis
    subscribed = function(pos, time)
      transbox.top = pos
      -- naughty.notify { text = tostring(pos) }
      if time == 0.2 then
        t2:view_only()
        gears.timer {
          timeout     = 0.1,
          call_now    = false,
          autostart   = true,
          single_shot = true,
          callback    = function()
            s.nyoom.visible = false
            -- naughty.notify { text = tostring(pos) }
          end
        }
      end
    end
  }

  awful.tag.viewnone(s)
  anim.target = go_to
end

return { switch_tag = switch_tag, to_surface = to_surface }
