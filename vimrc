" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.local/share/nvim/plugged/')

" Plugins
Plug 'tpope/vim-sensible'
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'scrooloose/nerdtree'
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --all' }
Plug 'vim-syntastic/syntastic'
Plug 'itchyny/lightline.vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'whatyouhide/vim-lengthmatters'
Plug 'ntpeters/vim-better-whitespace'
Plug 'roman/golden-ratio'
Plug 'sheerun/vim-polyglot'
Plug 'majutsushi/tagbar'
Plug 'sjl/clam.vim'
Plug 'yuttie/comfortable-motion.vim'
Plug 'romainl/vim-qf'
"Plug 'ryanoasis/vim-devicons'

" Themes
Plug 'flazz/vim-colorschemes'
Plug 'mhartington/oceanic-next'
Plug 'KeitaNakamura/neodark.vim'
Plug 'jackiehluo/vim-material'
Plug 'tyrannicaltoucan/vim-quantum'
Plug 'jacoborus/tender.vim'
Plug 'rakr/vim-one'
Plug 'yuttie/hydrangea-vim'

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
" nnoremap <leader>d :GitGutterLineHighlightsToggle -v -q<cr>
nmap <C-D> :GitGutterLineHighlightsToggle<CR>
let g:gitgutter_diff_args = '-w' " ignore whitespace
let g:gitgutter_grep_command = 'ag'
let g:gitgutter_max_signs = 500
let g:gitgutter_map_keys = 0

" ----------[ golden-ratio
let g:golden_ratio_autocommand = 0
let g:golden_ratio_exclude_nonmodifiable = 1

" ----------[ clam.vim
nnoremap ! :Clam<space>
vnoremap ! :ClamVisual<space>
let g:clam_winpos = 'botright'

" ----------[ YouCompleteMe
let g:ycm_filetype_blacklist = {
			\ 'tagbar' : 1,
			\ 'qf' : 1,
			\ 'notes' : 1,
			\ 'markdown' : 1,
			\ 'unite' : 1,
			\ 'text' : 1,
			\ 'vimwiki' : 1,
			\ 'pandoc' : 1,
			\ 'infolog' : 1,
			\ 'mail' : 1
			\}

" ----------[ comfortable-motion
nnoremap <silent> <silent> <PageDown> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * 2)<CR>
nnoremap <silent> <silent> <PageUp> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * -2)<CR>
noremap <silent> <ScrollWheelDown> :call comfortable_motion#flick(40)<CR>
noremap <silent> <ScrollWheelUp>   :call comfortable_motion#flick(-40)<CR>
let g:comfortable_motion_no_default_key_mappings = 1
let g:comfortable_motion_impulse_multiplier = 1  " Feel free to increase/decrease this value.

" highlight all matched words on search, clear highlights with space key
nnoremap <silent><space> :nohlsearch<CR>

" copy highlighted text in mouse mode
vmap <C-C> "+y"<CR>

" detach to the terminal shell
"nmap <C-D> :te<CR>

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

set signcolumn=yes

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

" comma as leader
let mapleader = ','

" Call YCM GoTo or vim-go GoTo depending on file type.
"function! GoToDef()
"	if &ft == 'go'
"		call go#def#Jump()
"	else
"		execute 'YcmCompleter GoTo'
"	endif
"endfunction

nnoremap <leader>] :call GoToDef()<CR>

" Display all leaders
nnoremap <silent> <leader>m :map ,<CR>

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
"nnoremap <silent> <leader>m :make!<cr>

" Toggle list symbols
nnoremap <silent> <leader>l :set list!<cr>

" Toggle relative numbers
nnoremap <silent> <leader>n :set relativenumber!<cr>

" Make Y move like D and C
noremap Y y$

" Reformat indentation and spacing
nnoremap <silent> <leader>r gg=G<CR>

" Quickly edit init.vim
"nnoremap <silent> <leader>ev :e ~/.config/nvim/init.vim<cr>

" Source init.vim
"nnoremap <silent> <leader>sv :so ~/.config/nvim/init.vim<cr>

" Source init.vim
nnoremap <silent> <leader>s :so ~/.config/nvim/init.vim<cr>

" Quickly edit plugins
"nnoremap <silent> <leader>ep :e ~/.config/nvim/plugins.vim<cr>

" Scroll viewport
"nnoremap <PageUp> 5<C-y>
"nnoremap <PageDown> 5<C-e>
"inoremap <PageUp> <Esc>5<C-y>
"inoremap <PageDown> <Esc>5<C-e>

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

" Disable automatic comment insertion
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

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

if (has("termguicolors")) " set true colors
	set termguicolors
endif

syntax enable

let $LOCALCONFIG = $HOME . "/.vim/localconfig.vim"
if filereadable($LOCALCONFIG)
	source $LOCALCONFIG
endif

let $COLORSCHEME = $HOME . "/.vim/colorscheme.vim"
if filereadable($COLORSCHEME)
	source $COLORSCHEME
endif
