-- On-battery profile, required by hyprland.lua only when land.power says so.
-- The panel refresh drop lives in land/monitors.lua; this trims GPU work.

hl.config({
	animations = { enabled = false },
	decoration = {
		blur = { enabled = false },
		shadow = { enabled = false },
	},
})
