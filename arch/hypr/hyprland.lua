-- Hyprland config (lua) - Hyprland >= 0.55
-- Reference: https://wiki.hypr.land/Configuring/Start/

local cfg = os.getenv("HOME") .. "/dotfiles/arch/hypr/lua/"
dofile(cfg .. "monitors.lua")
dofile(cfg .. "env.lua")
dofile(cfg .. "autostart.lua")
dofile(cfg .. "appearance.lua")
dofile(cfg .. "input.lua")
dofile(cfg .. "workspaces.lua")
dofile(cfg .. "windowrules.lua")
dofile(cfg .. "keybindings.lua")

-- DMS-generated overrides — loaded last so they always win.
-- Run `hyprctl reload` after DMS updates colors/layout to apply changes.
local dms = os.getenv("HOME") .. "/.config/hypr/dms/"
dofile(dms .. "cursor.lua")
dofile(dms .. "colors.lua")
dofile(dms .. "layout.lua")
dofile(dms .. "windowrules.lua")
