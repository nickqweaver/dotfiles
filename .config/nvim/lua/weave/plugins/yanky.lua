return {
	"gbprod/yanky.nvim",
	dependencies = {
		"folke/snacks.nvim",
	},
	opts = {
		highlight = {
			on_put = true,
			on_yank = true,
			timer = 200,
		},
		preserve_cursor_position = {
			enabled = true,
		},
	},
	keys = {
		{ "y", "<Plug>(YankyYank)", mode = { "n", "x" }, desc = "Yank text" },
		{ "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" }, desc = "Put after" },
		{ "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" }, desc = "Put before" },
		{ "gp", "<Plug>(YankyGPutAfter)", mode = { "n", "x" }, desc = "Put after cursor" },
		{ "gP", "<Plug>(YankyGPutBefore)", mode = { "n", "x" }, desc = "Put before cursor" },
		{ "<C-p>", "<Plug>(YankyPreviousEntry)", desc = "Previous yank history" },
		{ "<C-n>", "<Plug>(YankyNextEntry)", desc = "Next yank history" },
		{ "]p", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put indented after" },
		{ "[p", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put indented before" },
		{ "]P", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put indented after" },
		{ "[P", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put indented before" },
		{
			"<leader>yy",
			function()
				Snacks.picker.yanky()
			end,
			mode = { "n", "x" },
			desc = "Yank history",
		},
	},
}
