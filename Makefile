VIMPLUG?=https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

all: install

install:
	@echo "Fetching vim-plug and plug-ins..."
	@curl -sfLo ~/.config/nvim/autoload/plug.vim --create-dirs $(VIMPLUG)
	@nvim -u NONE '+so ~/.vim/vimrc | PlugInstall! | qall!'
	@ln -sf ~/.vim/vimrc ~/.config/nvim/init.vim
	@echo "Installation successful!"

.PHONY: all
