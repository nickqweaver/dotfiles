return {
	"mason-org/mason.nvim",
	opts = {
		ui = {
			icons = {
				package_installed = "✓",
				package_pending = "➜",
				package_uninstalled = "✗",
			},
		},
	},
	dependencies = {
		"mason-org/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"elixir-editors/vim-elixir",
	},
	config = function(_, opts)
		require("mason").setup(opts)

		require("mason-lspconfig").setup({
			ensure_installed = {
				"vtsls",
				"html",
				"cssls",
				"tailwindcss",
				"svelte",
				"lua_ls",
				"graphql",
				"emmet_ls",
				"prismals",
				"pyright",
				"elixirls",
				"gopls",
			},
			automatic_enable = false,
		})

		require("mason-tool-installer").setup({
			ensure_installed = {
				"biome", -- js/ts formatter and linter
				"prettier", -- prettier formatter
				"stylua", -- lua formatter
				"isort", -- python formatter
				"black", -- python formatter
				"pylint", -- python linter
				"eslint_d", -- js linter
				"gofumpt", -- go formatter
				"goimports-reviser", -- go import organizer
				"golines", -- go line length formatter
			},
		})
	end,
}
