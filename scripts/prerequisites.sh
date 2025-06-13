#! /bin/bash

# Get the absolute path of the directory where the script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

. $SCRIPT_DIR/utils.sh

install_xcode() {
  if ! xcode-select --print-path &>/dev/null; then
    info "Installing Xcode Command Line Tools (prerequisites for Git and Homebrew)..."
    xcode-select --install &>/dev/null
    # Wait for Xcode Command Line Tools installation
    until xcode-select --print-path &>/dev/null; do sleep 5; done
    sudo xcodebuild -license accept
    success "Xcode Command Line Tools installation complete."
  else
    warning "Xcode Command Line Tools already installed. Skipping installation."
  fi
}

install_homebrew() {
  if ! command -v brew &>/dev/null; then
    info "Homebrew not found. Installing Homebrew..."
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    if ! command -v brew &>/dev/null; then
      error "Error installing Homebrew. Exiting script."
      exit 1
    fi
    success "Homebrew installation complete."
  else
    warning "Homebrew already installed. Skipping installation."
  fi
}

if [ "$(basename "$0")" = "$(basename "${BASH_SOURCE[0]}")" ]; then
    install_xcode
    install_homebrew
fi
