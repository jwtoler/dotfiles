# Start with system path
# Retrieve it from getconf, otherwise it's just current $PATH
$DOTFILES/bin/is-executable getconf && PATH=$($(command -v getconf) PATH)

# Prepend new items to path (if directory exists)
prepend-path "/bin"
prepend-path "/usr/bin"
prepend-path "/usr/local/bin"
prepend-path "$DOTFILES/bin"
prepend-path "$HOMEBREW_PREFIX/bin"
prepend-path "$HOMEBREW_PREFIX/sbin"
prepend-path "$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin"
prepend-path "$HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnubin"
prepend-path "$HOMEBREW_PREFIX/opt/grep/libexec/gnubin"
prepend-path "$HOMEBREW_PREFIX/share/android-commandlinetools"
prepend-path "/usr/local/opt/php@8.2/sbin"
prepend-path "/usr/local/opt/php@8.2/bin"
prepend-path "/sbin"
prepend-path "/usr/sbin"
prepend-path "$HOME/.local/share/fnm"
prepend-path "$HOME/.rd/bin"
prepend-path "$PYENV_ROOT/shims"

$DOTFILES/bin/is-macos && prepend-path "~/Library/Application\ Support/JetBrains/Toolbox/scripts"

# Remove duplicates (preserving prepended items)
# Source: http://unix.stackexchange.com/a/40755
PATH=$(echo -n $PATH | awk -v RS=: '{ if (!arr[$0]++) {printf("%s%s",!ln++?"":":",$0)}}')

# Wrap up
export PATH
