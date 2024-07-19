#!/usr/bin/env bash
sudo -v

DOTFILES_DIR=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
echo $DOTFILES_DIR

# Define variables for each package manager and include the corresponding package lists
. ../scripts/functions.sh
brew_packages="Brewfile"
cask_packages="Caskfile"
node_packages="node_packages.txt"
python_packages="python_packages.txt"

# Define a function for installing packages with Homebrew
install_brew_packages() {
  if ! command -v $(which brew) &>/dev/null; then
    substep_info "Homebrew not found. Installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    if ! command -v $(which brew) &>/dev/null; then
      error "Failed to install Homebrew. Exiting."
      exit 1
    fi
    substep_success "Homebrew installed."
  fi
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
    substep_info "Installing FNM..."
    curl -fsSL https://fnm.vercel.app/install | bash
    eval "$(fnm env --use-on-cd)" # needed to install npm packages - already set for Fish
    substep_success "FNM installed."
  fi

  # Install latest LTS version of Node with FNM and set as default
  if ! fnm use --lts &>/dev/null; then
    info "Installing latest LTS version of Node..."
    fnm install --lts
    fnm alias lts-latest default
    fnm use default
    substep_success "Node LTS installed and set as default for FNM."
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
    substep_info "Python not found. Installing..."
    brew install python
    if ! command -v $(which python) &>/dev/null; then
      error "Failed to install Python. Exiting."
      exit 1
    fi
    substep_success "Python installed."
  fi
  info "Installing Python packages..."
  pip install $(cat "$python_packages")
  success "Finished installing Python packages."
}


# Call each installation function
install_brew_packages
install_node_packages
# install_python_packages
