#! /bin/sh

###############################################################################
# Transmission                                                                #
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

# Show the donate message
defaults write org.m0k.transmission WarningDonate -bool false

# Show the legal disclaimer
defaults write org.m0k.transmission WarningLegal -bool false

# IP block list.
defaults write org.m0k.transmission BlocklistNew -bool true
defaults write org.m0k.transmission BlocklistURL -string "http://list.iblocklist.com/?list=bt_level1&fileformat=p2p&archiveformat=gz"
defaults write org.m0k.transmission BlocklistAutoUpdate -bool true

# Randomize port on launch
defaults write org.m0k.transmission RandomPort -bool true