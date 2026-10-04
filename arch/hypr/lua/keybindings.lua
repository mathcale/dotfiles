local mod = "SUPER"

-- Application launchers
hl.bind(mod .. " + RETURN", hl.dsp.exec_cmd("kitty"))
hl.bind(mod .. " + E", hl.dsp.exec_cmd("nautilus"))
hl.bind(mod .. " + B", hl.dsp.exec_cmd("brave"))
hl.bind(mod .. " + space", hl.dsp.exec_cmd("noctalia msg panel-toggle launcher"))
hl.bind(mod .. " + V", hl.dsp.exec_cmd("noctalia msg panel-toggle clipboard"))
-- Noctalia has no process-list panel; Control Center's System tab is the closest equivalent
hl.bind(mod .. " + M", hl.dsp.exec_cmd("noctalia msg panel-toggle control-center system"))
hl.bind(mod .. " + comma", hl.dsp.exec_cmd("noctalia msg settings-toggle"))
hl.bind(mod .. " + N", hl.dsp.exec_cmd("noctalia msg panel-toggle control-center notifications"))
-- DMS notepad has no Noctalia equivalent yet; dropped
hl.bind(mod .. " + Y", hl.dsp.exec_cmd("noctalia msg panel-toggle wallpaper"))
-- DMS's overview isn't in Noctalia; window-switcher is the nearest alt-tab style surface
hl.bind(mod .. " + TAB", hl.dsp.exec_cmd("noctalia msg window-switcher"))

-- Security
hl.bind(mod .. " + CTRL + Q", hl.dsp.exec_cmd("noctalia msg panel-toggle session"))
hl.bind(mod .. " + CTRL + L", hl.dsp.exec_cmd("noctalia msg session lock"))
hl.bind("CTRL + ALT + Delete", hl.dsp.exec_cmd("noctalia msg panel-toggle control-center system"))

-- Audio
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("noctalia msg volume-up 3"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("noctalia msg volume-down 3"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("noctalia msg volume-mute"), { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("noctalia msg mic-mute"), { locked = true })

-- Brightness
hl.bind(
  "XF86MonBrightnessUp",
  hl.dsp.exec_cmd('noctalia msg brightness-up "" 5'),
  { locked = true, repeating = true }
)
hl.bind(
  "XF86MonBrightnessDown",
  hl.dsp.exec_cmd('noctalia msg brightness-down "" 5'),
  { locked = true, repeating = true }
)

-- Window management
hl.bind(mod .. " + Q", hl.dsp.window.close())
hl.bind(mod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
hl.bind(mod .. " + T", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mod .. " + W", hl.dsp.group.toggle())

-- Focus navigation
hl.bind(mod .. " + left", hl.dsp.focus({ direction = "l" }))
hl.bind(mod .. " + down", hl.dsp.focus({ direction = "d" }))
hl.bind(mod .. " + up", hl.dsp.focus({ direction = "u" }))
hl.bind(mod .. " + right", hl.dsp.focus({ direction = "r" }))
hl.bind(mod .. " + H", hl.dsp.focus({ direction = "l" }))
hl.bind(mod .. " + J", hl.dsp.focus({ direction = "d" }))
hl.bind(mod .. " + K", hl.dsp.focus({ direction = "u" }))
hl.bind(mod .. " + L", hl.dsp.focus({ direction = "r" }))

-- Window movement
hl.bind(mod .. " + CTRL + left", hl.dsp.window.move({ direction = "l" }))
hl.bind(mod .. " + CTRL + down", hl.dsp.window.move({ direction = "d" }))
hl.bind(mod .. " + CTRL + up", hl.dsp.window.move({ direction = "u" }))
hl.bind(mod .. " + CTRL + right", hl.dsp.window.move({ direction = "r" }))
hl.bind(mod .. " + CTRL + H", hl.dsp.window.move({ direction = "l" }))
hl.bind(mod .. " + CTRL + J", hl.dsp.window.move({ direction = "d" }))
hl.bind(mod .. " + CTRL + K", hl.dsp.window.move({ direction = "u" }))
hl.bind(mod .. " + CTRL + L", hl.dsp.window.move({ direction = "r" }))

-- Move window to monitor (direction)
hl.bind(mod .. " + SHIFT + CTRL + left", hl.dsp.window.move({ monitor = "l" }))
hl.bind(mod .. " + SHIFT + CTRL + down", hl.dsp.window.move({ monitor = "d" }))
hl.bind(mod .. " + SHIFT + CTRL + up", hl.dsp.window.move({ monitor = "u" }))
hl.bind(mod .. " + SHIFT + CTRL + right", hl.dsp.window.move({ monitor = "r" }))
hl.bind(mod .. " + SHIFT + CTRL + H", hl.dsp.window.move({ monitor = "l" }))
hl.bind(mod .. " + SHIFT + CTRL + J", hl.dsp.window.move({ monitor = "d" }))
hl.bind(mod .. " + SHIFT + CTRL + K", hl.dsp.window.move({ monitor = "u" }))
hl.bind(mod .. " + SHIFT + CTRL + L", hl.dsp.window.move({ monitor = "r" }))

-- Workspace navigation (relative across open workspaces)
hl.bind(mod .. " + Page_Down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mod .. " + Page_Up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mod .. " + U", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mod .. " + I", hl.dsp.focus({ workspace = "e-1" }))

hl.bind(mod .. " + SHIFT + Page_Down", hl.dsp.window.move({ workspace = "e+1" }))
hl.bind(mod .. " + SHIFT + Page_Up", hl.dsp.window.move({ workspace = "e-1" }))
hl.bind(mod .. " + SHIFT + U", hl.dsp.window.move({ workspace = "e+1" }))
hl.bind(mod .. " + SHIFT + I", hl.dsp.window.move({ workspace = "e-1" }))

-- Mouse wheel workspace navigation
hl.bind(mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mod .. " + CTRL + mouse_down", hl.dsp.window.move({ workspace = "e+1" }))
hl.bind(mod .. " + CTRL + mouse_up", hl.dsp.window.move({ workspace = "e-1" }))

-- Numbered workspaces
for i = 1, 10 do
  local key = (i == 10) and "0" or tostring(i)
  hl.bind(mod .. " + " .. key, hl.dsp.focus({ workspace = i }))
  hl.bind(mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Column / split management (dwindle)
hl.bind(mod .. " + bracketleft", hl.dsp.layout("preselect l"))
hl.bind(mod .. " + bracketright", hl.dsp.layout("preselect r"))
hl.bind(mod .. " + R", hl.dsp.layout("togglesplit"))
hl.bind(mod .. " + CTRL + F", hl.dsp.window.fullscreen({ mode = "maximized" }))

-- Mouse drag/resize
hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true, description = "Move window" })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true, description = "Resize window" })
-- PiP corner snap on drag end
hl.bind(
  mod .. " + mouse:272",
  hl.dsp.exec_cmd(os.getenv("HOME") .. "/dotfiles/arch/scripts/pip-snap-corner.sh"),
  { mouse = true, release = true, description = "Snap PiP to corner on drag end" }
)

-- Resize via keyboard (code:20 = -, code:21 = =)
hl.bind(
  mod .. " + code:20",
  hl.dsp.window.resize({ x = -100, y = 0, relative = true }),
  { description = "Expand window left" }
)
hl.bind(
  mod .. " + code:21",
  hl.dsp.window.resize({ x = 100, y = 0, relative = true }),
  { description = "Shrink window left" }
)
hl.bind(mod .. " + SHIFT + right", hl.dsp.window.resize({ x = 100, y = 0, relative = true }))
hl.bind(mod .. " + SHIFT + left", hl.dsp.window.resize({ x = -100, y = 0, relative = true }))
hl.bind(mod .. " + SHIFT + up", hl.dsp.window.resize({ x = 0, y = -100, relative = true }))
hl.bind(mod .. " + SHIFT + down", hl.dsp.window.resize({ x = 0, y = 100, relative = true }))

-- Screenshots
local screenshot = os.getenv("HOME") .. "/.local/bin/screenshot"
hl.bind("XF86Launch1", hl.dsp.exec_cmd(screenshot .. " area"))
hl.bind("CTRL + XF86Launch1", hl.dsp.exec_cmd(screenshot .. " screen"))
hl.bind("ALT + XF86Launch1", hl.dsp.exec_cmd(screenshot .. " active"))
hl.bind("SHIFT + XF86Launch1", hl.dsp.exec_cmd(screenshot .. " area-annotate"))
hl.bind("Print", hl.dsp.exec_cmd(screenshot .. " area"))
hl.bind("CTRL + Print", hl.dsp.exec_cmd(screenshot .. " screen"))
hl.bind("ALT + Print", hl.dsp.exec_cmd(screenshot .. " active"))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd(screenshot .. " area-annotate"))
hl.bind("CTRL + SHIFT + Print", hl.dsp.exec_cmd(screenshot .. " screen-annotate"))
hl.bind("ALT + SHIFT + Print", hl.dsp.exec_cmd(screenshot .. " active-annotate"))

-- DPMS off
hl.bind(mod .. " + SHIFT + P", hl.dsp.dpms({ action = "disable" }))

-- Passthru submap (mod+P enters it; mod+Escape exits)
hl.bind(mod .. " + P", hl.dsp.submap("passthru"))
hl.define_submap("passthru", function()
  hl.bind(mod .. " + Escape", hl.dsp.submap("reset"))
end)
