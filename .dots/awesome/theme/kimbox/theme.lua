--  _   _
-- | |_| |__   ___ _ __ ___   ___
-- | __| '_ \ / _ \ '_ ` _ \ / _ \
-- | |_| | | |  __/ | | | | |  __/
--  \__|_| |_|\___|_| |_| |_|\___|
local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local xrdb = xresources.get_current_theme()
local gears = require("gears")
local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()
local helpers = require("helpers")

-- Inherit default theme
--
local theme = dofile(themes_path .. "default/theme.lua")
theme.wallpaper = "/etc/nixos/assets/wall.jpg"
theme.icon_theme = "/usr/share/icons/Awaita"

-- Titlebar icon path
--
local icon_path = gfs.get_configuration_dir() .. "icons/"

-- PFP
--
theme.me = gears.surface.load_uncached(gfs.get_configuration_dir() ..
  "images/me.png")

-- Distro Logo
--
theme.distro_logo = gears.surface.load_uncached(
  gfs.get_configuration_dir() .. "images/distro.png")

-- Icons for Notif Center
--
theme.clear_icon = icon_path .. "notif-center/clear.png"
theme.clear_grey_icon = icon_path .. "notif-center/clear_grey.png"
theme.notification_icon = icon_path .. "notif-center/notification.png"
theme.delete_icon = icon_path .. "notif-center/delete.png"
theme.delete_grey_icon = icon_path .. "notif-center/delete_grey.png"

-- Load ~/.Xresources colors and set fallback colors
--
theme.darker_bg = "#39260E"
theme.lighter_bg = "#7F5D38"
theme.xbackground = "#221A02"
theme.xforeground = "#C2A383"
theme.xcolor0 = "#201F1F"
theme.xcolor1 = "#DC3958"
theme.xcolor2 = "#819C3B"
theme.xcolor3 = "#F79A32"
theme.xcolor4 = "#733E8B"
theme.xcolor5 = "#7E5053"
theme.xcolor6 = "#088649"
theme.xcolor7 = "#A89983"
theme.xcolor8 = "#676767"
theme.xcolor9 = "#F14A68"
theme.xcolor10 = "#A3B95A"
theme.xcolor11 = "#F79A32"
theme.xcolor12 = "#DC3958"
theme.xcolor13 = "#FE8019"
theme.xcolor14 = "#4C96A8"
theme.xcolor15 = "#51412C"

-- Fonts
--
theme.font_name = "BlexMono Nerd Font "
theme.font = theme.font_name .. "10"
theme.icon_font_name = "monospace"
theme.icon_font = theme.icon_font_name .. "14"
theme.font_taglist = theme.icon_font_name .. "4"

-- Background Colors
--
theme.bg_dark = theme.xcolor0
theme.bg_normal = theme.xbackground
theme.bg_focus = theme.xcolor0
theme.bg_urgent = theme.xcolor8
theme.bg_minimize = theme.xcolor8

-- Foreground Colors
--
theme.fg_normal = theme.xcolor7
theme.fg_focus = theme.xcolor4
theme.fg_urgent = theme.xcolor3
theme.fg_minimize = theme.xcolor8

theme.button_close = theme.xcolor1

-- Borders
--
theme.border_width = dpi(1)
theme.oof_border_width = dpi(0)
theme.border_normal = theme.darker_bg
theme.border_focus = theme.xcolor4
theme.border_radius = dpi(8)
theme.client_radius = dpi(12)
theme.widget_border_width = dpi(2)
theme.widget_border_color = theme.darker_bg

-- Taglist
--
-- Generate taglist squares:
local taglist_square_size = dpi(0)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
  taglist_square_size, theme.fg_normal)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
  taglist_square_size, theme.fg_normal)
theme.taglist_font = theme.font_taglist
theme.taglist_bg = theme.wibar_bg
theme.taglist_bg_focus = theme.lighter_bg
theme.taglist_fg_focus = theme.xcolor4
theme.taglist_bg_urgent = theme.xcolor1 .. '55'
theme.taglist_fg_urgent = theme.xcolor1
theme.taglist_bg_occupied = theme.wibar_bg
theme.taglist_fg_occupied = theme.xcolor4
theme.taglist_bg_empty = theme.wibar_bg
theme.taglist_fg_empty = theme.lighter_bg
theme.taglist_bg_volatile = transparent
theme.taglist_fg_volatile = theme.xcolor11
theme.taglist_disable_icon = true

theme.taglist_shape_focus = gears.shape.rectangle
theme.taglist_shape_empty = gears.shape.rectangle
theme.taglist_shape = gears.shape.rectangle
theme.taglist_shape_urgent = gears.shape.rectangle
theme.taglist_shape_volatile = gears.shape.rectangle


-- Tasklist
--
theme.tasklist_font = theme.font
theme.tasklist_plain_task_name = true
theme.tasklist_bg_focus = theme.lighter_bg
theme.tasklist_fg_focus = theme.xcolor6
theme.tasklist_bg_minimize = theme.xcolor0 .. 55
theme.tasklist_fg_minimize = theme.xforeground .. 55
theme.tasklist_bg_normal = theme.darker_bg
theme.tasklist_fg_normal = theme.xforeground
theme.tasklist_disable_task_name = false
theme.tasklist_disable_icon = true
theme.tasklist_bg_urgent = theme.xcolor0
theme.tasklist_fg_urgent = theme.xcolor1
theme.tasklist_align = "center"

-- Titlebars
--
theme.titlebar_size = dpi(40)
theme.titlebar_bg_focus = theme.darker_bg
theme.titlebar_bg_normal = theme.darker_bg
theme.titlebar_fg_normal = theme.xforeground .. "80"
theme.titlebar_fg_focus = theme.xforeground

-- Edge snap
--
theme.snap_bg = theme.xcolor15
theme.snap_shape = helpers.rrect(0)

-- Prompts
--
theme.prompt_bg = transparent
theme.prompt_fg = theme.xforeground

-- Tooltips
--
theme.tooltip_bg = theme.darker_bg
theme.tooltip_fg = theme.xforeground
theme.tooltip_font = theme.font_name .. "8"
theme.tooltip_border_width = 0
theme.tooltip_opacity = 1
theme.tooltip_align = "top"

-- Menu
--
theme.menu_font = theme.font
theme.menu_bg_focus = theme.xcolor4 .. 70
theme.menu_fg_focus = theme.xcolor7
theme.menu_bg_normal = theme.xbackground
theme.menu_fg_normal = theme.xcolor7
theme.menu_submenu_icon = gears.filesystem.get_configuration_dir() ..
    "theme/icons/submenu.png"
theme.menu_height = dpi(20)
theme.menu_width = dpi(130)
theme.menu_border_color = theme.xcolor8
theme.menu_border_width = theme.border_width / 2

-- Hotkeys Pop Up
--
theme.hotkeys_font = theme.font
theme.hotkeys_border_color = theme.darker_bg
theme.hotkeys_group_margin = dpi(40)
theme.hotkeys_shape = helpers.rrect(5)

-- Layout List
--
theme.layoutlist_border_color = theme.xcolor8
theme.layoutlist_border_width = theme.border_width
theme.layoutlist_shape_selected = gears.shape.squircle
theme.layoutlist_bg_selected = theme.xcolor8 .. 55

-- Recolor Layout icons:
theme = theme_assets.recolor_layout(theme, theme.xforeground)

-- Gaps
--
theme.useless_gap = dpi(10)
theme.gap_single_client = false

-- Exit Screen
--
theme.exit_screen_fg = theme.xforeground
theme.exit_screen_bg = theme.xcolor0 .. "80"

-- Wibar
--
theme.wibar_height = dpi(38)
theme.wibar_width = dpi(46)
theme.panel_width = dpi(400)
theme.wibar_margin = dpi(15)
theme.wibar_spacing = dpi(15)
theme.wibar_bg = theme.darker_bg
theme.wibar_bg_secondary = theme.xbackground
theme.wibar_position = "top"

-- Systray
--
theme.systray_icon_spacing = dpi(10)
theme.bg_systray = theme.darker_bg
theme.systray_icon_size = dpi(15)
theme.systray_max_rows = 1

-- Collision
--
theme.collision_focus_bg = theme.xcolor8
theme.collision_focus_fg = theme.xcolor6
theme.collision_focus_shape = helpers.rrect(theme.border_radius)
theme.collision_focus_border_width = theme.border_width
theme.collision_focus_border_color = theme.border_normal

theme.collision_focus_bg_center = theme.xcolor8
theme.collision_shape_width = dpi(50)
theme.collision_shape_height = dpi(50)
theme.collision_focus_shape_center = gears.shape.circle

theme.collision_max_bg = theme.xbackground
theme.collision_max_fg = theme.xcolor8
theme.collision_max_shape = helpers.rrect(0)
theme.bg_urgent = theme.xcolor1

theme.collision_resize_width = dpi(20)
theme.collision_resize_shape = theme.collision_focus_shape
theme.collision_resize_border_width = theme.collision_focus_border_width
theme.collision_resize_border_color = theme.collision_focus_border_color
theme.collision_resize_padding = dpi(5)
theme.collision_resize_bg = theme.collision_focus_bg
theme.collision_resize_fg = theme.collision_focus_fg

theme.collision_screen_shape = theme.collision_focus_shape
theme.collision_screen_border_width = theme.collision_focus_border_width
theme.collision_screen_border_color = theme.collision_focus_border_color
theme.collision_screen_padding = dpi(5)
theme.collision_screen_bg = theme.xbackground
theme.collision_screen_fg = theme.xcolor4
theme.collision_screen_bg_focus = theme.xcolor8
theme.collision_screen_fg_focus = theme.xcolor4

-- Tabs
--
theme.mstab_bar_height = dpi(60)
theme.mstab_bar_padding = dpi(0)
theme.mstab_border_radius = dpi(6)
theme.mstab_bar_disable = true
theme.tabbar_disable = true
theme.tabbar_style = "modern"
theme.tabbar_bg_focus = theme.xbackground
theme.tabbar_bg_normal = theme.xcolor0
theme.tabbar_fg_focus = theme.xcolor0
theme.tabbar_fg_normal = theme.xcolor15
theme.tabbar_position = "bottom"
theme.tabbar_AA_radius = 0
theme.tabbar_size = 0
theme.mstab_bar_ontop = true

theme.notification_spacing = 19
theme.notification_border_radius = dpi(6)
theme.notification_border_width = dpi(0)

-- Swallowing
--
theme.dont_swallow_classname_list = {
  "firefox", "gimp", "Google-chrome", "Thunar"
}

-- Calendar
--
theme.calendar_start_sunday = true

-- Layout Machi
--
theme.machi_switcher_border_color = theme.xcolor4
theme.machi_switcher_border_opacity = 0.25
theme.machi_editor_border_color = theme.xcolor1
theme.machi_editor_border_opacity = 0.25
theme.machi_editor_active_opacity = 0.25

-- Tag Preview
--
theme.tag_preview_widget_border_radius = theme.border_radius
theme.tag_preview_client_border_radius = theme.border_radius * 0.75
theme.tag_preview_client_opacity = 0.6
theme.tag_preview_client_bg = theme.xcolor0
theme.tag_preview_client_border_color = theme.darker_bg
theme.tag_preview_client_border_width = theme.widget_border_width
theme.tag_preview_widget_bg = theme.xbackground
theme.tag_preview_widget_border_color = theme.widget_border_color
theme.tag_preview_widget_border_width = theme.widget_border_width * 0
theme.tag_preview_widget_margin = dpi(10)

-- Task Preview
--
theme.task_preview_widget_border_radius = theme.border_radius
theme.task_preview_widget_bg = theme.xbackground
theme.task_preview_widget_border_color = theme.widget_border_color
theme.task_preview_widget_border_width = theme.widget_border_width * 0
theme.task_preview_widget_margin = dpi(15)

theme.fade_duration = 250

-- Control Center
--
theme.control_center_widget_bg = theme.xbackground
theme.control_center_button_bg = theme.lighter_bg
theme.control_center_widget_radius = theme.border_radius
theme.accent = theme.xcolor8
theme.hover_effect = theme.xcolor0

-- window switcher
theme.window_switcher_widget_bg = theme.exit_screen_bg -- The bg color of the widget
theme.window_switcher_widget_border_width = theme.border_width -- The border width of the widget
theme.window_switcher_widget_border_radius = theme.widget_border_radius -- The border radius of the widget
theme.window_switcher_widget_border_color = theme.xbg -- The border color of the widget
theme.window_switcher_clients_spacing = 15 -- The space between each client item
theme.window_switcher_client_icon_horizontal_spacing = 5 -- The space between client icon and text
theme.window_switcher_client_width = 150 -- The width of one client widget
theme.window_switcher_client_height = 250 -- The height of one client widget
theme.window_switcher_client_margins = 20 -- The margin between the content and the border of the widget
theme.window_switcher_thumbnail_margins = 10 -- The margin between one client thumbnail and the rest of the widget
theme.thumbnail_scale = false -- If set to true, the thumbnails fit policy will be set to "fit" instead of "auto"
theme.window_switcher_name_margins = 10 -- The margin of one clients title to the rest of the widget
theme.window_switcher_name_valign = "center" -- How to vertically align one clients title
theme.window_switcher_name_forced_width = 200 -- The width of one title
theme.window_switcher_name_font = "Sans 11" -- The font of all titles
theme.window_switcher_name_normal_color = theme.xfg -- The color of one title if the client is unfocused
theme.window_switcher_name_focus_color = theme.xcolor1 -- The color of one title if the client is focused
theme.window_switcher_icon_valign = "center" -- How to vertially align the one icon
theme.window_switcher_icon_width = 40 -- Thw width of one icon

-- Snip for screenshot
theme.screenshot_frame_color = theme.xcolor6

theme.btnsize = 16
theme.iconsize = 20

return theme
