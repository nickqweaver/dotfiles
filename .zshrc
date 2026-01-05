export ZSH="$HOME/.oh-my-zsh"
export PATH="/opt/homebrew/bin:$PATH"

# Set the theme for Oh My Zsh
ZSH_THEME="bira"

# Enable command auto-correction and completion dots
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

# Set your preferred plugins
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  z
  docker
  npm
  node
  brew
  macos
  web-search
)

# Source Oh My Zsh
source "$ZSH/oh-my-zsh.sh"

# Cargo environment variables (Rust)
[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

# Source .bash_profile if it exists (for any legacy settings)
[ -f "$HOME/.bash_profile" ] && source "$HOME/.bash_profile"

# Node Version Manager (NVM) setup
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# pnpm setup
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# History settings
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY

# Better ls colors
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# Dotfiles management
alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

# Aliases for productivity
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Git aliases
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git pull'
alias gd='git diff'
alias gb='git branch'
alias gco='git checkout'
alias gcb='git checkout -b'
alias glog='git log --oneline --graph --decorate'

# Development aliases
alias serve='python3 -m http.server'
alias myip='curl ipinfo.io/ip'
alias ports='lsof -i -P -n | grep LISTEN'
alias reload='source ~/.zshrc'

# Quick directory navigation
alias dev='cd ~/Development'
alias desk='cd ~/Desktop'
alias docs='cd ~/Documents'
alias dl='cd ~/Downloads'

# Better cat with syntax highlighting (if bat is installed)
command -v bat >/dev/null 2>&1 && alias cat='bat'

# Better find (if fd is installed)
command -v fd >/dev/null 2>&1 && alias find='fd'

# Better grep (if ripgrep is installed)
command -v rg >/dev/null 2>&1 && alias grep='rg'

# AWS SSO aliases
alias ae='aws-sso exec --account=926397971252 --role=SOC-Developer'
alias al='aws-sso login'
alias gi='aws get-caller-identity'

# Auto-completion for common tools
autoload -U compinit && compinit

# Case-insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Colored completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

