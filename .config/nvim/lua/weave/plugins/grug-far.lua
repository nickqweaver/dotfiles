return {
	"MagicDuck/grug-far.nvim",
	keys = {
		{
			"<leader>sr",
			function()
				require("grug-far").open({ visualSelectionUsage = "auto-detect" })
			end,
			mode = { "n", "x" },
			desc = "Search and replace",
		},
		{
			"<leader>sR",
			function()
				require("grug-far").open({
					prefills = { paths = vim.fn.expand("%") },
				})
			end,
			desc = "Search current file",
		},
	},
	opts = {
		transient = true,
	},
}
