#
# .zshenv - loaded each and every time
#

# Dotfiles path
export DOTFILES="$HOME/.dotfiles"

# Regional settings
export LC_COLLATE=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_MESSAGES=en_US.UTF-8
export LC_MONETARY=en_US.UTF-8
export LC_NUMERIC=en_US.UTF-8
export LC_TIME=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

# XDG Base Directory Specification 
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"

#export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
#export ZSH_CACHE_DIR="$XDG_CACHE_HOME/zsh"

# Java needs to always keep the environment variable current
export JAVA_HOME=$(/usr/libexec/java_home)

# Editor
export EDITOR='nano'
export VISUAL="code"

# Enable colors
export CLICOLOR=1

# Keep showing man page after exit
export MANPAGER='less -X'

# Show password prompt in terminal for GPG
export GPG_TTY=$(tty)

# iTerm2 tmux shell integration
export ITERM_ENABLE_SHELL_INTEGRATION_WITH_TMUX=YES

# Homebrew
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_PREFIX=$($DOTFILES/bin/is-supported $DOTFILES/bin/is-arm64 /opt/homebrew /usr/local)

# Node manager
export NVM_DIR="$HOME/.nvm"

# Python Shims
export PYENV_ROOT=$($HOMEBREW_PREFIX/bin/pyenv root)

# Java Manager
export SDKMAN_DIR="$HOME/.sdkman"

# Local config
[[ -f ~/.zshenv.local ]] && source ~/.zshenv.local
