" Vim configuration file for Kevin Richardson <kevin@magically.us>
" Last update:  24-Dec-2011
" ----------
set nocompatible                        " Use Vim-only settings


" [DISPLAY]
set nowrap						                  " don't wrap lines
syntax on						                    " turn on syntax highlighting
set number						                  " always show line numbers
set ruler						                    " show the cursor position all the time
set foldmethod=indent			              " fold around indents
set showmatch					                  " show matching parentheses
set noerrorbells visualbell t_vb=       " turn off screen flashing
autocmd GUIEnter * set visualbell t_vb=

" [TEXT-ENTRY]
set backspace=indent,eol,start	" allow backspacing over everything in insert mode
set autoindent					        " auto indentation
set copyindent					        " copy previous indentation level
set tabstop=2 shiftwidth=2		  " number of spaces to use with indenting
set shiftround					        " use multiples of shiftwidth for "<" and ">"
set smarttab					          " insert tabs at beginning of line according to shiftwidth
set expandtab									  " use spaces instead of tabs

" [SEARCHING]
set hlsearch					" highlight search terms
set incsearch					" show search matches as you type
set ignorecase			  " ignore case when searching
set smartcase					" ... unless term contains at least one capital letter
set showcmd						" display incomplete commands

" [GUI]
set title										  " change the terminal's level
colorscheme railscasts        " establish the colorscheme
set guifont=Inconsolata:h12   " establish the font
set guioptions-=m				      " remove the menu bar
set guioptions-=T				      " remove the toolbar


" [MISC]
set history=50				" keep 50 lines of command line history
set undolevels=100		" number of levels of undo
set autochdir					" change the working directory to that of the file in the current buffer
set visualbell				" don't beep
set noerrorbells			" don't beep
set nobackup					" don't make swap files
set noswapfile


" [KEY-MAPPINGS]
let mapleader = ","

nnoremap <c-j> <c-w>j   " easier navigation between split windows.
nnoremap <c-k> <c-w>k   " switch based on window direction relative to current buffer.
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

map <leader>n :NERDTreeToggle<CR> " Turn on/off NERDTree.

map <leader>F :FufFile<CR>        " FuzzyFinder
map <leader>f :FufTaggedFile<CR>
map <leader>s :FufTag<CR>

nnoremap <leader><leader> <c-^>   " alternate between buffers with <leader><leader>

nmap <leader>a= :Tabularize /=<CR>
vmap <leader>a= :Tabularize /=<CR>
nmap <leader>a: :Tabularize /:\zs<CR>
vmap <leader>a: :Tabularize /:\zs<CR>

" Call pathogen to load plugins and update helptags.
filetype off
call pathogen#infect()
call pathogen#helptags()

" Load file type detection, etc.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif
