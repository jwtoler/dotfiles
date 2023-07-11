#! /bin/sh

if test ! "$(uname)" = "Darwin"
  then
  exit 0
fi

###############################################################################
# MacOS Software updates                                                      #
###############################################################################
echo "› sudo softwareupdate -aiR"
sudo softwareupdate -aiR

###############################################################################
# XCode Command Line Tools                                                    #
###############################################################################
if ! xcode-select --print-path &> /dev/null; then

  echo "Install XCode Command Line Tools..."

  # Install the XCode Command Line Tools
  xcode-select --install &> /dev/null

  # Wait until the XCode Command Line Tools are installed
  until xcode-select --print-path &> /dev/null; do
    sleep 5
  done

  # Point the `xcode-select` developer directory to
  # the appropriate directory from within `Xcode.app`
  echo "Make "xcode-select" developer directory point to Xcode"
  sudo xcode-select -switch /Applications/Xcode.app/Contents/Developer

fi

# Accept the Xcode/iOS license agreement
if ! $(sudo xcodebuild -license status); then
  sudo xcodebuild -license accept
fi