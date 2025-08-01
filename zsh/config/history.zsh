# History Settings
HISTFILE=$HOME/.zhistory
HISTSIZE=25000
SAVEHIST=${HISTSIZE}       

setopt INC_APPEND_HISTORY       # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY            # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST   # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS         # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS     # Delete old recorded entry if new entry is a duplicate.
setopt HIST_IGNORE_SPACE        # Don't record an entry starting with a space.
setopt HIST_REDUCE_BLANKS       # Remove unnecessary blank lines.
setopt HIST_SAVE_NO_DUPS        # Don't write duplicate entries in the history file.
setopt HIST_NO_STORE			# Remove the history (fc -l) command from the history list when invoked.
