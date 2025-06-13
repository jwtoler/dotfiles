#! /bin/bash

# Get the absolute path of the directory where the script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

. $SCRIPT_DIR/utils.sh

# Define variables for each package manager
brew_packages="$SCRIPT_DIR/../packages/Brewfile"
cask_packages="$SCRIPT_DIR/../packages/Caskfile"
node_packages="$SCRIPT_DIR/../packages/node_packages.txt"
python_packages="$SCRIPT_DIR/../packages/python_packages.txt"

# Define a function for installing packages with Homebrew
install_brew_packages() {
  info "Installing Homebrew packages..."
  brew update
  brew upgrade
  brew bundle --file="$brew_packages" || true
  brew bundle --file="$cask_packages" || true
  success "Finished installing Homebrew packages."
}

# Install Node with FNM and set latest LTS as default, then install npm packages
install_node_packages() {
  # Install FNM
  if ! command -v fnm &>/dev/null; then
    info "Installing FNM..."
    curl -fsSL https://fnm.vercel.app/install | bash
    eval "$(fnm env --use-on-cd)" # needed to install npm packages - already set for Fish
    success "FNM installed."
  fi

  # Install latest LTS version of Node with FNM and set as default
  if ! fnm use --lts &>/dev/null; then
    info "Installing latest LTS version of Node..."
    fnm install --lts
    fnm alias lts-latest default
    fnm use default
    success "Node LTS installed and set as default for FNM."
  fi

  # Install NPM packages
  info "Installing NPM packages..."
  npm install -g $(cat $node_packages)
  corepack enable
  success "All NPM global packages installed."
}

# Define a function for installing packages with Python
install_python_packages() {
  if ! command -v $(which python) &>/dev/null; then
    info "Python not found. Installing..."
    brew install python
    if ! command -v $(which python) &>/dev/null; then
      error "Failed to install Python. Exiting."
      exit 1
    fi
    success "Python installed."
  fi
  info "Installing Python packages..."
  pip install $(cat "$python_packages")
  success "Finished installing Python packages."
}

install_custom_packages() {
  # Install Posting - terminal app for developing and testing APIs
  curl -LsSf https://astral.sh/uv/install.sh | sh
  uv tool install --python 3.12 posting
}