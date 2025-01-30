# THEME
export ZSH=~/.oh-my-zsh
export TERM="xterm-256color"

source $ZSH/oh-my-zsh.sh

# Starship
eval "$(starship init zsh)"
starship config palette $STARSHIP_THEME