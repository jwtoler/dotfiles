#!/bin/sh
#
# Dockutil is a command line utility for managing macOS dock items. 
#
# This installs the latest release of Dockutil form GitHub since
# the Homebrew formulas have some going on and stop at version 2.x.x.
#
# Latest Version: 3.0.2

echo "  Installing Dockutil..."

curl -L https://github.com/kcrawford/dockutil/releases/download/3.0.2/dockutil-3.0.2.pkg -o $(HOME)/dockutil.pkg
sudo installer -pkg $(HOME)/dockutil.pkg -target /

# cleanup
rm $(HOME)/dockutil.pkg

exit 0