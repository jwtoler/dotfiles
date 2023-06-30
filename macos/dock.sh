#!/bin/sh

echo "Applying dock"

dockutil --no-restart --remove all
dockutil --no-restart --add "/Applications/Finder.app"
dockutil --no-restart --add "/System/Applications/System Preferences.app"
#dockutil --no-restart --add "/Applications/Google Chrome.app"
#dockutil --no-restart --add "/System/Applications/Calendar.app"

killall Dock

echo "Dock reloaded."