# History settings.

HISTFILE="$HOME/.zsh_history"
HISTTIMEFORMAT="%Y/%m/%d %H:%M:%S:"

HISTSIZE=50000                 
SAVEHIST=${HISTSIZE}               

setopt INC_APPEND_HISTORY        # Immediately append commands to history file.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_IGNORE_SPACE         # Ignore commands that start with a space.
setopt HIST_REDUCE_BLANKS        # Remove unnecessary blank lines.