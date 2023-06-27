DOTFILES_DIR 	:= $(shell echo $(HOME)/.config)
SHELL        	:= /bin/sh
OS 				:= $(shell bin/is-supported bin/is-macos macos linux)
HOMEBREW_PREFIX := $(shell bin/is-supported bin/is-macos $(shell bin/is-supported bin/is-arm64 /opt/homebrew /usr/local) /home/linuxbrew/.linuxbrew)
SHELLS 			:= /private/etc/shells
BIN 			:= $(HOMEBREW_PREFIX)/bin

iterm:
	curl -L https://iterm2.com/shell_integration/zsh -o ~/.iterm2_shell_integration.zsh


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
