" Upon initial checkout:
" git submodule update --init --recursive
"
" Adding a new pathogen module (example):
" git submodule add https://github.com/vim-ruby/vim-ruby.git bundle/vim-ruby
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

filetype plugin indent on
syntax on

" highlight all matched words on search, clear with enter key
nnoremap <SPACE> :nohlsearch<CR><CR>

map <silent><F3> :NEXTCOLOR<cr>
map <silent><F2> :PREVCOLOR<cr>

" open NERDtree listing on the right with CTRL-n
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeWinPos = "right"

hi Normal ctermfg=16 ctermbg=254

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

" fix color formatting of bash scripts
autocmd BufRead,BufNewFile *bash*.sh set filetype=sh
au BufRead,BufNewFile *bash*,*.sh let g:is_bash=1
au BufRead,BufNewFile *bash*,*.sh setf sh

let g:Powerline_symbols = 'fancy'
let g:vim_markdown_folding_disabled=1
let g:disable_markdown_autostyle = 1

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
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

set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" Enable VIM mouse support
set mouse=r
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
"set clipboard=unnamedplus
set clipboard=unnamed

" clipboard size
"set viminfo='100,<100,s20,h

" show line numbers
set number
set spell spelllang=en_us
" set 256 colors
set t_Co=256

if &t_Co == 256
    set term=xterm-256color
    hi CursorLine ctermbg=233
endif

" disable background color erase (for tmux)
set t_ut=

set background=dark " dark | light "

" disable auto-commenting
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

set textwidth=80
set formatoptions+=t
set wrap linebreak nolist
set hlsearch
set timeoutlen=50
set scrolloff=10
"set colorcolumn=78
set mousehide
set undofile
set undodir=~/.vim/undodir
set cindent

""" NERDTree settings
"let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
"let NERDTreeShowHidden = 0
"let NERDTreeShowFiles = 1
"let NERDTreeMinimalUI = 1
"let NERDChristmasTree = 1
"let NERDTreeChDirMode = 2
let g:NERDTreeMouseMode = 2

set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab

autocmd FileType sh setlocal tabstop=4 softtabstop=0 noexpandtab shiftwidth=4
autocmd FileType Makefile setlocal tabstop=4 softtabstop=0 noexpandtab shiftwidth=4

"call togglebg#map("<F5>")
"nmap <F8> :TagbarToggle<CR>
call lengthmatters#highlight('ctermbg=8 ctermfg=7')

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

autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
"highlight ExtraWhitespace ctermbg=red guibg=red

" Show trailing whitespace:
"match ExtraWhitespace /\s\+$/

" Show trailing whitespace and spaces before a tab:
"match ExtraWhitespace /\s\+$\| \+\ze\t/

"au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
"au InsertLeave * match ExtraWhitespace /\s\+$/

"if version >= 702
"  autocmd BufWinLeave * call clearmatches()
"endif

highlight ExtraWhitespace ctermbg=red guibg=red
augroup WhitespaceMatch
  " Remove ALL autocommands for the WhitespaceMatch group.
  autocmd!
  autocmd BufWinEnter * let w:whitespace_match_number =
        \ matchadd('ExtraWhitespace', '\s\+$')
  autocmd InsertEnter * call s:ToggleWhitespaceMatch('i')
  autocmd InsertLeave * call s:ToggleWhitespaceMatch('n')
augroup END

function! s:ToggleWhitespaceMatch(mode)
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

if !has("gui_running")
  let &t_AB="\e[48;5;%dm"
  let &t_AF="\e[38;5;%dm"
endif

"colorscheme kolor
"let g:kolor_italic=1                    " Enable italic. Default: 1
"let g:kolor_bold=1                      " Enable bold. Default: 1
"let g:kolor_underlined=1                " Enable underline. Default: 0
"let g:kolor_alternative_matchparen=1    " Gray 'MatchParen' color. Default: 0

"colorscheme muon
"colorscheme PaperColor
colorscheme onedark

"let g:airline_theme='kolor'
"let g:airline_theme='papercolor'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

if has("spell")
  set nospell
  set complete+=kspell
  hi clear SpellBad
  hi SpellBad cterm=underline ctermfg=red
  map <f9> :set spell!<cr>
endif

autocmd FileType help setlocal nospell
hi Search cterm=reverse
