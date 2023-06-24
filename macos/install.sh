if test ! "$(uname)" = "Darwin"
  then
  exit 0
fi

# Run command line for updates and installables in the Mac App Store.
echo "› sudo softwareupdate -i -a"
sudo softwareupdate -i -a