#! /usr/bin/env sh
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[0;37m'
BLACK='\033[0;30m'
NC='\033[0m'

error() {
    local message="$1"
    echo -e "${RED}====================================================${NC}"
    echo -e "${RED} ERROR: $message${NC}"
    echo -e "${RED}====================================================${NC}"
}

info() {
    local message="$1"
    echo -e "${BLUE}====================================================${NC}"
    echo -e "${BLUE} INFO: $message${NC}"
    echo -e "${BLUE}====================================================${NC}"
}

warning() {
    local message="$1"
    local padded_message=" WARNING: $message"
    local line=$(printf "%${#padded_message}s" | tr " " "=")
    echo -e "${YELLOW}$line${NC}"
    echo -e "${YELLOW} WARNING:${NC} $message${NC}"
    echo -e "${YELLOW}$line${NC}"
}

success() {
    local message="$1"
    echo -e "${GREEN}====================================================${NC}"
    echo -e "${GREEN} SUCCESS: $message${NC}"
    echo -e "${GREEN}====================================================${NC}"
}