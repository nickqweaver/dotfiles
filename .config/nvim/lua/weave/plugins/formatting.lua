return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    local biome_config_files = {
      "biome.json",
      "biome.jsonc",
    }

    local function has_project_file(bufnr, names)
      local path = vim.api.nvim_buf_get_name(bufnr)
      if path == "" then
        return false
      end

      local root = vim.fs.dirname(path)
      return vim.fs.find(names, { path = root, upward = true })[1] ~= nil
    end

    local function biome_or_prettier(bufnr)
      if has_project_file(bufnr, biome_config_files) and conform.get_formatter_info("biome", bufnr).available then
        return { "biome" }
      end

      return { "prettier" }
    end

    conform.setup({
      formatters_by_ft = {
        javascript = biome_or_prettier,
        typescript = biome_or_prettier,
        javascriptreact = biome_or_prettier,
        typescriptreact = biome_or_prettier,
        svelte = { "prettier" },
        css = biome_or_prettier,
        html = biome_or_prettier,
        json = biome_or_prettier,
        yaml = { "prettier" },
        markdown = { "prettier" },
        graphql = biome_or_prettier,
        liquid = { "prettier" },
        lua = { "stylua" },
        python = { "isort", "black" },
        go = { "goimports-reviser", "gofumpt", "golines" },
      },
      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      },
    })

    vim.keymap.set({ "n", "v" }, "<leader>mp", function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      })
    end, { desc = "Format file or range (in visual mode)" })
  end,
}
