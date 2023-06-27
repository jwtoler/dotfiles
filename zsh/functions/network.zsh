# Get IP from hostname
hostname2ip() {
  ping -c 1 "$1" | egrep -m1 -o '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}'
}

# Upload file to transfer.sh
# https://github.com/dutchcoders/transfer.sh/
transfer() {
  tmpfile=$( mktemp -t transferXXX )
  curl --progress-bar --upload-file "$1" https://transfer.sh/$(basename $1) >> $tmpfile;
  cat $tmpfile;
  rm -f $tmpfile;
}