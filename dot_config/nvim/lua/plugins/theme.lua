-- The colourscheme follows the system theme; see lua/config/systemtheme.lua. Every scheme a
-- theme can name is listed here (lazy-loaded: :colorscheme pulls in the right plugin).
-- Backgrounds are transparent so the terminal's themed opacity shows through.
return {
	{
		"folke/tokyonight.nvim",
		opts = {
			transparent = true,
			styles = { sidebars = "transparent", floats = "transparent" },
		},
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		opts = { transparent_background = true },
	},
	{
		"ellisonleao/gruvbox.nvim",
		lazy = true,
		opts = { transparent_mode = true },
	},
	{
		"gbprod/nord.nvim",
		lazy = true,
		opts = { transparent = true },
	},
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = function()
				local systemtheme = require("config.systemtheme")
				systemtheme.apply()
				systemtheme.watch()
			end,
		},
	},
}
