-- Gnome apps: extra rounding, no border.
hl.window_rule({
  name = "gnome-rounding",
  match = { class = "^(org\\.gnome\\.)" },
  rounding = 12,
  border_size = 0,
})

-- Tile certain config-style apps.
hl.window_rule({ match = { class = "^(gnome-control-center)$" }, tile = true })
hl.window_rule({ match = { class = "^(pavucontrol)$" }, tile = true })
hl.window_rule({ match = { class = "^(nm-connection-editor)$" }, tile = true })
hl.window_rule({ match = { class = "^(org.pulseaudio.pavucontrol)$" }, tile = true })

-- Float specific apps/dialogs.
hl.window_rule({ match = { class = "^(blueman-manager)$" }, float = true })
hl.window_rule({ match = { class = "^(system-config-printer)$" }, float = true })
hl.window_rule({ match = { class = "^(xsensors)$" }, float = true })
hl.window_rule({ match = { title = "^(Calculator)$" }, float = true })
hl.window_rule({
  match = { class = "^(org.raspberrypi.rpi-imager)$" },
  float = true,
  center = true,
})
hl.window_rule({ match = { class = "^(xdg-desktop-portal)$" }, float = true })

-- Picture-in-Picture: float, sized, pinned, opaque, snapped to bottom-right.
-- Matches both Firefox/Zen (Picture-in-Picture) and Brave (Picture in picture) formats.
hl.window_rule({
  name = "pip",
  match = { title = "^(Picture in picture|Picture-in-Picture)$" },
  float = true,
  size = { "monitor_w*0.25", "monitor_w*0.25*9/16" },
  keep_aspect_ratio = true,
  pin = true,
  opaque = true,
  move = { "monitor_w-window_w-5", "monitor_h-window_h-5" },
})

-- CS2 fullscreen.
hl.window_rule({
  match = { title = "^(Counter-Strike 2)(.*)$" },
  fullscreen = true,
})

-- Dim unfocused floating windows.
hl.window_rule({
  name = "dim-unfocused-floats",
  match = { float = true, focus = false },
  opacity = "0.9 0.9",
})

hl.layer_rule({ match = { namespace = "^(quickshell)$" }, no_anim = true })
