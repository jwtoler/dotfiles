# Directories
alias dotfiles="cd $DOTFILES"
alias library="cd $HOME/Library"
alias projects="cd $HOME/Projects"

# Shortcuts
alias rmds="find . -type f -name '*.DS_Store' -ls -delete"
alias flushdns='sudo dscacheutil -flushcache;sudo killall -HUP mDNSResponder;echo "✌️ DNS flushed"'
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"