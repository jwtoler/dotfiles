#! /bin/sh

# Git add, commit and push all at the same time.
function addcommitpush() {
  # Determine current branch
  current=$(git branch | grep "*" | cut -b 3-)

  # Wrap inline var in single quotes and store in var called message
  message=\'"$@"\'

  # Git add and pass message var to git commit
  git add -A && git commit -a -m "$message"

  echo "Where to push?"

  # Prefill current branch and prompt var to store a push branchname
  read -i "$current" -e branch

  # Last chance before push -- prefill yes
  echo "You sure you wanna push? (y/n)"
  read -i "y" -e yn

  if [ "$yn" = y ]; then
    git push origin "$branch"
  else
    echo "Have a nice day!"
  fi
}

# Pass inline variable to function and run
addcommitpush $1