VIMPLUG?=https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

all: install

install:
	@echo "Fetching vim-plug and installing all plug-ins"
	@curl -sfLo ~/.vim/autoload/plug.vim --create-dirs $(VIMPLUG)
	@vim '+let g:plug_window="new" | PlugInstall'

.PHONY: all
