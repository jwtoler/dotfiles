#!/usr/bin/env bash

######################################################################
# 🧰 Jwtoler/Dotfiles - All-in-One Install and Setup Script for Unix #
######################################################################
# For docs and more info, see: https://github.com/jwtoler/dotfiles   #
#                                                                    #
# OPTIONS:                                                           #
#   --auto-yes: Skip all prompts, and auto-accept all changes        #
#   --no-clear: Don't clear the screen before running                #
#                                                                    #
# ENVIRONMENTAL VARIABLES:                                           #
#   DOTFILES_DIR: Where to save dotfiles to (default: ~/.dotfiles)   #
#   DOTFILES_REPO: Git repo to USE (default: jwtoler/Dotfiles)       #
#                                                                    #
# IMPORTANT: Before running, read through everything very carefully! #
#                                                                    #
######################################################################

# Set variables for reference
PARAMS=$*
CURRENT_DIR=$(cd "$(dirname ${BASH_SOURCE[0]})" && pwd)
SYSTEM_TYPE=$(uname -s)
PROMPT_TIMEOUT=30
START_TIME=`date +%s`
SRC_DIR=$(dirname ${0})

# Dotfiles Source Repo and Destination Directory
REPO_NAME="${REPO_NAME:-jwtoler/Dotfiles}"
DOTFILES_DIR="${DOTFILES_DIR:-${SRC_DIR:-$HOME/.dotfiles}}"
DOTFILES_REPO="${DOTFILES_REPO:-https://github.com/${REPO_NAME}.git}"
PROJECTS_DIR="$HOME/Projects"

# Clear the screen
if [[ ! $PARAMS == *"--no-clear"* ]] && [[ ! $PARAMS == *"--help"* ]] ; then
  clear
fi

# If set to auto-yes - then don't wait for user reply
if [[ $PARAMS == *"--auto-yes"* ]]; then
  PROMPT_TIMEOUT=1
  AUTO_YES=true
fi

# Include functions
. scripts/functions.sh

# Create the ~/Developer directory if it does not exist
if [ ! -d "$PROJECTS_DIR" ]; then
    mkdir -p "$PROJECTS_DIR"
fi

mainInstall() {
  # check for required commands
  check_required_commands

  # Confirmation prompt
  warning "This will install & configure dotfiles on your system. It may overwrite existing files."
  read -p "Are you sure you want to proceed? (y/n) " confirm
  if [[ "$confirm" != "y" ]]; then
    echo -e "${RED}Installation aborted."
    exit 0
  fi

  # Check for sudo password and keep alive
  if sudo --validate; then
    sudo_keep_alive &
    SUDO_PID=$!
    trap 'kill "$SUDO_PID"' EXIT
    substep_info "Sudo password saved. Continuing with script."
  else
    substep_error "Incorrect sudo password. Exiting script."
    exit 1
  fi

  # Install Homebrew
  # install_homebrew

  # Display banner and prompt user to continue
  banner
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    # Run setup scripts in order
    #source ./packages/packages.sh

    # Install Stow packages
    #declare -a stow_dirs=("dots" "git" "fish" "nvim" "config" "local" "warp" "vscode")
    #for dir in "${stow_dirs[@]}"; do
    #  stow "$dir"
    #done

    # Set default applications for various file extensions
    source ${DOTFILES_DIR}/duti/duti.sh

    # Set MacOS settings and preferences
    source ${DOTFILES_DIR}/macos/macos.sh

    # Check if Fish is installed and set it as the default shell if desired
    if command -v fish &>/dev/null; then
      if ! grep -q "$(command -v fish)" /etc/shells; then
        substep_info "Adding Fish to available shells..."
        sudo sh -c "echo $(command -v fish) >> /etc/shells"
      fi
      read -p "Do you want to set Fish as your default shell? (y/N): " -n 1 -r
      echo    # Move to a new line
      if [[ $REPLY =~ ^[Yy]$ ]]; then
        chsh -s "$(command -v fish)"
      fi
    fi

    success "Dotfile setup complete."
  else
    error "Aborted."
  fi
}

# Run the main function
mainInstall