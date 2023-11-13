#!/bin/sh

## Generate a new SSH key and add it to the ssh-agent

PERSONAL_EMAIL=jwtoler@gmail.com
WORK_EMAIL=justin.toler@charlotte.edu

# create default .ssh directory if it doesn’t exist
# https://docs.github.com/en/authentication/connecting-to-github-with-ssh/checking-for-existing-ssh-keys
if [[ ! -d "${HOME}/.ssh/" ]]; then
  mkdir "${HOME}/.ssh/"
  chmod 700 "${HOME}/.ssh/"
fi

# check if personal ssh key already exists
if [[ -f "${HOME}/.ssh/id_ed25519" ]]; then
  echo "Personal SSH Key already exists. Skipping SSH Key Generation."
else
  echo "Generating a new personal SSH key..."

  # generate ssh keys for personal projects 
  ssh-keygen -q -t ed25519 -C "${PERSONAL_EMAIL}" -f "${HOME}"/.ssh/id_ed25519 -N ""
fi

# check if work ssh key already exists
if [[ -f "${HOME}/.ssh/id_ed25519_work" ]]; then
  echo "Work SSH Key already exists. Skipping SSH Key Generation."
else
  echo "Generating a new work SSH key..."

  # generate ssh keys for work projects 
  ssh-keygen -q -t ed25519 -C "${WORK_EMAIL}" -f "${HOME}"/.ssh/id_ed25519_work -N ""
fi

# start ssh-agent in the background
eval "$(ssh-agent -s)"

# remove and create fresh config file
if [[ -f "${HOME}/.ssh/config" ]]; then
  sudo rm "${HOME}/.ssh/config"
fi

touch ~/.ssh/config
printf "Host github.com\n Hostname github.com\n User git\n AddKeysToAgent yes\n UseKeychain yes\n IdentityFile ~/.ssh/id_ed25519\n\n" | tee -a ~/.ssh/config >/dev/null
printf "Host git.charlotte.edu\n Hostname git.charlotte.edu\n User git\n AddKeysToAgent yes\n UseKeychain yes\n IdentityFile ~/.ssh/id_ed25519_work\n" | tee -a ~/.ssh/config >/dev/null
printf "Host git.uncc.edu\n Hostname git.uncc.edu\n User git\n AddKeysToAgent yes\n UseKeychain yes\n IdentityFile ~/.ssh/id_ed25519_work\n" | tee -a ~/.ssh/config >/dev/null

# add ssh key
sudo ssh-add "${HOME}"/.ssh/id_ed25519
sudo ssh-add "${HOME}"/.ssh/id_ed25519_work

# print public key to add for PERSONAL
echo "Personal Public Key:"
cat "${HOME}"/.ssh/id_ed25519.pub

# print public key to add for WORK
echo "Work Public Key:"
cat "${HOME}"/.ssh/id_ed25519_work.pub