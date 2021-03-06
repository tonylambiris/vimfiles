VIMPLUG?=https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
COLORSCHEME?=

all: install clean theme

reinstall: remove all

install:
	@echo "Fetching vim-plug and plug-ins..."
	@mkdir -p ~/.config/nvim ~/.local/share/nvim
	@curl -sfLo ~/.config/nvim/autoload/plug.vim --create-dirs $(VIMPLUG)
	@nvim -u NORC '+so ~/.vim/vimrc | PlugInstall | qa!'
	@ln -sf ~/.vim/vimrc ~/.config/nvim/init.vim
	@echo "Installation successful!"

update:
	@echo "Updating vim-plug and plug-ins..."
	@nvim --headless +PlugUpdate +PlugUpgrade +GoUpdateBinaries +qa
	@echo "Update successful!"

clean:
	@echo "Cleaning any unused plug-ins..."
	@nvim -u NORC '+so ~/.vim/vimrc | PlugClean | qa!'
	@echo "Clean successful!"

remove:
	@while [ -z "$$CONTINUE" ]; do \
		read -r -p "Remove vim-plug and all plug-ins? [y/N] " CONTINUE; \
		done ; \
		if [ $$CONTINUE == "y" ] || [ $$CONTINUE == "Y" ]; then \
		echo "Removing vim-plug and all plug-ins..."; \
		rm -rf ~/.config/nvim ~/.local/share/nvim; \
		fi

themes: theme

ifeq ($(COLORSCHEME),)
theme:
	@echo
	@echo "Available neovim colorschemes:"
	@echo "--------------------------------------------------------------------------------"
	@find ~/.local/share/nvim -type d -name colors -exec find "{}" -type f -name '*.vim' \; | xargs -n 1 basename | cut -d '.' -f 1 | sort -u | column
	@echo
	@echo "Available lightline themes:"
	@echo "--------------------------------------------------------------------------------"
	@find ~/.local/share/nvim -type d -name colorscheme -exec find "{}" -type f -name '*.vim' \; | xargs -n 1 basename | cut -d '.' -f 1 | sort -u | column
	@echo
	@echo ">> Available themes can be listed by runnning: make themes"
	@echo ">> Themes can be changed by running: make theme COLORSCHEME=<somescheme>"
	@echo
	@if [ -f "colorscheme.vim" ]; then \
		echo -n "Currently configured: "; \
		head -1 colorscheme.vim | awk '{print $$2}'; \
		fi
else
theme: themecheck
	@sed -e "s|%COLORSCHEME%|$(COLORSCHEME)|g" colorscheme.vim.in > colorscheme.vim
	@echo "Successfully set colorscheme to $(COLORSCHEME)!"
	@find ~/.local/share/nvim -type d -name colorscheme | grep -q $(COLORSCHEME) || \
		echo "NOTE: You will need to manually set a lightline theme in colorscheme.vim"
themecheck:
	@find ~/.local/share/nvim -type d -name colors -exec find "{}" -type f -name '*.vim' \; | xargs -n 1 basename | cut -d '.' -f 1 | sort -u | grep -q $(COLORSCHEME)
endif

.PHONY: all
