SHELL        	:= /bin/bash
DOTFILES_DIR 	:= $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
PATH 			:= $(DOTFILES_DIR)/bin:$(PATH)
OS 				:= $(shell bin/is-supported bin/is-macos macos linux)
HOMEBREW_PREFIX := $(shell bin/is-supported bin/is-macos $(shell bin/is-supported bin/is-arm64 /opt/homebrew /usr/local) /home/linuxbrew/.linuxbrew)
SHELLS 			:= /private/etc/shells
BIN 			:= $(HOMEBREW_PREFIX)/bin


.PHONY: brew macos linux core-macos core-linux link unlink

all: $(OS)

macos: sudo core-macos brew packages iterm link
	@$(DOTFILES_DIR)/macos/dock.sh
	@$(DOTFILES_DIR)/macos/defaults.sh

linux: core-linux link

brew:
ifeq ($(shell which brew),)
	@printf "Homebrew not detected; running install script\\n"
	NONINTERACTIVE=1 /bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
	@printf "Homebrew already installed; skipping installation\\n"
endif

core-macos:
	@$(DOTFILES_DIR)/macos/install.sh
	is-executable stow || brew install stow
	oh-my-zsh

core-linux:
	apt-get update
	apt-get upgrade -y
	apt-get dist-upgrade -f
	is-executable stow || apt-get -y install stow

iterm:
	curl -L https://iterm2.com/shell_integration/zsh -o ~/.iterm2_shell_integration.zsh

link: 
	for FILE in $$(\ls -A runcom); do if [ -f $(HOME)/$$FILE -a ! -h $(HOME)/$$FILE ]; then \
		mv -v $(HOME)/$$FILE{,.bak}; fi; done
	for FILE in $$(\ls -A git); do if [ -f $(HOME)/$$FILE -a ! -h $(HOME)/$$FILE ]; then \
		mv -v $(HOME)/$$FILE{,.bak}; fi; done
	$(BIN)/stow -t $(HOME) runcom
	$(BIN)/stow -t $(HOME) git

unlink: 
	$(BIN)/stow --delete -t $(HOME) runcom
	$(BIN)/stow --delete -t $(HOME) git
	for FILE in $$(\ls -A runcom); do if [ -f $(HOME)/$$FILE.bak ]; then \
		mv -v $(HOME)/$$FILE.bak $(HOME)/$${FILE%%.bak}; fi; done
	or FILE in $$(\ls -A git); do if [ -f $(HOME)/$$FILE.bak ]; then \
		mv -v $(HOME)/$$FILE.bak $(HOME)/$${FILE%%.bak}; fi; done

oh-my-zsh:
	@printf "Installing Oh My Zsh...";
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

packages: brew
	$(BIN)/brew bundle --file=$(DOTFILES_DIR)/brew/Brewfile || true
	$(BIN)/brew bundle --file=$(DOTFILES_DIR)/brew/Caskfile || true
	for EXT in $$(cat vscode/Codefile); do code --install-extension $$EXT; done

sudo:
ifndef GITHUB_ACTION
	sudo -v
	while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
endif

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
