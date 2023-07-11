#! /bin/sh

###############################################################################
# Photos                                                                      #
###############################################################################

# Startup (with iCloud Photos selected)
defaults write com.apple.Photos IPXDefaultDidPromoteiCloudPhotosInGettingStarted -bool true
defaults write com.apple.Photos IPXDefaultHasBeenLaunched -bool true
defaults write com.apple.Photos IPXDefaultHasChosenToEnableiCloudPhotosInGettingStarted -bool true;

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