# ------------------------------------------------------------------
# .zshenv - loaded each and every time
# ------------------------------------------------------------------

# Dotfiles path
export DOTFILES="$HOME/.dotfiles"

# Themes (onedark or nord)
export TMUX_THEME="nord"
export NVIM_THEME="nord"
export STARSHIP_THEME="nord"
export WEZTERM_THEME="catppuccin"

# Locale settings
export LANG="en_US.UTF-8" # Sets default locale for all categories
export LC_ALL="en_US.UTF-8" # Overrides all other locale settings
export LC_CTYPE="en_US.UTF-8" # Controls character classification and case conversion

# XDG Base Directory Specification
export XDG_CONFIG_HOME="$HOME/.config"         # Config files
export XDG_CACHE_HOME="$HOME/.cache"           # Cache files
export XDG_DATA_HOME="$HOME/.local/share"      # Application data
export XDG_STATE_HOME="$HOME/.local/state"     # Logs and state files

# Editor
export EDITOR="nvim"
export VISUAL="nvim"

# Java needs to always keep the environment variable current
export JAVA_HOME=$(/usr/libexec/java_home)

# iTerm2 tmux shell integration
export ITERM_ENABLE_SHELL_INTEGRATION_WITH_TMUX=YES

# Homebrew
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_PREFIX=$($DOTFILES/bin/is-supported $DOTFILES/bin/is-arm64 /opt/homebrew /usr/local)

# Node manager
export NVM_DIR="$HOME/.nvm"

# Python Shims
export PYENV_ROOT=$($HOMEBREW_PREFIX/bin/pyenv root)

# Java Manager
export SDKMAN_DIR="$HOME/.sdkman"

# Starship
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"

# Plugin: zoxide
# Custom options to pass to fzf during interactive selection
export _ZO_FZF_OPTS="$FZF_DEFAULT_OPTS --select-1 --exit-0"

# Set LDFLAGS environment variable for the linker to use the specified directories for library files.
# This is useful when building software that depends on non-standard library locations, like zlib and bzip2 in this case.
export LDFLAGS="-L/usr/local/opt/zlib/lib -L/usr/local/opt/bzip2/lib"

# Set CPPFLAGS environment variable for the C/C++ preprocessor to use the specified directories for header files.
# This is useful when building software that depends on non-standard header locations, like zlib and bzip2 in this case.
export CPPFLAGS="-I/usr/local/opt/zlib/include -I/usr/local/opt/bzip2/include"

# Local config
[[ -f ~/.zshenv.local ]] && source ~/.zshenv.local
