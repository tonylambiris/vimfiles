" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.local/share/nvim/plugged/')

Plug 'tpope/vim-sensible'

" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
Plug 'fatih/vim-go', { 'tag': '*', 'do': ':GoInstallBinaries' }

" On-demand loading
"Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'scrooloose/nerdtree'

Plug 'Shougo/vimproc.vim', { 'do': 'make' }

Plug 'Valloric/YouCompleteMe', { 'do': './install.py --all' }

Plug 'vim-airline/vim-airline'

Plug 'vim-airline/vim-airline-themes'

Plug 'airblade/vim-gitgutter'

Plug 'tpope/vim-fugitive'

Plug 'whatyouhide/vim-lengthmatters'

Plug 'ntpeters/vim-better-whitespace'

Plug 'roman/golden-ratio'

Plug 'mhartington/oceanic-next'

Plug 'sheerun/vim-polyglot'

Plug 'majutsushi/tagbar'

Plug 'flazz/vim-colorschemes'

Plug 'KeitaNakamura/neodark.vim'

"Plug 'ryanoasis/vim-devicons'

call plug#end()

" =====================================
"             General Configuration
" =====================================
if !exists('g:encoding_set') || !has('nvim')
    set encoding=utf8
    let g:encoding_set = 1
endif

" after a re-source, fix syntax matching issues
if exists('g:loaded_webdevicons')
    call webdevicons#refresh()
endif

" ----------[ vim-airline
let g:airline_theme = 'neodark'
let g:airline_powerline_fonts = 1

" old vim-powerline symbols
"let g:airline_left_sep = '⮀'
"let g:airline_left_alt_sep = '⮁'
"let g:airline_right_sep = '⮂'
"let g:airline_right_alt_sep = '⮃'
"let g:airline_symbols.branch = '⭠'
"let g:airline_symbols.readonly = '⭤'
"let g:airline_symbols.linenr = '⭡'

" ----------[ nerdtree
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeWinPos = 'right'

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

" Remember last cursor position
autocmd BufReadPost * if @% !~# '\.git[\/\\]COMMIT_EDITMSG$' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" Don't expand tabs when editing Makefiles
autocmd FileType make setlocal noexpandtab

" Trim spurious whitespaces on save
autocmd BufEnter * EnableStripWhitespaceOnSave

" ----------[ various settings
set number
set mouse=a

set splitbelow
set splitright

set background=dark

" Let vim use the system clipboard
set clipboard^=unnamedplus,unnamed

" turn on undo files, put them in a common location
set undofile
set undodir=~/.vim/undo/

" Maintain hidden buffers
set hidden

set history=1000

" make backspace sane
set backspace=indent,eol,start

" Wrapping
"set textwidth=79
set textwidth=80
set colorcolumn=+1
set wrap                    " turn on line wrapping
set wrapmargin=5            " wrap lines when coming within n characters from side
set linebreak               " set soft wrapping
set showbreak=…             " show ellipsis at breaking

" Indenting
set autoindent              " automatically set indent of new line
set smartindent

" Tabs and spaces
set noexpandtab             " insert tabs rather than spaces for <Tab>
set smarttab                " tab respects 'tabstop', 'shiftwidth', and 'softtabstop'
set tabstop=4               " the visible width of tabs
set softtabstop=4           " edit as if the tabs are 4 characters wide
set shiftwidth=4            " number of spaces to use for indent and unindent
set shiftround              " round indent to a multiple of 'shiftwidth'

" Misc.
set ttyfast                 " faster redrawing
set laststatus=2            " show the satus line all the time
set so=7                    " set 7 lines to the cursors - when moving vertical
set wildmenu                " enhanced command line completion
set showcmd                 " show incomplete commands
set noshowmode              " don't show which mode disabled for PowerLine
set wildmode=list:longest   " complete files like a shell
set scrolloff=3             " lines of text around cursor
set shell=$SHELL
set cmdheight=1             " command bar height
set title                   " set terminal title

" Searching
set ignorecase              " case insensitive searching
set smartcase               " case-sensitive if expresson contains a capital letter
set hlsearch                " highlight search results
set incsearch               " set incremental search, like modern browsers
set nolazyredraw            " don't redraw while executing macros
set magic

set showmatch               " show matching braces
set mat=2                   " how many tenths of a second to blink

" No error bells
set noerrorbells
set visualbell

" Get rid of the delay when pressing O (for example)
" http://stackoverflow.com/questions/2158516/vim-delay-before-o-opens-a-new-line
set timeout timeoutlen=1000 ttimeoutlen=100

" =====================================
"                  Interface
" =====================================

" toggle invisible characters off by default
set nolist
set listchars=tab:→\ ,eol:¬,trail:⋅,extends:❯,precedes:❮
set showbreak=↪

" replace the default box drawing characters
set fillchars=vert:│,fold:─,diff:─

" =====================================
"                   Mappings
" =====================================

" Space as leader
let mapleader = ','

" Move around viewports
nnoremap <A-h> <C-W>h
nnoremap <A-j> <C-W>j
nnoremap <A-k> <C-W>k
nnoremap <A-l> <C-W>l

" Handy remap to get out of insert mode
inoremap jk <Esc>

" Remove search highlighting
nnoremap <silent> jk :noh<cr>

" Remove search highlighting
cnoremap <silent> jk <Esc>

" Run make in current directory
nnoremap <silent> <leader>m :make!<cr>

" Toggle list symbols
nnoremap <silent> <leader>l :set list!<cr>

" Toggle relative numbers
nnoremap <silent> <leader>n :set relativenumber!<cr>

" Make Y move like D and C
noremap Y y$

" Quickly edit init.vim
"nnoremap <silent> <leader>ev :e ~/.config/nvim/init.vim<cr>

" Source init.vim
"nnoremap <silent> <leader>sv :so ~/.config/nvim/init.vim<cr>

" Quickly edit plugins
"nnoremap <silent> <leader>ep :e ~/.config/nvim/plugins.vim<cr>

" Scroll viewport
nnoremap <PageUp> 5<C-y>
nnoremap <PageDown> 5<C-e>
inoremap <PageUp> <Esc>5<C-y>
inoremap <PageDown> <Esc>5<C-e>

" Re-highlight indented selection
vnoremap < <gv
vnoremap > >gv

" Improve up and down movement on wrapped lines
nnoremap j gj
nnoremap k gk

" Keep search pattern at center of screen
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz
nnoremap <silent> g# g#zz

" Search for word under cursor
nnoremap <leader>/ "fyiw :/<c-r>f<cr>

" =====================================
"               Plugin: NERDTree
" =====================================

"let g:WebDevIconsOS = 'Darwin'
"let g:webdevicons_enable = 1

" Toggle NerdTree
nnoremap <silent> <leader>k :NERDTreeToggle<cr>

" Show hidden files
let NERDTreeShowHidden = 1

"webdevicons图标
"let g:WebDevIconsUnicodeDecorateFolderNodes = 1
"let g:WebDevIconsUnicodeDecorateFolderNodeDefaultSymbol = ''

" let g:NERDTreeFileExtensionHighlightFullName = 1
" let g:NERDTreeExactMatchHighlightFullName = 1
" let g:NERDTreePatternMatchHighlightFullName = 1

"let g:WebDevIconsNerdTreeAfterGlyphPadding = '  '

let g:NERDTreeHighlightFolders = 1 " enables folder icon highlighting using exact match
let g:NERDTreeHighlightFoldersFullName = 1 " highlights the folder name

hi Directory guifg=#689d6a

" Close if only window open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" =====================================
"               Plugin: Fugitive
" =====================================

" git status
nnoremap <leader>gs :Gstatus<cr>

" git add .
nnoremap <leader>ga :Git add .<cr><cr>

" git commit -v -q - verbose and quiet
nnoremap <leader>gc :Gcommit -v -q<cr>

" git log - opens in quickfix windows to navigate to commits
nnoremap <silent> <leader>gl :silent! Glog<cr>:bot copen<cr>

" =====================================
"                Plugin: Tagbar
" =====================================

" Toggle Tagbar
nnoremap <silent> <leader>t :TagbarToggle<CR>

if (has("nvim"))
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

if (has("termguicolors")) && &termguicolors " set true colors
  set termguicolors
endif

syntax enable
colorscheme neodark
