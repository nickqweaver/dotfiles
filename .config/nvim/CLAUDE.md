# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Architecture Overview

This is a Neovim configuration built with the "weave" namespace structure. The configuration uses Lazy.nvim as the plugin manager and follows a modular approach with clear separation of concerns.

### Core Structure
- `init.lua` - Entry point that loads core configuration and plugin manager
- `lua/weave/core/` - Core Neovim configuration (options, keymaps)
- `lua/weave/plugins/` - Plugin configurations organized by functionality
- `lua/weave/plugins/lsp/` - LSP-specific configurations
- `lua/weave/lazy.lua` - Lazy.nvim plugin manager setup

### Key Components

#### Plugin Management
- Uses Lazy.nvim for plugin management with automatic installation
- Plugins are organized in separate files under `lua/weave/plugins/`
- LSP plugins are in their own subdirectory at `lua/weave/plugins/lsp/`
- Plugin checker is enabled but notifications are disabled for a quieter experience

#### LSP Configuration
- Mason is used for LSP server management with automatic installation
- LSP servers are configured dynamically based on installed servers
- Special configurations for: elixirls, svelte, graphql, emmet_ls, lua_ls
- Comprehensive keybindings for LSP functionality (gd, gR, gi, gt, etc.)

#### Key Mappings
- Leader key: `<space>`
- Exit insert mode: `jk`
- Window management: `<leader>s*` (sv, sh, se, sx)
- Tab management: `<leader>t*` (to, tx, tn, tp, tf)
- Telescope: `<leader>f*` (ff, fr, fs, fc, ft)
- LSP: Standard LSP keybindings (gd, gR, gi, gt, K, etc.)

#### Notable Configuration
- 2-space indentation for all files
- Relative line numbers enabled
- System clipboard integration
- No swap files
- Dark background theme
- Cursorline highlighting

## Development Commands

### Testing Configuration
```bash
# Test the configuration by opening Neovim
nvim

# Check for configuration errors
nvim --headless -c "lua print('Config loaded successfully')" -c "qa"
```

### Plugin Management
```bash
# Update plugins (run inside Neovim)
:Lazy update

# Check plugin status
:Lazy

# Install new plugins
:Lazy install
```

### LSP Management
```bash
# Install LSP servers (run inside Neovim)
:Mason

# Check LSP status
:LspInfo

# Restart LSP
:LspRestart
```

## Common Modification Patterns

### Adding New Plugins
1. Create new file in `lua/weave/plugins/` following existing naming convention
2. Return plugin specification table with lazy.nvim format
3. Include configuration, dependencies, and keymaps as needed

### Modifying LSP Servers
- Edit `lua/weave/plugins/lsp/lspconfig.lua`
- Add server-specific configurations in the conditional blocks
- Use mason_lspconfig.get_installed_servers() for dynamic server detection

### Adding Keymaps
- Core keymaps: `lua/weave/core/keymaps.lua`
- Plugin-specific keymaps: Include in respective plugin configuration files
- LSP keymaps: Defined in the LspAttach autocmd in lspconfig.lua

### Modifying Options
- Edit `lua/weave/core/options.lua`
- Use `vim.opt` for setting options
- Follow existing pattern of grouped settings with comments