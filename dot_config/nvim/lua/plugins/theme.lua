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
		"scottmckendry/cyberdream.nvim",
		lazy = true,
		opts = { transparent = true },
	},
	{
		"lunarvim/synthwave84.nvim",
		lazy = true,
		-- No transparency option: clear the editor backgrounds once it has loaded.
		init = function()
			vim.api.nvim_create_autocmd("ColorScheme", {
				pattern = "synthwave84",
				callback = function()
					for _, group in ipairs({ "Normal", "NormalNC", "SignColumn", "EndOfBuffer", "LineNr", "FoldColumn" }) do
						local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
						hl.bg = nil
						vim.api.nvim_set_hl(0, group, hl)
					end
					-- Snacks dims hidden/ignored paths and LSP inlay hints link NonText, which this scheme
					-- sets to its own background colour; Comment keeps them dimmed but readable.
					for _, group in ipairs({ "SnacksPickerPathHidden", "SnacksPickerPathIgnored", "SnacksPickerGitStatusIgnored", "LspInlayHint" }) do
						vim.api.nvim_set_hl(0, group, { link = "Comment" })
					end
				end,
			})
		end,
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		lazy = true,
		opts = { styles = { transparency = true } },
	},
	{
		"neanias/everforest-nvim",
		main = "everforest",
		lazy = true,
		opts = { transparent_background_level = 1 },
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
