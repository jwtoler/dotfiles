#! /bin/sh

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# DESCRIPTION:
# 	Script to configure the dock using dockutil - https://github.com/kcrawford/dockutil/
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

export PATH=/usr/bin:/bin:/usr/sbin:/sbin

# Get the currently logged in user
currentUser=$( echo "show State:/Users/ConsoleUser" | scutil | awk '/Name :/ { print $3 }' )

# Get uid logged in user
uid=$(id -u "${currentUser}")

# Current User home folder - do it this way in case the folder isn't in /Users
userHome=$(dscl . -read /users/${currentUser} NFSHomeDirectory | cut -d " " -f 2)

# Path to plist
plist="${userHome}/Library/Preferences/com.apple.dock.plist"

# Convenience function to run a command as the current user
# usage: runAsUser command arguments...
runAsUser() {  
	if [[ "${currentUser}" != "loginwindow" ]]; then
		launchctl asuser "$uid" sudo -u "${currentUser}" "$@"
	else
		echo -e "\033[0;31mno user logged in\033[0m"
		exit 1
	fi
}

# Check if dockutil is installed
if [[ -x "/usr/local/bin/dockutil" ]]; then
    dockutil="/usr/local/bin/dockutil"
else
    echo -e "\033[0;31mdockutil not installed in /usr/local/bin, exiting!\033[0m"
    exit 1
fi

# Version dockutil
dockutilVersion=$(${dockutil} --version)
echo -e "\033[0;34mDockutil version = ${dockutilVersion}\033[0m"

# Clean Dock first
runAsUser "${dockutil}" --remove all --no-restart ${plist}

# Full path to Applications to add to the Dock
apps=(
	"/System/Applications/Messages.app"
	"/Applications/Slack.app"
	"/Applications/Safari.app"
	"/Applications/Google Chrome.app"
	"/Applications/iTerm.app"
	"/Applications/Sequel Ace.app"
)

# Loop through Apps and check if App is installed, If Installed at App to the Dock.
for app in "${apps[@]}"; 
do
	if [[ -e ${app} ]]; then
		runAsUser "${dockutil}" --add "$app" --no-restart ${plist};
	else
		echo -e "\033[0;31m${app} not installed\033[0m"
    fi
done

# Add Application Folder to the Dock
runAsUser "${dockutil}" --add /Applications --view grid --display folder --sort name --no-restart ${plist}

# Add logged in users Downloads folder to the Dock
runAsUser "${dockutil}" --add ${userHome}/Downloads --view list --display stack --sort dateadded --no-restart ${plist}

# Disable show recent
# runAsUser defaults write com.apple.dock show-recents -bool FALSE
# echo "Hide show recent from the Dock"

# sleep 3

# Kill dock to use new settings
killall -KILL Dock

echo -e "\033[0;32mFinished setting Dock icons!\033[0m"

exit 0