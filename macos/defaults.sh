#!/usr/bin/env bash

# Source ----> https://mths.be/macos

COMPUTERNAME="Justin Toler's MBP"
HOSTNAME='Toler-MBP'
LOCALHOSTNAME='Toler-MBP'

# Close System Preferences panes to prevent them from overriding
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

###############################################################################
# General UI/UX                                                               #
###############################################################################

# Set computer name (as done via System Preferences → Sharing)
sudo scutil --set ComputerName $COMPUTERNAME
sudo scutil --set HostName $HOSTNAME
sudo scutil --set LocalHostName $LOCALHOSTNAME
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string $LOCALHOSTNAME

# Disable the sound effects on boot
sudo nvram SystemAudioVolume=" "

# Set sidebar icon size to medium
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 2

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Disable Notification Center and remove the menu bar icon
launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist 2> /dev/null

# Reveal IP address, hostname, OS version, etc. when clicking the clock
# in the login window
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

# Use AirDrop over every interface.
defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1

# Sidebar icon size
# Small  : 1
# Medium : 2
# Large  : 3
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 1



###############################################################################
# Activity Monitor                                                            #
###############################################################################

# Show the main window when launching Activity Monitor
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

# Visualize CPU usage in the Activity Monitor Dock icon
defaults write com.apple.ActivityMonitor IconType -int 5

# Show all processes in Activity Monitor
defaults write com.apple.ActivityMonitor ShowCategory -int 0

# Sort Activity Monitor results by CPU usage
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0



###############################################################################
# App Store                                                                   #
###############################################################################

# Enable the automatic update check
defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true

# Check for software updates daily, not just once per week
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# Download newly available updates in background
defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1

# Install System data files & security updates
defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1

# Turn on app auto-update
defaults write com.apple.commerce AutoUpdate -bool true



###############################################################################
# Mission Control (Dashboard)		                              			          #
###############################################################################

# Disable Dashboard
defaults write com.apple.dashboard mcx-disabled -bool true

# Dashboard:
# 1: Off
# 2: As Space
# 3: As Overlay
defaults write com.apple.dashboard enabled-state -int 1

# Don’t show Dashboard as a Space
defaults write com.apple.dock dashboard-in-overlay -bool true

# Enable Dashboard dev mode (allows keeping widgets on the desktop)
defaults write com.apple.dashboard devmode -bool true



###############################################################################
# Dock                       		                              			          #
###############################################################################

# Icon size of Dock items
defaults write com.apple.dock tilesize -int 46

# Lock the Dock size
defaults write com.apple.dock size-immutable -bool true

# Dock magnification
defaults write com.apple.dock magnification -bool false

# Icon size of magnified Dock items
defaults write com.apple.dock largesize -int 64

# Dock orientation: 'left', 'bottom', 'right'
defaults write com.apple.dock 'orientation' -string 'left'

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Remove the auto-hiding Dock delay
defaults write com.apple.dock autohide-delay -float 0

# Remove the animation when hiding/showing the Dock
defaults write com.apple.dock autohide-time-modifier -float 0

# Make Dock icons of hidden applications translucent
defaults write com.apple.dock showhidden -bool true

# Wipe all (default) app icons from the Dock
defaults write com.apple.dock persistent-apps -array



###############################################################################
# Finder                                                                      #
###############################################################################

# Show ~/Library
chflags nohidden ~/Library

# Show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Allow text-selection in Quick Look
defaults write com.apple.finder QLEnableTextSelection -bool true

# Preferred view style
# Icon View   : `icnv`
# List View   : `Nlsv`
# Column View : `clmv`
# Cover Flow  : `Flwv`
# After configuring preferred view style, clear all `.DS_Store` files
# to ensure settings are applied for every directory
sudo find / -name ".DS_Store" --delete
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Set the Finder prefs for showing a few different volumes on the Desktop.
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Show hidden files and file extensions by default
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write NSGlobalDomain AppleShowAllExtensions -bool false

# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Expand the following File Info panes
defaults write com.apple.finder FXInfoPanesExpanded -dict \
    General -bool true \
    OpenWith -bool true \
    Privileges -bool true



###############################################################################
# Google Chrome                                                               #
###############################################################################

# Disable backswipe
defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false
defaults write com.google.Chrome.canary AppleEnableSwipeNavigateWithScrolls -bool false

# Use the system-native print preview dialog
defaults write com.google.Chrome DisablePrintPreview -bool true
defaults write com.google.Chrome.canary DisablePrintPreview -bool true

# Expand the print dialog by default
defaults write com.google.Chrome PMPrintingExpandedStateForPrint2 -bool true
defaults write com.google.Chrome.canary PMPrintingExpandedStateForPrint2 -bool true



###############################################################################
# Keyboard & Trackpad                                                         #
###############################################################################
# use keyboard navigation to move focus between controls (tab-tab for everything)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Set a blazingly fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1



###############################################################################
# Safari                                                                      #
###############################################################################

# Don’t send search queries to Apple
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true

# Show the full URL in the address bar (note: this still hides the scheme)
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

# Disable delay when rendering web pages
defaults write com.apple.Safari WebKitInitialTimedLayoutDelay 0.25

# Prevent Safari from opening ‘safe’ files automatically after downloading
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

# Hide Safari’s bookmarks bar by default
defaults write com.apple.Safari ShowFavoritesBar -bool false

# Remove useless icons from Safari’s bookmarks bar
defaults write com.apple.Safari ProxiesInBookmarksBar "()"

# Enable the Develop menu and the Web Inspector in Safari
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true && \
defaults write com.apple.Safari IncludeDevelopMenu -bool true && \
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true && \
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true && \
defaults write -g WebKitDeveloperExtras -bool true

# Add a context menu item for showing the Web Inspector in web views
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

# Enable continuous spellchecking
defaults write com.apple.Safari WebContinuousSpellCheckingEnabled -bool true

# Disable autocorrect in Safari
defaults write com.apple.Safari WebAutomaticSpellingCorrectionEnabled -bool false

# Block pop-up windows
defaults write com.apple.Safari WebKitJavaScriptCanOpenWindowsAutomatically -bool false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaScriptCanOpenWindowsAutomatically -bool false

# Enable “Do Not Track”
defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool true

# Update extensions automatically
defaults write com.apple.Safari InstallExtensionUpdatesAutomatically -bool true



###############################################################################
# Screen & Screenshots                                                        #
###############################################################################

# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Screenshot location, type, & shadow feature
defaults write com.apple.screencapture location -string "${HOME}/Desktop/Screenshots"
defaults write com.apple.screencapture type -string "png"
defaults write com.apple.screencapture disable-shadow -bool true



###############################################################################
# Spotlight                                                                   #
###############################################################################

# Hide Spotlight tray-icon (and subsequent helper)
sudo chmod 600 /System/Library/CoreServices/Search.bundle/Contents/MacOS/Search

# Disable Spotlight indexing for any volume that gets mounted and has not yet
# been indexed before.
# Use `sudo mdutil -i off "/Volumes/foo"` to stop indexing any volume.
sudo defaults write /.Spotlight-V100/VolumeConfiguration Exclusions -array "/Volumes"

# Load new settings before rebuilding the index
killall mds > /dev/null 2>&1

# Make sure indexing is enabled for the main volume
sudo mdutil -i on / > /dev/null

# Rebuild the index from scratch
sudo mdutil -E / > /dev/null



###############################################################################
# Time Machine                                                                #
###############################################################################

# Prevent Time Machine from prompting to use new hard drives as backup volume
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true



###############################################################################
# Photos                                                                      #
###############################################################################

# Startup (with iCloud Photos selected)
defaults write com.apple.Photos IPXDefaultDidPromoteiCloudPhotosInGettingStarted -bool true
defaults write com.apple.Photos IPXDefaultHasBeenLaunched -bool true
defaults write com.apple.Photos IPXDefaultHasChosenToEnableiCloudPhotosInGettingStarted = 1;

# Summarize photos
# You can choose compast, summarized views for Collections and Years
defaults write com.apple.Photos IPXDefaultPhotosSummarizePhotos -bool true

# Copy items to the Photos library
# Only items copied to the library will upload to iCloud Photo library (when disabled)
defaults write com.apple.Photos IPXDefaultImportUseReferencedImport -bool false

# Include location information for published items
defaults write com.apple.Photos IPXDefaultPlacesPublishPlaceInfo -bool false

# Prevent Photos from opening automatically when devices are plugged in
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true



###############################################################################
# iTerm 2                                      #
###############################################################################

# Don’t display the annoying prompt when quitting iTerm
defaults write com.googlecode.iterm2 PromptOnQuit -bool false



###############################################################################
# Transmission.app                                                            #
###############################################################################

# Use `~/Torrents/Incomplete` to store incomplete downloads
defaults write org.m0k.transmission UseIncompleteDownloadFolder -bool true
defaults write org.m0k.transmission IncompleteDownloadFolder -string "~/Torrents/Incomplete"

# Hide `~/Torrents/Incomplete` downloads folder
mkdir -p ~/Torrents/Incomplete
sudo chflags -h hidden ~/Torrents/Incomplete

# Use `~/Torrents/Complete` to store completed downloads
mkdir -p ~/Torrents/Complete
defaults write org.m0k.transmission DownloadLocationConstant -bool true
defaults write org.m0k.transmission DownloadChoice -string "Constant"
defaults write org.m0k.transmission DownloadFolder -string "~/Torrents/Complete"

# Don’t prompt for confirmation before downloading
defaults write org.m0k.transmission DownloadAsk -bool false
defaults write org.m0k.transmission MagnetOpenAsk -bool false

# Don’t prompt for confirmation before removing non-downloading active transfers
defaults write org.m0k.transmission CheckRemoveDownloading -bool true

# Trash original torrent files
defaults write org.m0k.transmission DeleteOriginalTorrent -bool true

# Hide the donate message
defaults write org.m0k.transmission WarningDonate -bool false
# Hide the legal disclaimer
defaults write org.m0k.transmission WarningLegal -bool false

# IP block list.
# Source: https://giuliomac.wordpress.com/2014/02/19/best-blocklist-for-transmission/
defaults write org.m0k.transmission BlocklistNew -bool true
defaults write org.m0k.transmission BlocklistURL -string "http://john.bitsurge.net/public/biglist.p2p.gz"
defaults write org.m0k.transmission BlocklistAutoUpdate -bool true

# Randomize port on launch
defaults write org.m0k.transmission RandomPort -bool true



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

# ...and then.
echo "Success! Defaults are set."
echo "Some changes will not take effect until you reboot your machine."

# See if the user wants to reboot.
function reboot() {
  read -p "Do you want to reboot your computer now? (y/N)" choice
  case "$choice" in
    y | Yes | yes ) echo "Yes"; exit;; # If y | yes, reboot
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