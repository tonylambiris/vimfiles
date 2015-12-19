" Adding a new pathogen module (example):
" cd ~/.vim
" git submodule add https://github.com/vim-ruby/vim-ruby.git bundle/vim-ruby
"
" Removing a pathogen submodule:
" git submodule deinit -f bundle/vim-ruby
"
" NOTES:
" git submodule update --init --recursive
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

" jump to the last modification
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
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
  autocmd FileType text call lexical#init({ 'spell': 1 })
augroup END

let g:lexical#spell = 0 " 0=disabled, 1=enabled
let g:lexical#spelllang = ['en_us',]
let g:spellfile_URL = 'http://ftp.vim.org/vim/runtime/spell'

let g:Powerline_symbols = 'fancy'
let g:vim_markdown_folding_disabled=1
let g:disable_markdown_autostyle = 1

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }

let g:go_fmt_command = "goimports"
let g:go_fmt_autosave = 1

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" clipboard size
set viminfo='100,<100,s20,h
" show line numbers
set number
set spell spelllang=en_us
" set 256 colors
set t_Co=256
if &t_Co == 256
    hi CursorLine ctermbg=233
endif
" disable background color erase (for tmux)
set t_ut=

" disable auto-commenting
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

set textwidth=78
set formatoptions+=t
set wrap linebreak nolist
set tabstop=8
set expandtab
set shiftwidth=4
set softtabstop=4
set hlsearch
set background=dark " dark | light "
set timeoutlen=50
"set colorcolumn=78

let g:solarized_termcolors=256
"let g:kolor_italic=1                    " Enable italic. Default: 1
"let g:kolor_bold=1                      " Enable bold. Default: 1
"let g:kolor_underlined=1                " Enable underline. Default: 0
"let g:kolor_alternative_matchparen=1    " Gray 'MatchParen' color. Default: 0

let g:airline_theme='hybrid'
let g:airline_powerline_fonts=1

"colorscheme kolor
colorscheme apprentice
"colorscheme seoul256
"colorscheme bubblegum
"colorscheme gruvbox

call togglebg#map("<F5>")
nmap <F8> :TagbarToggle<CR>
call lengthmatters#highlight('ctermbg=8 ctermfg=7')
