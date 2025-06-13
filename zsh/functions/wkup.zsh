# Start base containers necessary for work development
wkup() {
  cd ~/Development/work/dev-docker-base;
  mutagen-compose up -d;
  cd ~/Development/work/appdev-api;
  mutagen-compose up -d;
  cd ~/Development/work;
}