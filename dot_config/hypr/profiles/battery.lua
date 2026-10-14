-- On-battery profile, required by hyprland.lua only when land.power says so.
-- The panel refresh drop lives in land/monitors.lua; this trims GPU work.
-- Animations are deliberately left to the theme, on battery too.

hl.config({
	decoration = {
		blur = { enabled = false },
		shadow = { enabled = false },
	},
})
