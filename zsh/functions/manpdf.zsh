# Open man page as PDF
manpdf() {
  man -t "$1" | open -f -a /Applications/Preview.app/
}