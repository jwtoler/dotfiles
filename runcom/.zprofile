#
# .zlogin/zprofile - loaded only once at login, after .zshenv
#

if [ -d "/opt/homebrew" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -d "~/.linuxbrew" ]; then
  eval "$(~/.linuxbrew/bin/brew shellenv)"
elif [ -d "/home/linuxbrew" ]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

export PATH

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init.zsh 2>/dev/null || :
