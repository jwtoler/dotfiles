# ------------------------------------------------------------------
# FZF
# ------------------------------------------------------------------
if type fzf &>/dev/null; then
  source <(fzf --zsh)

  # Settings: fzf
  FZF_DEFAULT_OPTS_ARR=(
    --scheme=history
    --ansi
    --exact
    --no-mouse

    # Reverse order
    --tac
    --layout=reverse

    # Styling
    --height=90%
    --min-height=7
    '--prompt="  "'
    --info=inline-right
    --border=none
    --no-scrollbar
    --no-separator
    --color='bw,fg:white,hl:regular:blue,fg+:regular,hl+:regular:blue,info:black:bold,prompt:black:bold,pointer:black:bold'
  )
  export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS_ARR"

  export FZF_CTRL_R_OPTS="
  --color header:italic
  --height=80%
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --header 'CTRL-Y: Copy command into clipboard, CTRL-/: Toggle line wrapping, CTRL-R: Toggle sorting by relevance'"

  export FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'bat -n --color=always {}'
  --height=80%
  --bind 'ctrl-/:change-preview-window(down|hidden|)'
  --header 'CTRL-/: Toggle preview window position'"

  export FZF_ALT_C_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'tree -C {}'
  --height=80%
  --bind 'ctrl-/:change-preview-window(down|hidden|)'
  --header 'CTRL-/: Toggle preview window position'"
fi