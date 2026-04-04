return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")
		local js_filetypes = {
			javascript = true,
			typescript = true,
			javascriptreact = true,
			typescriptreact = true,
		}
		local biome_config_files = {
			"biome.json",
			"biome.jsonc",
		}
		local eslint_config_files = {
			"eslint.config.js",
			"eslint.config.cjs",
			"eslint.config.mjs",
			"eslint.config.ts",
			"eslint.config.cts",
			"eslint.config.mts",
			".eslintrc",
			".eslintrc.js",
			".eslintrc.cjs",
			".eslintrc.json",
			".eslintrc.yaml",
			".eslintrc.yml",
		}

		-- Configure eslint_d to support flat config (eslint.config.js)
		lint.linters.eslint_d.args = {
			"--no-warn-ignored",
			"--format",
			"json",
			"--stdin",
			"--stdin-filename",
			function()
				return vim.api.nvim_buf_get_name(0)
			end,
		}

		local function biome_available()
			local cmd = lint.linters.biomejs.cmd
			local resolved_cmd = type(cmd) == "function" and cmd() or cmd

			return resolved_cmd ~= nil and vim.fn.executable(resolved_cmd) == 1
		end

		local function has_project_file(bufnr, names)
			local path = vim.api.nvim_buf_get_name(bufnr)
			if path == "" then
				return false
			end

			local root = vim.fs.dirname(path)
			return vim.fs.find(names, { path = root, upward = true })[1] ~= nil
		end

		local function select_js_linter(bufnr)
			if biome_available() and has_project_file(bufnr, biome_config_files) then
				return "biomejs"
			end

			if has_project_file(bufnr, eslint_config_files) then
				return "eslint_d"
			end
		end

		local function lint_current_buffer()
			if js_filetypes[vim.bo.filetype] then
				local linter = select_js_linter(0)
				if linter then
					lint.try_lint(linter)
				end
				return
			end

			lint.try_lint()
		end

		lint.linters_by_ft = {
			svelte = { "eslint_d" },
			python = { "pylint" },
		}

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = lint_current_buffer,
		})

		vim.keymap.set("n", "<leader>l", function()
			lint_current_buffer()
		end, { desc = "Trigger linting for current file" })
	end,
}
