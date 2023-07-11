#! /bin/sh

###############################################################################
# Screenshots                                                                 #
###############################################################################

# Screenshot location, type, & shadow feature
defaults write com.apple.screencapture location -string "${HOME}/Desktop/Screenshots"
defaults write com.apple.screencapture type -string "png"
defaults write com.apple.screencapture disable-shadow -bool true