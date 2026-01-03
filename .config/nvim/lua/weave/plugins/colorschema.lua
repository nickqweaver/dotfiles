return {
	{
		"EdenEast/nightfox.nvim",
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require("nightfox").setup({
				options = {
					-- Compiled file's destination location
					compile_path = vim.fn.stdpath("cache") .. "/nightfox",
					compile_file_suffix = "_compiled", -- Compiled file suffix
					transparent = false, -- Disable setting background
					terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
					dim_inactive = false, -- Non focused panes set to alternative background
					styles = { -- Style to be applied to different syntax groups
						comments = "italic",
						conditionals = "NONE",
						constants = "NONE",
						functions = "NONE",
						keywords = "italic",
						numbers = "NONE",
						operators = "NONE",
						strings = "NONE",
						types = "NONE",
						variables = "NONE",
					},
					inverse = { -- Inverse highlight for different types
						match_paren = false,
						visual = false,
						search = false,
					},
					modules = { -- List of various plugins and additional options
						-- ...
					},
				},
				palettes = {},
				specs = {},
				groups = {},
			})
			-- Set colorscheme to carbonfox instead of nightfox
			vim.cmd([[colorscheme carbonfox]])
		end,
	},
}
