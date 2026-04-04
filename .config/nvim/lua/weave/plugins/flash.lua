return {
	"folke/flash.nvim",
	event = "VeryLazy",
	opts = {},
	keys = {
		{
			"gs",
			mode = { "n", "x", "o" },
			function()
				require("flash").jump()
			end,
			desc = "Flash jump",
		},
		{
			"gS",
			mode = { "n", "x", "o" },
			function()
				require("flash").treesitter()
			end,
			desc = "Flash treesitter",
		},
		{
			"r",
			mode = "o",
			function()
				require("flash").remote()
			end,
			desc = "Remote flash",
		},
		{
			"R",
			mode = { "o", "x" },
			function()
				require("flash").treesitter_search()
			end,
			desc = "Treesitter search",
		},
		{
			"<C-s>",
			mode = "c",
			function()
				require("flash").toggle()
			end,
			desc = "Toggle flash search",
		},
	},
}
