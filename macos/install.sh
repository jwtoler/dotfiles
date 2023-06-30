if test ! "$(uname)" = "Darwin"
  then
  exit 0
fi

###############################################################################
# MacOS Software updates                                                      #
###############################################################################
echo "› sudo softwareupdate -i -a"
sudo softwareupdate -aiR
xcode-select --install

###############################################################################
# XCode Command Line Tools                                                    #
###############################################################################
if ! xcode-select --print-path &> /dev/null; then

  # Install the XCode Command Line Tools
  xcode-select --install &> /dev/null

  # Wait until the XCode Command Line Tools are installed
  until xcode-select --print-path &> /dev/null; do
    sleep 5
  done

  echo "Install XCode Command Line Tools"

  # Point the `xcode-select` developer directory to
  # the appropriate directory from within `Xcode.app`
  echo "Make "xcode-select" developer directory point to Xcode"
  sudo xcode-select -switch /Applications/Xcode.app/Contents/Developer

  # Prompt user to agree to the terms of the Xcode license
  echo "Agree with the XCode Command Line Tools licence"
  sudo xcodebuild -license accept

fi
