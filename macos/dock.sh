#!/bin/sh

echo "Applying dock"

dockutil --no-restart --remove all
dockutil --no-restart --add "/Applications/Finder.app"
k
dockutil --no-restart --add "/Applications/Messages.app"
dockutil --no-restart --add "/Applications/Sequel Ace.app"

killall Dock

echo "Dock reloaded."