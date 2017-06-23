VIMPLUG?=https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

all: install

install:
	@echo "Fetching vim-plug and plug-ins..."
	@mkdir -p ~/.config/nvim ~/.local/share/nvim
	@curl -sfLo ~/.config/nvim/autoload/plug.vim --create-dirs $(VIMPLUG)
	@nvim -u NONE '+so ~/.vim/vimrc | PlugInstall! | qall!'
	@cp -f ycm_extra_conf.py ~/.local/share/nvim/plugged/YouCompleteMe/.ycm_extra_conf.py
	@echo .ycm_extra_conf.py >> ~/.local/share/nvim/plugged/YouCompleteMe/.git/info/exclude
	@ln -sf ~/.vim/vimrc ~/.config/nvim/init.vim
	@echo "Installation successful!"

.PHONY: all
