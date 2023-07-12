#! /bin/sh

###############################################################################
# iTerm 2                            								          #
###############################################################################

# Install Shell Integration
curl -L https://iterm2.com/shell_integration/zsh -o ~/.iterm2_shell_integration.zsh

# Don’t display the annoying prompt when quitting iTerm
defaults write com.googlecode.iterm2 PromptOnQuit -bool false

# Set fonts
defaults write com.googlecode.iterm2 "Normal Font" -string "Hack-Regular 12";
defaults write com.googlecode.iterm2 "Non Ascii Font" -string "RobotoMonoForPowerline-Regular 12";

# Animate split-terminal dimming
defaults write com.googlecode.iterm2 AnimateDimming -bool true;ok
defaults write com.googlecode.iterm2 HotkeyChar -int 96;
defaults write com.googlecode.iterm2 HotkeyCode -int 50;
defaults write com.googlecode.iterm2 FocusFollowsMouse -int 1;
defaults write com.googlecode.iterm2 HotkeyModifiers -int 262401;