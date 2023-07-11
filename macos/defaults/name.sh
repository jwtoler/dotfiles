#! /bin/sh

COMPUTERNAME="Justin Toler's MBP"
HOSTNAME='Toler-MBP'

# Set computer name (as done via System Preferences → Sharing)
sudo scutil --set ComputerName $COMPUTERNAME
sudo scutil --set HostName $HOSTNAME
sudo scutil --set LocalHostName $HOSTNAME
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string $HOSTNAME