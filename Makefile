VIMPLUG?=https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

all: install theme

reinstall: remove all

install:
	@echo "Fetching vim-plug and plug-ins..."
	@mkdir -p ~/.config/nvim ~/.local/share/nvim
	@curl -sfLo ~/.config/nvim/autoload/plug.vim --create-dirs $(VIMPLUG)
	@nvim -u NONE '+so ~/.vim/vimrc | PlugInstall! | qall!'
	@cp -f ycm_extra_conf.py ~/.local/share/nvim/plugged/YouCompleteMe/.ycm_extra_conf.py
	@echo .ycm_extra_conf.py >> ~/.local/share/nvim/plugged/YouCompleteMe/.git/info/exclude
	@ln -sf ~/.vim/vimrc ~/.config/nvim/init.vim
	@echo "Installation successful!"

update:
	@echo "Updating vim-plug and plug-ins..."
	@nvim '+so ~/.vim/vimrc | PlugUpdate! | qall!'
	@echo "Update successful!"

clean:
	@echo "Cleaning any unused plug-ins..."
	@nvim '+so ~/.vim/vimrc | PlugClean! | qall!'
	@echo "Clean successful!"

remove:
	@while [ -z "$$CONTINUE" ]; do \
		read -r -p "Remove vim-plug and all plug-ins? [y/N] " CONTINUE; \
		done ; \
		if [ $$CONTINUE == "y" ] || [ $$CONTINUE == "Y" ]; then \
		echo "Removing vim-plug and all plug-ins..."; \
		rm -rf ~/.config/nvim ~/.local/share/nvim; \
		fi

# find ~/.local/share/nvim -name 'colors' | xargs ls *.vim
theme: themecheck
	@sed -re "s|%COLORSCHEME%|$(COLORSCHEME)|g" colorscheme.vim.in > colorscheme.vim
	@echo "Successfully set colorscheme to $(COLORSCHEME)!"

themecheck:
ifeq ($(COLORSCHEME),)
	@echo
	@echo "Themes can be changed by running the following:"
	@echo "make COLORSCHEME=<somescheme> theme"
	@echo
endif
COLORSCHEME?=hydrangea

.PHONY: all
