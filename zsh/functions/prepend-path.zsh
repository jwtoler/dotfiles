prepend-path() {
  [ -d $1 ] && PATH="$1:$PATH"
}