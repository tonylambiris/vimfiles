" Adding a new pathogen module (example):
" git submodule add https://github.com/vim-ruby/vim-ruby.git bundle/vim-ruby
"
" Upon initial clone and pulls:
" git submodule update --init --recursive
"
" Removing a pathogen submodule:
" git submodule deinit -f bundle/vim-submodule
" git rm --cached bundle/vim-submodule
"
" NOTES:
" sh bundle/YouCompleteMe/install.sh
" sudo npm -g install jsonlint

execute pathogen#infect()
execute pathogen#helptags()

set background=dark " dark | light "

if !has("gui_running")
  let &t_AB="\e[48;5;%dm"
  let &t_AF="\e[38;5;%dm"
endif

filetype plugin indent on

"map <silent><F3> :NEXTCOLOR<cr>
"map <silent><F2> :PREVCOLOR<cr>

" open NERDtree listing on the right with CTRL-n
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeWinPos = "right"

""" NERDTree settings
"let NERDTreeMinimalUI = 1
"let NERDTreeDirArrows = 1
"let NERDTreeShowHidden = 0
"let NERDTreeShowFiles = 1
"let NERDTreeMinimalUI = 1
"let NERDChristmasTree = 1
"let NERDTreeChDirMode = 2
let g:NERDTreeMouseMode = 2

"let g:gitgutter_highlight_lines = 1
let g:gitgutter_diff_args = '-w'

" correctly mark json files for jsonlint
au BufRead,BufNewFile *.json set filetype=json

augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

" spell checking
augroup lexical
  autocmd!
  autocmd FileType markdown,mkd call lexical#init()
  autocmd FileType textile call lexical#init()
  autocmd FileType text call lexical#init({ 'spell': 0 })
augroup END

let g:lexical#spell = 1 " 0=disabled, 1=enabled
let g:lexical#spelllang = ['en_us',]
let g:spellfile_URL = 'http://ftp.vim.org/vim/runtime/spell'

" fix color formatting of certain file types
"au BufRead,BufNewFile *bash*,*.sh let g:is_bash=1
au BufRead,BufNewFile *bash*,*.sh setf sh
au BufRead,BufNewFile *.pgo setf go

let g:Powerline_symbols = 'fancy'
let g:vim_markdown_folding_disabled=1
let g:disable_markdown_autostyle = 1

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_loc_list_height=5
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }

let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

let g:go_list_type = "quickfix"
let g:go_fmt_command = "goimports"
let g:go_fmt_autosave = 1
let g:go_fmt_fail_silently = 1

set laststatus=5
set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" Enable VIM mouse support
set mouse=a
set ttymouse=xterm2

" Briefly jump to the opening bracket/paren/brace
set showmatch
"hi MatchParen    cterm=reverse

" Control-C to copy text highlighted in mouse mode
vmap <C-C> "+y"

" Send more characters for redraws
set ttyfast
set lazyredraw

" OSX == unnamed
" Linux == unnamedplus
set clipboard=unnamedplus
"set clipboard=unnamed

" clipboard size
"set viminfo='100,<100,s20,h

" show line numbers
set number
set spell spelllang=en_us

set title                " change the terminal's title
set visualbell           " don't beep
set noerrorbells         " don't beep"

" disable auto-commenting

highlight SpecialKey ctermfg=11 ctermbg=8
highlight Normal ctermfg=16 ctermbg=254
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

set textwidth=80
set formatoptions+=t
set wrap linebreak nolist
set hlsearch

"set timeoutlen=50
" Exit insert mode timeout
set ttimeoutlen=50
set timeout timeoutlen=1000 ttimeoutlen=100

set scrolloff=10
set colorcolumn=78
set mousehide
set undofile
set undodir=~/.vim/undodir
set cindent

set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab

autocmd FileType sh setlocal tabstop=4 softtabstop=0 noexpandtab shiftwidth=4
autocmd FileType Makefile setlocal tabstop=4 softtabstop=0 noexpandtab shiftwidth=4

scriptencoding utf-8

function! Noscrollbar(...)
    let w:airline_section_z = "%{noscrollbar#statusline(10,'-','■')}"
    "%{noscrollbar#statusline(20,'■','◫',['◧'],['◨'])}
endfunction
call airline#add_statusline_func('Noscrollbar')

" Return indent (all whitespace at start of a line), converted from
" tabs to spaces if what = 1, or from spaces to tabs otherwise.
" When converting to tabs, result has no redundant spaces.
function! Indenting(indent, what, cols)
  let spccol = repeat(' ', a:cols)
  let result = substitute(a:indent, spccol, '\t', 'g')
  let result = substitute(result, ' \+\ze\t', '', 'g')
  if a:what == 1
    let result = substitute(result, '\t', spccol, 'g')
  endif
  return result
endfunction

" Convert whitespace used for indenting (before first non-whitespace).
" what = 0 (convert spaces to tabs), or 1 (convert tabs to spaces).
" cols = string with number of columns per tab, or empty to use 'tabstop'.
" The cursor position is restored, but the cursor will be in a different
" column when the number of characters in the indent of the line is changed.
function! IndentConvert(line1, line2, what, cols)
  let savepos = getpos('.')
  let cols = empty(a:cols) ? &tabstop : a:cols
  execute a:line1 . ',' . a:line2 . 's/^\s\+/\=Indenting(submatch(0), a:what, cols)/e'
  call histdel('search', -1)
  call setpos('.', savepos)
endfunction

command! -nargs=? -range=% Space2Tab call IndentConvert(<line1>,<line2>,0,<q-args>)
command! -nargs=? -range=% Tab2Space call IndentConvert(<line1>,<line2>,1,<q-args>)
command! -nargs=? -range=% RetabIndent call IndentConvert(<line1>,<line2>,&et,<q-args>)

augroup WhiteSpaceMatch
  " Remove ALL autocommands for the WhiteSpaceMatch group.
  autocmd!
  autocmd BufWinEnter * let w:whitespace_match_number =
        \ matchadd('ExtraWhitespace', '\s\+$')
  autocmd InsertEnter * call s:ToggleWhiteSpaceMatch('i')
  autocmd InsertLeave * call s:ToggleWhiteSpaceMatch('n')
augroup END

function! s:ToggleWhiteSpaceMatch(mode)
  let pattern = (a:mode == 'i') ? '\s\+\%#\@<!$' : '\s\+$'
  if exists('w:whitespace_match_number')
    call matchdelete(w:whitespace_match_number)
    call matchadd('ExtraWhitespace', pattern, 10, w:whitespace_match_number)
  else
    " Something went wrong, try to be graceful.
    let w:whitespace_match_number =  matchadd('ExtraWhitespace', pattern)
  endif
endfunction

function! StripTrailingWhitespace()
  normal mZ
  let l:chars = col("$")
  %s/\s\+$//e
  normal `Z
endfunction

autocmd BufWritePre * call StripTrailingWhitespace()

call lengthmatters#highlight('ctermbg=8 ctermfg=7')
call lengthmatters#highlight_link_to('ColorColumn')
let g:lengthmatters_on_by_default=1

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tmuxline#enabled = 0
let g:airline_powerline_fonts = 1
let g:airline_theme='tomorrow'

if has("spell")
  set nospell
  set complete+=kspell
  hi clear SpellBad
  hi SpellBad cterm=underline ctermfg=red
  map <f9> :set spell!<cr>
endif

autocmd FileType help setlocal nospell
hi Search cterm=reverse

let mapleader=","

" GoldenView
let g:goldenview__enable_default_mapping=0
nmap <Leader><Leader> <plug>GoldenViewResize<CR>

" Expand %% to current directory
" http://vimcasts.org/e/14
cnoremap %% <C-R>=expand('%:h').'/'<cr>

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>

"call togglebg#map("<F5>")
"nmap <F8> :TagbarToggle<CR>

noremap <C-d> :sh<cr>

au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)

if has ('autocmd') " Remain compatible with earlier versions
 augroup vimrc     " Source vim configuration upon save
    autocmd! BufWritePost $MYVIMRC source % | echom "Reloaded " . $MYVIMRC | redraw
    autocmd! BufWritePost $MYGVIMRC if has('gui_running') | so % | echom "Reloaded " . $MYGVIMRC | endif | redraw
  augroup END
endif " has autocmd

if &t_Co > 2 || has("gui_running")
    " switch syntax highlighting on, when the terminal has colors
    syntax on
endif

if &t_Co >= 256 || has("gui_running")
    hi CursorLine ctermbg=233

    set term=xterm-256color
    set t_ut=

    colorscheme onedark
endif

" Use 24-bit (true-color) mode when outside tmux.
if (has("termguicolors"))
  set termguicolors
endif

" highlight all matched words on search, clear with enter key
nnoremap <SPACE> :nohlsearch<CR><CR>
nnoremap <LEADER>w :ToggleBufExplorer<CR><CR>
nnoremap <LEADER>h :GitGutterLineHighlightsToggle<CR><CR>
