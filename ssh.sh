  #!/bin/sh

PERSONAL_EMAIL=jwtoler@gmail.com
WORK_EMAIL=jtoler5@charlotte.edu

# Create default .ssh directory if it doesn’t exist
if [[ ! -d "${HOME}/.ssh/" ]]; then
  mkdir "${HOME}/.ssh/"
  chmod 700 "${HOME}/.ssh/"
fi

# Check if personal ssh key already exists, otherwise create
if [[ -f "${HOME}/.ssh/id_ed25519" ]]; then
  echo "Personal SSH Key already exists. Skipping SSH Key Generation."
else
  echo "Generating a new personal SSH key..."
  ssh-keygen -q -t ed25519 -C "${PERSONAL_EMAIL}" -f "${HOME}"/.ssh/id_ed25519 -N ""
fi

# Check if work ssh key already exists, otherwise create
if [[ -f "${HOME}/.ssh/id_ed25519_work" ]]; then
  echo "Work SSH Key already exists. Skipping SSH Key Generation."
else
  echo "Generating a new work SSH key..."
  ssh-keygen -q -t ed25519 -C "${WORK_EMAIL}" -f "${HOME}"/.ssh/id_ed25519_work -N ""
fi

# Start ssh-agent in the background
eval "$(ssh-agent -s)"

# Remove and create fresh config file
if [[ -f "${HOME}/.ssh/config" ]]; then
  sudo rm "${HOME}/.ssh/config"
fi

touch ~/.ssh/config
printf "Host work_gh \n
        Hostname github.com \n
        IdentityFile ~/.ssh/id_ed25519_work \n
        IdentitiesOnly yes \n
        AddKeysToAgent yes \n
        UseKeychain yes \n
        ForwardAgent yes \n\n" | tee -a ~/.ssh/config >/dev/null

# Add ssh key
sudo ssh-add "${HOME}"/.ssh/id_ed25519
sudo ssh-add "${HOME}"/.ssh/id_ed25519_work

# Print public key to add for PERSONAL
printf "Personal Public Key (%s):" "$PERSONAL_EMAIL"
cat "${HOME}"/.ssh/id_ed25519.pub

# Print public key to add for WORK
printf "Work Public Key (%s):" "$WORK_EMAIL"
cat "${HOME}"/.ssh/id_ed25519_work.pub