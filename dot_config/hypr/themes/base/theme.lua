-- Border colors, blur, animations. Colours come from the shared chezmoi palette.

local c = require("themes.palette")

hl.config({
	general = {
		col = {
			active_border = { colors = { c.green, c.teal, c.mauve }, angle = 45 },
			inactive_border = c.overlay0,
		},
	},
	decoration = {
		blur = { enabled = true },
	},
	animations = { enabled = true },
})

hl.curve("myBezier", { type = "bezier", points = { { 0.05, 0.9 }, { 0.10, 1.05 } } })
hl.curve("overshot", { type = "bezier", points = { { 0.13, 0.99 }, { 0.29, 1.10 } } })

hl.animation({ leaf = "windows", enabled = true, speed = 3, bezier = "myBezier" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 5, bezier = "myBezier" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 5, bezier = "myBezier" })
hl.animation({ leaf = "border", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "fade", enabled = true, speed = 5, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 4, bezier = "overshot", style = "slidevert" })
