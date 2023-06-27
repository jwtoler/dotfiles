#!/usr/bin/env bash

# Abort on error
set -e

echo "Checking if Oh-my-zsh is already installed..."; 

# Check for Oh My Zsh and install if we don't have it
if test ! $(which omz); then
  echo "Installing Oh-my-zsh...";
  yes | /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/HEAD/tools/install.sh)"
else
  echo "Oh-my-zsh is already installed...";
fi