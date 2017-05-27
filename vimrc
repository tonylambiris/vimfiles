" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'

" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
Plug 'fatih/vim-go', { 'tag': '*', 'do': ':GoInstallBinaries' }

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

Plug 'Shougo/vimproc.vim', { 'do': 'make' }

Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }

Plug 'vim-airline/vim-airline'

Plug 'airblade/vim-gitgutter'

Plug 'tpope/vim-fugitive'

Plug 'whatyouhide/vim-lengthmatters'

Plug 'ntpeters/vim-better-whitespace'

Plug 'roman/golden-ratio'

Plug 'mhartington/oceanic-next'

call plug#end()

" ----------[ oceanic-next
syntax enable
if (has("termguicolors"))
  set termguicolors " for vim 8
else
  set t_Co=256 " for vim 7
endif
colorscheme OceanicNext

" ----------[ nerdtree
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeWinPos = 'right'

" ----------[ vim-airline
let g:airline_theme = 'oceanicnext'
let g:airline_powerline_fonts = 1

" ----------[ vim-go
let g:go_list_type = "quickfix"
let g:go_fmt_command = "goimports"
let g:go_fmt_autosave = 1
let g:go_fmt_fail_silently = 0
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1

" ----------[ vim-lengthmatters
call lengthmatters#highlight_link_to('TooLong')
let g:lengthmatters_on_by_default = 1

" ----------[ vim-gitgutter
let g:gitgutter_diff_args = '-w' "ignore whitespace

" ----------[ vimrc settings
set number
set title
set noerrorbells
set textwidth=80
set colorcolumn=+1
set mouse=a
set ttymouse=xterm2
set ttyfast
set guioptions+=a
set clipboard=unnamedplus
set undofile
set undodir=~/.vim/undodir
set splitbelow
set splitright

" highlight all matched words on search, clear highlights with space key
nnoremap <silent><space> :nohlsearch<CR>

" copy highlighted text in mouse mode
vmap <C-C> "+y"<CR>

" detach to a shell in normal mode
nmap <C-D> :sh<CR>

" Map plus/minus for window sizing
if bufwinnr(1)
  map + <C-W>+
  map - <C-W>-
  map <Tab> <C-W>w
endif

" Don't expand tabs when editing Makefiles
autocmd FileType make setlocal noexpandtab

" Trim spurious whitespaces on save
autocmd BufEnter * EnableStripWhitespaceOnSave
