return {
	{
		"nvim-lualine/lualine.nvim",
		enabled = false,
	},
	{
		"hrsh7th/nvim-cmp",
		opts = function(_, opts)
			opts.performance = vim.tbl_deep_extend("force", opts.performance or {}, {
				fetching_timeout = 2000, -- default 500ms; jdtls on a 9-module Gradle project needs more headroom
			})
			return opts
		end,
	},
}
