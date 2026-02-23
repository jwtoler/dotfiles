# Create a new session named for current directory, or attach if exists.
function tna() {
  tmux new-session -As $(basename "$PWD" | tr . -)
}

# Makes creating a new tmux session (with a specific name) easier
function tn() {
  tmux new -s $1
}

# Makes attaching to an existing tmux session (with a specific name) easier
function ta() {
  tmux attach -t $1
}

# Makes deleting a tmux session easier
function tk() {
  tmux kill-session -t $1
}

# Kill all tmux sessions
function tka() {
  tmux ls | cut -d : -f 1 | xargs -I {} tmux kill-session -t {}
}

# SSH helper function with iterm integration w/ tmux
function tmssh () {
  if [[ -z "$1" ]]; then
    me="${FUNCNAME[0]}${funcstack[1]}"
    echo "usage: $me [ssh-args] hostname"
    return 1
  fi

  ssh "$@" -t 'tmux -CC new -A -s tmssh'
}