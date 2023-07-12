# Start with system path
# Retrieve it from getconf, otherwise it's just current $PATH
$DOTFILES/bin/is-executable getconf && PATH=$($(command -v getconf) PATH)

export HOMEBREW_PREFIX=$($DOTFILES/bin/is-supported $DOTFILES/bin/is-arm64 /opt/homebrew /usr/local)
export PYENV_ROOT=$($HOMEBREW_PREFIX/bin/pyenv root)

# Prepend new items to path (if directory exists)
prepend-path "$PYENV_ROOT/shims"
prepend-path "/bin"
prepend-path "/usr/bin"
prepend-path "/usr/local/bin"
prepend-path "$HOMEBREW_PREFIX/bin"
prepend-path "$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin"
prepend-path "$HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnubin"
prepend-path "$HOMEBREW_PREFIX/opt/grep/libexec/gnubin"
prepend-path "$DOTFILES/bin"
prepend-path "/sbin"
prepend-path "/usr/sbin"
prepend-path "$HOME/.local/share/fnm"

$DOTFILES/bin/is-macos && prepend-path "~/Library/Application Support/JetBrains/Toolbox/scripts"

# Remove duplicates (preserving prepended items)
# Source: http://unix.stackexchange.com/a/40755
PATH=$(echo -n $PATH | awk -v RS=: '{ if (!arr[$0]++) {printf("%s%s",!ln++?"":":",$0)}}')

# Wrap up
export PATH