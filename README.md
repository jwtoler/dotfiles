## A Fresh macOS Setup

These instructions are for setting up new Mac devices. Instead, if you want to get started building your own dotfiles, you can [find those instructions below](#your-own-dotfiles).

### Setting up your Mac

After backing up your old Mac you may now follow these install instructions to setup a new one.

1. [Generate a new SSH key & add to GitHub profile](https://docs.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent) by running:

   ```zsh
   curl https://raw.githubusercontent.com/jwtoler/dotfiles/HEAD/ssh.sh | sh
   ```

2. Clone this repo to `~/.dotfiles` with:

    ```zsh
    git clone git@github.com:jwtoler/dotfiles.git ~/.dotfiles
    ```

3. Run the installation with:

    ```zsh
    cd ~/.dotfiles && make
    ```

4. Restart your computer to finalize the process

Your Mac is now ready to use!

> 💡 You can use a different location than `~/.dotfiles` if you want. Make sure you also update the reference in the [`.zshrc`](./.zshrc#L2) file.