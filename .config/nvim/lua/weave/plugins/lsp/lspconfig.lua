return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"saghen/blink.cmp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},
	config = function()
		local keymap = vim.keymap
		local diagnostic_severity = vim.diagnostic.severity

		local function find_root(path, markers)
			local match = vim.fs.find(markers, { path = path, upward = true })[1]
			return match and vim.fs.dirname(match) or nil
		end

		local function has_graphql_config(path)
			return find_root(path, {
				".graphqlrc",
				".graphqlrc.json",
				".graphqlrc.yml",
				".graphqlrc.yaml",
				".graphqlrc.js",
				".graphqlrc.ts",
				"graphql.config.js",
				"graphql.config.ts",
				"graphql.config.mjs",
				"graphql.config.cjs",
			})
		end

		local function find_tailwind_stylesheet(root_dir)
			if not root_dir then
				return nil
			end

			for _, file in ipairs(vim.fs.find({ "*.css", "*.scss", "*.pcss" }, {
				path = root_dir,
				upward = false,
				type = "file",
				limit = math.huge,
			})) do
				local lines = vim.fn.readfile(file)
				for _, line in ipairs(lines) do
					if line:match('@import%s+["\']tailwindcss["\']') then
						return file
					end
				end
			end

			return nil
		end

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local opts = { buffer = ev.buf, silent = true }

				opts.desc = "Show LSP references"
				keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

				opts.desc = "Go to declaration"
				keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

				opts.desc = "Show LSP definitions"
				keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

				opts.desc = "Show LSP implementations"
				keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

				opts.desc = "Show LSP type definitions"
				keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

				opts.desc = "See available code actions"
				keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

				opts.desc = "Smart rename"
				keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

				opts.desc = "Show buffer diagnostics"
				keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

				opts.desc = "Show line diagnostics"
				keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

				opts.desc = "Go to previous diagnostic"
				keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

				opts.desc = "Go to next diagnostic"
				keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

				opts.desc = "Show documentation for what is under cursor"
				keymap.set("n", "K", vim.lsp.buf.hover, opts)

				opts.desc = "Restart LSP"
				keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
			end,
		})

		local capabilities = require("blink.cmp").get_lsp_capabilities()
		capabilities.workspace = vim.tbl_deep_extend("force", capabilities.workspace or {}, {
			didChangeConfiguration = {
				dynamicRegistration = true,
			},
			didChangeWorkspaceFolders = {
				dynamicRegistration = true,
			},
		})

		vim.diagnostic.config({
			signs = {
				text = {
					[diagnostic_severity.ERROR] = " ",
					[diagnostic_severity.WARN] = " ",
					[diagnostic_severity.HINT] = "󰠠 ",
					[diagnostic_severity.INFO] = " ",
				},
			},
		})

		vim.lsp.handlers["workspace/diagnostic/refresh"] = function()
			return vim.NIL
		end

		local servers = {
			"html",
			"cssls",
			"prismals",
			"pyright",
		}

		for _, server in ipairs(servers) do
			vim.lsp.config(server, {
				capabilities = capabilities,
			})
			vim.lsp.enable(server)
		end

		vim.lsp.config("tailwindcss", {
			capabilities = capabilities,
			before_init = function(_, config)
				config.settings = config.settings or {}
				config.settings.editor = config.settings.editor or {}
				config.settings.editor.tabSize = config.settings.editor.tabSize or vim.lsp.util.get_effective_tabstop()
				config.settings.tailwindCSS = config.settings.tailwindCSS or {}
				config.settings.tailwindCSS.experimental = config.settings.tailwindCSS.experimental or {}
				config.settings.tailwindCSS.experimental.configFile = config.settings.tailwindCSS.experimental.configFile
					or find_tailwind_stylesheet(config.root_dir)
			end,
		})
		vim.lsp.enable("tailwindcss")

		vim.lsp.config("elixirls", {
			capabilities = capabilities,
			settings = {
				elixirLS = {
					dialyzerEnabled = false,
					fetchDeps = false,
				},
			},
		})
		vim.lsp.enable("elixirls")

		vim.lsp.config("svelte", {
			capabilities = capabilities,
			on_attach = function(client)
				vim.api.nvim_create_autocmd("BufWritePost", {
					pattern = { "*.js", "*.ts" },
					callback = function(ctx)
						client.notify("$/onDidChangeTsOrJsFile", {
							uri = vim.uri_from_fname(ctx.match),
						})
					end,
				})
			end,
		})
		vim.lsp.enable("svelte")

		vim.lsp.config("graphql", {
			capabilities = capabilities,
			filetypes = { "graphql", "gql", "typescriptreact", "javascriptreact" },
			root_dir = function(bufnr, on_dir)
				local root = has_graphql_config(vim.api.nvim_buf_get_name(bufnr))
				if root then
					on_dir(root)
				end
			end,
		})
		vim.lsp.enable("graphql")

		vim.lsp.config("emmet_ls", {
			capabilities = capabilities,
			root_dir = function(bufnr, on_dir)
				on_dir(find_root(vim.api.nvim_buf_get_name(bufnr), { "package.json", ".git" }))
			end,
			filetypes = {
				"html",
				"typescriptreact",
				"javascriptreact",
				"css",
				"sass",
				"scss",
				"less",
				"svelte",
			},
		})
		vim.lsp.enable("emmet_ls")

		vim.lsp.config("lua_ls", {
			capabilities = capabilities,
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
					completion = {
						callSnippet = "Replace",
					},
				},
			},
		})
		vim.lsp.enable("lua_ls")

		vim.lsp.config("gopls", {
			capabilities = capabilities,
			settings = {
				gopls = {
					analyses = {
						unusedparams = true,
						shadow = true,
					},
					staticcheck = true,
					gofumpt = true,
					usePlaceholders = true,
					completeUnimported = true,
				},
			},
		})
		vim.lsp.enable("gopls")

		local function vtsls_language_settings()
			return {
				inlayHints = {
					parameterNames = {
						enabled = "all",
						suppressWhenArgumentMatchesName = false,
					},
					parameterTypes = { enabled = true },
					variableTypes = { enabled = true },
					propertyDeclarationTypes = { enabled = true },
					functionLikeReturnTypes = { enabled = true },
					enumMemberValues = { enabled = true },
				},
				preferences = {
					quoteStyle = "auto",
					importModuleSpecifier = "shortest",
					importModuleSpecifierEnding = "auto",
				},
				suggest = {
					enabled = true,
					autoImports = true,
					includeAutomaticOptionalChainCompletions = true,
					includeCompletionsForImportStatements = true,
				},
			}
		end

		vim.lsp.config("vtsls", {
			capabilities = capabilities,
			init_options = {
				hostInfo = "neovim",
			},
			settings = {
				vtsls = {
					autoUseWorkspaceTsdk = true,
				},
				typescript = vtsls_language_settings(),
				javascript = vtsls_language_settings(),
			},
			flags = {
				debounce_text_changes = 150,
			},
		})
		vim.lsp.enable("vtsls")
	end,
}
