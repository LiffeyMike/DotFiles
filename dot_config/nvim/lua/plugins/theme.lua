return {
	{
		"tokyonight.nvim",
		opts = {
			transparent = true,
			styles = {
				sidebars = "transparent",
				floats = "transparent",
			},
		},
	},
	{
		"baliestri/aura-theme",
		lazy = false,
		priority = 1000,
		--config = function(plugin)
		--	vim.opt.rtp:append(plugin.dir .. "/packages/neovim")
		--	vim.cmd([[colorscheme aura-dark]])
		--end,
	},
	{ "dasupradyumna/midnight.nvim", lazy = false, priority = 1000 },
	{
		"scottmckendry/cyberdream.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			--transparent = true,
			--styles = {
			--	sidebars = "transparent",
			--	floats = "transparent",
			--},
		},
	},
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "cyberdream",
		},
	},
}
