# Change working directory to the top-most Finder window location
cdf() {
	cd "$(osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)')";
}

# Open man page as PDF
manpdf() {
  man -t "$1" | open -f -a /Applications/Preview.app/
}