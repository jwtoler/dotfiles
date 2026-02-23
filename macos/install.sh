#!/usr/bin/env bash

# Close System Preferences panes to prevent them from overriding
osascript -e 'tell application "System Preferences" to quit'

# Keep-alive: update existing `sudo` time stamp until finished
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

###############################################################################
# Run all scripts in the 'defaults' folder
###############################################################################
find ./defaults -type f -name '*.sh' -exec {} \;

###############################################################################
# Mackup restore
###############################################################################
find "${HOME}/Library/Mobile Documents/com~apple~CloudDocs/Mackup/" -type f -name "*.icloud" -exec brctl download {} \;
mackup restore

###############################################################################
# Set timeout of sudo to 60 mins on Terminal
###############################################################################
/bin/echo 'Defaults timestamp_timeout=60' | /usr/bin/sudo EDITOR='tee -a' visudo

###############################################################################
# Enable TouchID on Terminal
###############################################################################
bash sudo-touchid.sh -e -s

# Wait a bit before moving on...
sleep 1

# then...
echo "Defaults are set!"
echo "Some changes will not take effect until you reboot your machine."

exit 1
