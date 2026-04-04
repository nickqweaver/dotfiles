return {
	"MeanderingProgrammer/render-markdown.nvim",
	ft = { "markdown" },
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	keys = {
		{ "<leader>mr", "<cmd>RenderMarkdown toggle<CR>", desc = "Toggle markdown render" },
	},
	opts = {
		file_types = { "markdown" },
		completions = {
			lsp = { enabled = true },
		},
	},
}
