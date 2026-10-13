-- Entry point. Hyprland 0.55+ loads this when present, ignoring hyprland.conf.

require("land.defaults")          -- constants only (returned table)
require("land.monitors")          -- monitor layout (dock externals matched by desc:)

-- Theme (colours, gaps, rounding, animations) is rendered by `theme` into ~/.local/state.
-- Loaded under pcall so a missing/broken theme can't take the keybinds down with it.
local theme_file = (os.getenv("XDG_STATE_HOME") or (os.getenv("HOME") .. "/.local/state"))
	.. "/theme/current/hypr.lua"
local theme_ok, theme_err = pcall(dofile, theme_file)

require("land.general")           -- autostart, input, gestures, misc
require("land.binds")             -- keybindings
require("land.rules")             -- window rules

-- Battery saver overrides; scripts/power-watch reloads the config on AC changes.
if require("land.power").on_battery then
	require("profiles.battery")
end

if not theme_ok then
	error("theme not loaded (run `theme refresh`): " .. tostring(theme_err))
end
