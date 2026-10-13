-- Entry point. Hyprland 0.55+ loads this when present, ignoring hyprland.conf.
-- Mirrors the source order from the old hyprland.conf.

require("land.defaults")          -- constants only (returned table)
require("land.monitors")          -- monitor layout (dock externals matched by desc:)
-- require("land.nvidia")         -- uncomment on NVIDIA

require("themes.base.theme")      -- border colors, blur, animations

require("land.general")           -- autostart, input, gestures, misc
require("land.binds")             -- keybindings
require("land.rules")             -- window rules (all commented for now)

require("profiles.power")         -- swap to "profiles.battery" when unplugged
