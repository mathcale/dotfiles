local cfg = os.getenv("HOME") .. "/dotfiles/arch/hypr/lua/"

dofile(cfg .. "monitors.lua")
dofile(cfg .. "env.lua")
dofile(cfg .. "autostart.lua")
dofile(cfg .. "appearance.lua")
dofile(cfg .. "input.lua")
dofile(cfg .. "workspaces.lua")
dofile(cfg .. "windowrules.lua")
dofile(cfg .. "keybindings.lua")

local dms = os.getenv("HOME") .. "/.config/hypr/dms/"

dofile(dms .. "cursor.lua")
dofile(dms .. "colors.lua")
dofile(dms .. "layout.lua")
dofile(dms .. "windowrules.lua")
