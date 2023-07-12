SHELL        	:= /bin/bash
DOTFILES_DIR 	:= $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
PATH 			:= $(DOTFILES_DIR)/bin:$(PATH)
OS 				:= $(shell bin/is-supported bin/is-macos macos linux)
HOMEBREW_PREFIX := $(shell bin/is-supported bin/is-macos $(shell bin/is-supported bin/is-arm64 /opt/homebrew /usr/local) /home/linuxbrew/.linuxbrew)
SHELLS 			:= /private/etc/shells
BIN 			:= $(HOMEBREW_PREFIX)/bin
OHMYZSH         := $(HOME)/.oh-my-zsh
ZSH_CUSTOM		:= $(OHMYZSH)/custom

export XDG_CONFIG_HOME = $(HOME)/.config
export ACCEPT_EULA=Y


all: $(OS)

macos: sudo core-macos brew packages vscode-ext python link
	@$(DOTFILES_DIR)/macos/dock.sh
	@$(DOTFILES_DIR)/macos/set-prefs.sh

linux: core-linux link

brew:
ifeq ($(shell which brew),)
	@printf "Homebrew not detected; running install script\\n"
	NONINTERACTIVE=1 /bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
	@printf "Homebrew already installed; skipping installation\\n"
endif

core-macos: | $(OHMYZSH)
	@$(DOTFILES_DIR)/dockutil/install.sh
	@$(DOTFILES_DIR)/macos/install.sh

core-linux:
	apt-get update
	apt-get upgrade -y
	apt-get dist-upgrade -f

stow-macos: brew
	is-executable stow || brew install stow

stow-linux: core-linux
	is-executable stow || apt-get -y install stow

link: stow-$(OS)
	for FILE in $$(\ls -A runcom); do if [ -f $(HOME)/$$FILE -a ! -h $(HOME)/$$FILE ]; then \
		mv -v $(HOME)/$$FILE{,.bak}; fi; done
	$(BIN)/stow -t $(HOME) runcom
	$(BIN)/stow -t $(HOME) git
	$(BIN)/stow -t $(HOME) mackup
	$(BIN)/stow -t $(HOME)/.config topgrade

unlink: stow-$(OS)
	$(BIN)/stow --delete -t $(HOME) runcom
	$(BIN)/stow --delete -t $(HOME) git
	$(BIN)/stow --delete -t $(HOME) mackup
	$(BIN)/stow --delete -t $(HOME)/.config topgrade
	for FILE in $$(\ls -A runcom); do if [ -f $(HOME)/$$FILE.bak ]; then \
		mv -v $(HOME)/$$FILE.bak $(HOME)/$${FILE%%.bak}; fi; done

packages: brew
	$(BIN)/brew bundle --file=$(DOTFILES_DIR)/brew/Brewfile || true
	$(BIN)/brew bundle --file=$(DOTFILES_DIR)/brew/Caskfile || true
	mkdir -p $(HOME)/.docker/cli-plugins
	ln -sfn /opt/homebrew/opt/docker-compose/bin/docker-compose $(HOME)/.docker/cli-plugins/docker-compose
	curl -L "https://packagecontrol.io/Package%20Control.sublime-package" \
		-o $(HOME)/Library/Application\ Support/Sublime\ Text/Installed\ Packages/Package\ Control.sublime-package

pecl: 
	pecl install redis apcu
python: brew
	is-executable pyenv || brew install pyenv
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

.PHONY: brew macos linux core-macos core-linux packages python vscode-ext link unlink sudo