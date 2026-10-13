-- Power state, read once per config load. scripts/power-watch runs `hyprctl reload`
-- whenever the AC adapter changes, so this is re-evaluated on every plug/unplug.

local M = {}

local f = io.open("/sys/class/power_supply/ACAD/online")
local online = f and f:read("l")
if f then
	f:close()
end

-- Unknown (no adapter node) counts as AC: never throttle a machine we can't read.
M.on_battery = online == "0"

return M
