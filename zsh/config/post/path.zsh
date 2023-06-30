# Start with system path
# Retrieve it from getconf, otherwise it's just current $PATH
is-executable getconf && PATH=$($(command -v getconf) PATH)

export HOMEBREW_PREFIX=$($DOTFILES_DIR/bin/is-supported $DOTFILES_DIR/bin/is-arm64 /opt/homebrew /usr/local)

# Prepend new items to path (if directory exists)
prepend-path "/bin"
prepend-path "/usr/bin"
prepend-path "/usr/local/bin"
prepend-path "$HOMEBREW_PREFIX/bin"
prepend-path "$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin"
prepend-path "$HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnubin"
prepend-path "$HOMEBREW_PREFIX/opt/grep/libexec/gnubin"
prepend-path "$HOMEBREW_PREFIX/opt/python/libexec/bin"
prepend-path "$DOTFILES_DIR/bin"
prepend-path "/sbin"
prepend-path "/usr/sbin"

if command $DOTFILES_DIR/bin/is-macos > /dev/null; then
    prepend-path "~/Library/Application Support/JetBrains/Toolbox/scripts"

# Remove duplicates (preserving prepended items)
# Source: http://unix.stackexchange.com/a/40755
PATH=$(echo -n $PATH | awk -v RS=: '{ if (!arr[$0]++) {printf("%s%s",!ln++?"":":",$0)}}')

# Wrap up
export PATH