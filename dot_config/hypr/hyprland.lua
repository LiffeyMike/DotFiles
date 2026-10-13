-- Entry point. Hyprland 0.55+ loads this when present, ignoring hyprland.conf.

require("land.defaults")          -- constants only (returned table)
require("land.monitors")          -- monitor layout (dock externals matched by desc:)
-- require("land.nvidia")         -- uncomment on NVIDIA

require("themes.base.theme")      -- border colors, blur, animations (palette from chezmoi)

require("land.general")           -- autostart, input, gestures, misc
require("land.binds")             -- keybindings
require("land.rules")             -- window rules

-- Battery saver overrides; scripts/power-watch reloads the config on AC changes.
if require("land.power").on_battery then
	require("profiles.battery")
end
