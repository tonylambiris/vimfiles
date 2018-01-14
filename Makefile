VIMPLUG?=https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

all: install theme

reinstall: remove all

install:
	@echo "Fetching vim-plug and plug-ins..."
	@mkdir -p ~/.config/nvim ~/.local/share/nvim
	@curl -sfLo ~/.config/nvim/autoload/plug.vim --create-dirs $(VIMPLUG)
	@nvim -u NORC '+so ~/.vim/vimrc | PlugInstall! | qall!'
	@ln -sf ~/.vim/vimrc ~/.config/nvim/init.vim
	@echo "Installation successful!"

update:
	@echo "Updating vim-plug and plug-ins..."
	@nvim -u NORC '+so ~/.vim/vimrc | PlugUpdate! | qall!'
	@echo "Update successful!"

clean:
	@echo "Cleaning any unused plug-ins..."
	@nvim -u NORC '+so ~/.vim/vimrc | PlugClean! | qall!'
	@echo "Clean successful!"

remove:
	@while [ -z "$$CONTINUE" ]; do \
		read -r -p "Remove vim-plug and all plug-ins? [y/N] " CONTINUE; \
		done ; \
		if [ $$CONTINUE == "y" ] || [ $$CONTINUE == "Y" ]; then \
		echo "Removing vim-plug and all plug-ins..."; \
		rm -rf ~/.config/nvim ~/.local/share/nvim; \
		fi

themes:
	@echo "Available themes:"
	@find ~/.local/share/nvim -type d -name colors -exec find "{}" -type f -name '*.vim' \; | xargs -n 1 basename | cut -d '.' -f 1 | sort -u | column
	@echo
	@echo "Available lightline colorschemes:"
	@find ~/.local/share/nvim -type d -name colorscheme -exec find "{}" -type f -name '*.vim' \; | xargs -n 1 basename | cut -d '.' -f 1 | sort -u | column

theme: themecheck
	@sed -e "s|%COLORSCHEME%|$(COLORSCHEME)|g" colorscheme.vim.in > colorscheme.vim
	@echo "Successfully set colorscheme to $(COLORSCHEME)!"

themecheck:
	@echo "Available themes can be listed by runnning: make themes"
	@echo
ifeq ($(COLORSCHEME),)
	@echo "Themes can be changed by running: make COLORSCHEME=<somescheme> theme"
	@echo
else
	@find ~/.local/share/nvim -type d -name colors -exec find "{}" -type f -name '*.vim' \; | xargs -n 1 basename | cut -d '.' -f 1 | sort -u | grep -q $(COLORSCHEME)
endif
COLORSCHEME?=hydrangea

.PHONY: all
