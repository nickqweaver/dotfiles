# AGENTS.md

## Build/Test Commands
```bash
# Test configuration
nvim --headless -c "lua print('Config loaded successfully')" -c "qa"

# Plugin management (inside Neovim)
:Lazy update    # Update all plugins
:Lazy install   # Install missing plugins
:Mason          # Manage LSP servers
:LspInfo        # Check LSP status
:checkhealth    # Check Neovim health
```

## Code Style Guidelines

### Lua Conventions
- Use 2-space indentation (no tabs) - `opt.tabstop = 2, opt.shiftwidth = 2`
- Use `local` for all variables when possible
- Use `vim.opt` for options, `vim.keymap` for keymaps
- Use double quotes for strings consistently
- Use snake_case for file names and variables
- Add descriptive comments with `-- comment` style

### File Organization
- Core config: `lua/weave/core/` (options.lua, keymaps.lua, init.lua)
- Plugins: `lua/weave/plugins/` (one file per plugin)
- LSP configs: `lua/weave/plugins/lsp/`
- Return plugin spec tables from plugin files
- Use "weave" namespace throughout

### Error Handling & LSP
- Use `vim.diagnostic` for diagnostics display
- Configure LSP servers via mason-lspconfig automatic installation
- Use telescope for LSP navigation (gd, gR, gi, gt)
- Set up proper capabilities with cmp-nvim-lsp