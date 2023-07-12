#! /bin/sh

# Close System Preferences panes to prevent them from overriding
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &


###############################################################################
# Run all scripts in the 'defaults' folder
###############################################################################
find ./defaults -type f -name '*.sh' -exec {} \;


###############################################################################
# Spyware/Ad Blocking -- /etc/hosts
###############################################################################
read -r -p "Overwrite /etc/hosts with the ad-blocking hosts file from someonewhocares.org? (from ./configs/hosts file) [y|N] " response
if [[ $response =~ (yes|y|Y) ]]; then
  sudo cp /etc/hosts /etc/hosts.backup
  sudo curl -L "https://someonewhocares.org/hosts/zero/hosts" -o /etc/hosts 
  echo "Your /etc/hosts file has been updated. Last version is saved in /etc/hosts.backup"
else
  echo "Skipped...";
fi


###############################################################################
# Mackup Restore
###############################################################################
find "${HOME}/Library/Mobile Documents/com~apple~CloudDocs/Mackup/" -type f -name "*.icloud" -exec brctl download {} \;
mackup restore


###############################################################################
# Do some clean up work.
###############################################################################
for app in "Activity Monitor" "Address Book" "Calendar" "Contacts" "cfprefsd" \
           "Dock" "Finder" "Mail" "Messages" "Safari" "SystemUIServer" \
           "Terminal" "Twitter" "iCal"; do
           kill all "${app}" > /dev/null 2>&1
done

# Wait a bit before moving on...
sleep 1

# then...
echo "Success! Defaults are set."
echo "Some changes will not take effect until you reboot your machine."

# See if the user wants to reboot.
function reboot() {
  read -p "Do you want to reboot your computer now? (y/N)" choice
  case "$choice" in
    y | Y | Yes | yes ) echo "Yes"; exit;; # If y | yes, reboot
    n | N | No | no) echo "No"; exit;; # If n | no, exit
    * ) echo "Invalid answer. Enter \"y/yes\" or \"N/no\"" && return;;
  esac
}

# Call on the function
if [[ "Yes" == $(reboot) ]]
then
  echo "Rebooting."
  sudo reboot
  exit 0
else
  exit 1
fi