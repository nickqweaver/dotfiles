return {
	"sindrets/diffview.nvim",
	cmd = {
		"DiffviewOpen",
		"DiffviewClose",
		"DiffviewFileHistory",
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	keys = {
		{ "<leader>gv", "<cmd>DiffviewOpen<cr>", desc = "Open diff view" },
		{ "<leader>gf", "<cmd>DiffviewFileHistory %<cr>", desc = "Current file history" },
		{ "<leader>gF", "<cmd>DiffviewFileHistory<cr>", desc = "Branch history" },
		{ "<leader>gq", "<cmd>DiffviewClose<cr>", desc = "Close git diff" },
	},
}
