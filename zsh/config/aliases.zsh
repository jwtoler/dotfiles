# Aliases
alias c="clear"
alias ll="/opt/homebrew/opt/coreutils/libexec/gnubin/ls -AhlFo --color --group-directories-first"
alias ln="ln -v"
alias e="$EDITOR"
alias v="$VISUAL"
alias mkdir="mkdir -p"
alias reload="source ~/.zshrc" 
alias zshconfig="edit ~/.zshrc" 

# Directories
alias dotfiles="cd $DOTFILES"
alias library="cd $HOME/Library"
alias projects="cd $HOME/Projects"

# PHP
alias cfresh="rm -rf vendor/ composer.lock && composer i"
alias composer="php -d memory_limit=-1 /opt/homebrew/bin/composer"

# Show/hide desktop icons
alias desktopshow="defaults write com.apple.finder CreateDesktop -bool true && killfinder"
alias desktophide="defaults write com.apple.finder CreateDesktop -bool false && killfinder"

# Recursively remove Apple meta files
alias cleanupds="find . -type f -name '*.DS_Store' -ls -delete"
alias cleanupad="find . -type d -name '.AppleD*' -ls -exec /bin/rm -r {} \;"

# Flush DNS
alias flushdns='sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder; echo "✌️ DNS flushed"'

# Network
alias ip="curl -s ipinfo.io | jq -r '.ip'"
alias ipl="ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'"

# Include custom aliases
if [[ -f ~/.aliases.local ]]; then
  source ~/.aliases.local
fi