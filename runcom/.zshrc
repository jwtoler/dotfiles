# Location of this repository
DOTFILES="$HOME/.dotfiles"

# Load custom executable functions
for function in $DOTFILES/zsh/functions/*; do
  source $function
done

# Extra files in ~/.dotfiles/zsh/config/pre , ~/.dotfiles/zsh/config/ , and ~/.dotfiles/zsh/config/post
# these are loaded first, second, and third, respectively.
_load_settings() {
  _dir="$1"
  if [ -d "$_dir" ]; then
    if [ -d "$_dir/pre" ]; then
      for config in "$_dir"/pre/**/*~*.zwc(N-.); do
        source $config
      done
    fi

    for config in "$_dir"/**/*(N-.); do
      case "$config" in
        "$_dir"/(pre|post)/*|*.zwc)
          :
          ;;
        *)
          source $config
          ;;
      esac
    done

    if [ -d "$_dir/post" ]; then
      for config in "$_dir"/post/**/*~*.zwc(N-.); do
        source $config
      done
    fi
  fi
}
_load_settings "$DOTFILES/zsh/config"

# iTerm Integration
source ~/.iterm2_shell_integration.zsh

# Aliases
[[ -f "$DOTFILES/zsh/.aliases" ]] && source "$DOTFILES/zsh/.aliases"

# Local config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local