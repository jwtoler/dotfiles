.DEFAULT_GOAL	:= help
SHELL        	:= /bin/bash
DOTFILES_DIR 	:= $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
PATH 			:= $(DOTFILES_DIR)/bin:$(PATH)
OS 				:= $(shell bin/is-supported bin/is-macos macos linux)
HOMEBREW_PREFIX := $(shell bin/is-supported bin/is-macos $(shell bin/is-supported bin/is-arm64 /opt/homebrew /usr/local) /home/linuxbrew/.linuxbrew)
SHELLS 			:= /private/etc/shells
BIN 			:= $(HOMEBREW_PREFIX)/bin
OHMYZSH         := $(HOME)/.oh-my-zsh
ZSH_CUSTOM		:= $(OHMYZSH)/custom
PECL_MODULES	:= redis apcu

export ACCEPT_EULA=Y

.PHONY: brew macos linux core-macos core-linux packages python vscode-ext link unlink sudo

help:
	@printf "\\n\
	\\033[1mDOTFILES\\033[0m\\n\
	\\n\
	Custom settings and configurations for Unix-like environments.\\n\
	See README.md for detailed usage information.\\n\
	\\n\
	\\033[1mUSAGE:\\033[0m make [target]\\n\
	\\n\
	  make         Install all configurations and applications.\\n\
	\\n\
	"

all: $(OS)

macos: sudo core-macos brew packages vscode-ext pecl nodejs python link
	@$(DOTFILES_DIR)/macos/dock.sh
	@$(DOTFILES_DIR)/macos/set-prefs.sh

linux: core-linux link

core-macos: | $(OHMYZSH)
	@$(DOTFILES_DIR)/dockutil/install.sh
	@$(DOTFILES_DIR)/macos/install.sh

core-linux:
	@apt-get update
	@apt-get upgrade -y
	@apt-get dist-upgrade -f

stow-macos:
	@is-executable stow || brew install stow

stow-linux: core-linux
	@is-executable stow || apt-get -y install stow

link: stow-$(OS)
	@mkdir -p $(HOME)/.hammerspoon
	@mkdir -p $(HOME)/.config/{borders,sketchybar,starship,wezterm}
	@for FILE in $$(\ls -A runcom); do if [ -f $(HOME)/$$FILE -a ! -h $(HOME)/$$FILE ]; then \
		mv -v $(HOME)/$$FILE{,.bak}; fi; done
	@$(BIN)/stow -t $(HOME) runcom
	@$(BIN)/stow -t $(HOME) git
	@$(BIN)/stow -t $(HOME) mackup
	@$(BIN)/stow -t $(HOME)/.hammerspoon hammerspoon
	@$(BIN)/stow -t $(HOME)/.config aerospace
	@$(BIN)/stow -t $(HOME)/.config topgrade
	@$(BIN)/stow -t $(HOME)/.config/borders borders
	@$(BIN)/stow -t $(HOME)/.config/sketchybar sketchybar
	@$(BIN)/stow -t $(HOME)/.config/starship starship
	@$(BIN)/stow -t $(HOME)/.config/wezterm wezterm

unlink: stow-$(OS)
	@$(BIN)/stow --delete -t $(HOME) runcom
	@$(BIN)/stow --delete -t $(HOME) git
	@$(BIN)/stow --delete -t $(HOME) mackup
	@$(BIN)/stow --delete -t $(HOME)/.hammerspoon hammerspoon
	@$(BIN)/stow --delete -t $(HOME)/.config aerospace
	@$(BIN)/stow --delete -t $(HOME)/.config topgrade
	@$(BIN)/stow --delete -t $(HOME)/.config/borders borders
	@$(BIN)/stow --delete -t $(HOME)/.config/sketchybar sketchybar
	@$(BIN)/stow --delete -t $(HOME)/.config/starship starship
	@$(BIN)/stow --delete -t $(HOME)/.config/wezterm wezterm
	@for FILE in $$(\ls -A runcom); do if [ -f $(HOME)/$$FILE.bak ]; then \
		mv -v $(HOME)/$$FILE.bak $(HOME)/$${FILE%%.bak}; fi; done

packages:
	@mkdir -p $(HOME)/.docker/cli-plugins
	@ln -sfn /opt/homebrew/opt/docker-compose/bin/docker-compose $(HOME)/.docker/cli-plugins/docker-compose
	@curl -L "https://packagecontrol.io/Package%20Control.sublime-package" \
		-o $(HOME)/Library/Application\ Support/Sublime\ Text/Installed\ Packages/Package\ Control.sublime-package

nodejs: 
	@is-executable n || brew install n
	@n latest

pecl: 
	@for module in $(PECL_MODULES); do \
		if pecl info $$module &>/dev/null; then \
			printf '%s already installed\n' $$module; \
		else \
			if echo | CFLAGS=-I/opt/homebrew/include pecl -q install $$module &>/dev/null ; then \
				printf '%s installed successfully\n' $$module; \
			else \
				printf "ERROR: trying to install %s\n" $$module; \
			fi; \
		fi; \
	done 

python:
	@is-executable pyenv || brew install pyenv
	@$(DOTFILES_DIR)/python/install.sh

vscode-ext:
	cat ${DOTFILES_DIR}/vscode/Codefile | xargs -L 1 code --force --install-extension

sudo:
ifndef GITHUB_ACTION
	sudo -v
	while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
endif

$(OHMYZSH):
	@printf "Installing Oh My Zsh..."
	sh -c "$$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
	@printf "Installing alias-tips..."
	git clone https://github.com/djui/alias-tips.git $(ZSH_CUSTOM)/plugins/alias-tips
	@printf "Installing zsh-autosuggestions..."
	git clone https://github.com/zsh-users/zsh-autosuggestions $(ZSH_CUSTOM)/plugins/zsh-autosuggestions
	@printf "Installing zsh-syntax-highlighting..."
	git clone https://github.com/zsh-users/zsh-syntax-highlighting $(ZSH_CUSTOM)/plugins/zsh-syntax-highlighting
	@printf "Installing powerlevel10k..."
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $(ZSH_CUSTOM)/themes/powerlevel10k

