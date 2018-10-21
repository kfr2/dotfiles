call plug#begin('~/.nvim/plugged')

Plug 'scrooloose/syntastic'

Plug 'airblade/vim-gitgutter'
Plug 'jeffkreeftmeijer/vim-numbertoggle'

Plug 'trusktr/seti.vim'
Plug 'sickill/vim-monokai'

call plug#end()

set title
colorscheme elflord

" [EDITING]
filetype plugin indent on
syntax on
set cursorline
set nowrap
set number
set ruler
set showmatch
set list
set listchars=tab:▸\ ,eol:¬

" [KEY-MAPPINGS]
let mapleader = ','
:imap jj <Esc>

" [syntastic]
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" [Syntax checkers]
let g:syntastic_python_checkers = ['pyflakes']

