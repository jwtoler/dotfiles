# Load .env file into shell session for environment variables
function envup() {
  if [ -f .env ]; then
    export $(sed '/^ *#/ d' .env)
  else
    echo 'No .env file found' 1>&2
    return 1
  fi
}

# Add to path
prepend-path() {
  [ -d $1 ] && PATH="$1:$PATH"
}

function start-work() {
    mutagen-compose -f $HOME/Projects/docker-base/docker-compose.yml up -d
    mutagen-compose -f $HOME/Projects/appdev-api/docker-compose.yml up -d
    phpstorm
}