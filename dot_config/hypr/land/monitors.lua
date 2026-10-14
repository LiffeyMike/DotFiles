-- Monitor layout. Externals are matched by desc: because DP-N names
-- can shift between dock replugs; get descriptions from `hyprctl monitors`.

local MIDDLE = "desc:Microstep MSI MAG 27C6X CE0M035805785"
local RIGHT = "desc:Dell Inc. DELL U2419H 8M8RT83"

local power = require("land.power")

-- Laptop panel, far left. 144Hz on AC, 60Hz on battery (see land/power.lua).
hl.monitor({
	output = "eDP-1",
	mode = power.on_battery and "1920x1080@60" or "1920x1080@144",
	position = "0x0",
	scale = 1,
})

-- MSI MAG 27C6X: landscape at ~120Hz, center, right of the laptop.
-- Custom CVT-RB modeline instead of the standard 1080p@120: the stock mode is a
-- CTA-861 (TV) timing, and i915's "Broadcast RGB: Automatic" sends limited RGB
-- range (washed-out colors) for TV timings. A non-CTA modeline gets full range.
hl.monitor({
	output = MIDDLE,
	mode = "modeline 285.25 1920 1968 2000 2080 1080 1083 1088 1144 +hsync -vsync",
	position = "1920x0",
	scale = 1,
})

-- Dell U2419H: portrait (transform 1 = 90° clockwise), rightmost.
-- Rotated it is 1080 wide x 1920 tall.
hl.monitor({
	output = RIGHT,
	mode = "1920x1080@60",
	position = "3840x0",
	transform = 1,
	scale = 1,
})

-- Catch-all for anything else that gets plugged in.
hl.monitor({
	output = "",
	mode = "preferred",
	position = "auto",
	scale = 1,
})

-- Workspace homes, all persistent. Rules only apply when a workspace is created,
-- so a workspace that fell back to the laptop while its monitor was unplugged
-- (or the dock dropped) would stay there; the monitor.added hook below moves
-- every workspace back home when its monitor returns.
local LAPTOP = "eDP-1"
local HOMES = {
	["1"] = LAPTOP,
	["2"] = MIDDLE,
	["3"] = MIDDLE,
	["4"] = MIDDLE,
	["5"] = MIDDLE,
	["6"] = RIGHT,
	["7"] = RIGHT,
	["8"] = RIGHT,
	["9"] = RIGHT,
	["10"] = LAPTOP,
}

for ws, mon in pairs(HOMES) do
	hl.workspace_rule({ workspace = ws, monitor = mon, persistent = true })
end

-- Map a selector ("eDP-1" or "desc:...") to the connected output's name.
local function output_for(selector)
	for _, m in ipairs(hl.get_monitors()) do
		if selector == m.name or selector == "desc:" .. m.description then
			return m.name
		end
	end
end

hl.on("monitor.added", function()
	for _, w in ipairs(hl.get_workspaces()) do
		local home = HOMES[tostring(w.id)]
		local target = home and output_for(home)
		if target and (not w.monitor or w.monitor.name ~= target) then
			hl.dispatch(hl.dsp.workspace.move({ workspace = tostring(w.id), monitor = target }))
		end
	end
end)

