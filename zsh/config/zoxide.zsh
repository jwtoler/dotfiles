if is-executable zoxide &>/dev/null; then
  eval "$(zoxide init zsh --no-cmd)"
  ze() {
    DIR=$(zoxide query -i "$@")
    [ -n "$DIR" ] && cd "$DIR" && e .
  }
fi