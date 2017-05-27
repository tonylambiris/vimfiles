VIMPLUG?=https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

all: install

install:
	@echo "Fetching vim-plug and plug-ins..."
	@curl -sfLo ~/.vim/autoload/plug.vim --create-dirs $(VIMPLUG)
	@vim -u NONE '+so ~/.vim/vimrc | PlugInstall | qall!'
	@echo "Installation successful!"

.PHONY: all
