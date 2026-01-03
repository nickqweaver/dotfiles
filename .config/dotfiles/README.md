# Dotfiles

Personal configuration files for macOS and Linux, managed via the bare git repository method.

## Contents

- **nvim** - Neovim configuration (Lua, lazy.nvim, mason)
- **ghostty** - Ghostty terminal config
- **opencode** - OpenCode AI agent definitions
- **zsh** - Shell configuration
- **tmux** - Terminal multiplexer config
- **git** - Git configuration

## Setup on a New Machine

### 1. Clone the bare repository

```bash
git clone --bare git@github.com:nickqweaver/dotfiles.git $HOME/.dotfiles
```

### 2. Add the alias to your shell

```bash
alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
```

### 3. Checkout the files

```bash
dotfiles checkout
```

If you get errors about existing files, back them up first:

```bash
dotfiles checkout 2>&1 | grep -E "\s+\." | awk '{print $1}' | xargs -I{} mv {} {}.bak
dotfiles checkout
```

### 4. Configure git to ignore untracked files

```bash
dotfiles config --local status.showUntrackedFiles no
```

### 5. Install dependencies

**Neovim:**
```bash
nvim --headless -c "Lazy install" -c "qa"
# Then open nvim and run :Mason to install LSP servers
```

**OpenCode:**
```bash
cd ~/.config/opencode && bun install
```

## Managing Dotfiles

Use `dotfiles` instead of `git`:

```bash
dotfiles status
dotfiles add <file>
dotfiles commit -m "message"
dotfiles push
```

## Platform Notes

- Works on macOS and Linux
- Neovim config is cross-platform
- Ghostty is macOS/Linux only (not needed on headless servers)
