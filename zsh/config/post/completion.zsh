# enable completion; use cache if updated within 24h
autoload -Uz compinit

if [[ -n $HOME/.zcompdump(#qN.mh+24) ]]; then
  compinit -d $HOME/.zcompdump;
else
  compinit -C;
fi;

_comp_options+=(globdots)       # Include hidden files.

# disable zsh bundled function mtools command mcd
# which causes a conflict.
compdef -d mcd