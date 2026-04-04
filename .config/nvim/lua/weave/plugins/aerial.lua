return {
	"stevearc/aerial.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	keys = {
		{ "<leader>o", "<cmd>AerialToggle!<CR>", desc = "Toggle outline" },
		{ "<leader>O", "<cmd>AerialNavToggle<CR>", desc = "Toggle symbol nav" },
	},
	opts = {
		backends = { "treesitter", "lsp", "markdown", "man" },
		layout = {
			default_direction = "prefer_right",
			placement = "window",
			max_width = { 40, 0.2 },
			min_width = 24,
		},
		filter_kind = false,
		show_guides = true,
		close_on_select = true,
		attach_mode = "window",
		lazy_load = true,
	},
}
