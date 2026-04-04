return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
	},
	keys = {
		{
			"<leader>nn",
			function()
				require("noice").cmd("history")
			end,
			desc = "Notification history",
		},
		{
			"<leader>nl",
			function()
				require("noice").cmd("last")
			end,
			desc = "Last notification",
		},
		{
			"<leader>nd",
			function()
				require("noice").cmd("dismiss")
			end,
			desc = "Dismiss notifications",
		},
		{
			"<S-Enter>",
			function()
				require("noice").redirect(vim.fn.getcmdline())
			end,
			mode = "c",
			desc = "Redirect command line",
		},
	},
	opts = {
		lsp = {
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
			},
		},
		presets = {
			bottom_search = true,
			long_message_to_split = true,
			lsp_doc_border = true,
		},
	},
}
