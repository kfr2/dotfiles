set nocompatible                       " Use Vim-only settings

" Call Vundle to manage plugins.
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Plugins for Vundle to manage
" -----
" Usage:
" :BundleList -- list configured bundles
" :BundleInstall(!) -- install(update) bundles
" :BundleClean -- confirm removal of unused bundles
Plugin 'gmarik/Vundle.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'jeffkreeftmeijer/vim-numbertoggle'
Plugin 'kien/ctrlp.vim'
Plugin 'mileszs/ack.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'sjl/gundo.vim'
Plugin 'tomtom/tcomment_vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-sleuth'
Plugin 'trusktr/seti.vim'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-notes'

call vundle#end()

" [powerline]
" See https://powerline.readthedocs.org/en/latest/
python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup

" [syntastic]
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" See https://github.com/scrooloose/syntastic/wiki/Syntax-Checkers for a list
" of possible syntax checkers.
let g:syntastic_python_checkers = ['pyflakes']

" [vim-notes]
let g:notes_directories = ['~/Dropbox/notes']
let g:notes_suffix = '.txt'

" [EDITING]
filetype plugin indent on               " automatic filetype detection
syntax on                               " turn on syntax highlighting
set cursorline                          " highlight the cursor's line
set nowrap                              " don't wrap lines
set number                              " always show line numbers
set ruler                               " show the cursor position all the time on the status bar
set foldmethod=indent                   " fold around indents
set foldlevel=99                        " configures fold level beginning
set foldnestmax=10                      " set deepest fold level
set nofoldenable                        " don't enable folding by default
set showmatch                           " show matching parentheses
set noerrorbells visualbell t_vb=       " turn off screen flashing
set laststatus=2                        " Always show the statusline
set clipboard=unnamed                   " Set the clipboard for reattach-to-user-namespace
set list
set listchars=tab:▸\ ,eol:¬             " Show tab and EOL as characters.

" [TEXT-ENTRY]
set backspace=indent,eol,start          " allow backspacing over everything in insert mode
set autoindent                          " auto indentation
set copyindent                          " copy previous indentation level
set tabstop=4                           " control number of spaces with tab
set shiftwidth=4                        " number of spaces to use with indenting (<,>)
set softtabstop=4                       " deletes N spaces as if they were <TAB>
set expandtab                           " use spaces instead of tabs when <TAB> is pressed
set smarttab                            " insert tabs at beginning of line according to shiftwidth
set shiftround                          " use multiples of shiftwidth for "<" and ">"
set wildmenu                            " show list instead of auto completing
set wildmode=list:longest,full          " command completion <TAB>, list matches, then longest common part, then all
set wildignore=*.swp,*.bak,*.pyc,*.class,*.jar,*.gif,*.png,*.jpg " filetypes to ignore in CtrlP, etc

" [SEARCHING]
" nnoremap / /\v                        " search using normal regex
" vnoremap / /\v                        " see above
set hlsearch                            " highlight search terms
set incsearch                           " show search matches as you type
set ignorecase                          " ignore case when searching
set smartcase                           " ... unless term contains at least one capital letter
set showcmd                             " display incomplete commands
let g:ackprg = 'ag --nogroup --nocolor --column'    " use the silver searcher with ack.vim

" [GUI]
set mouse=a                             " enable use of the mouse
map <ScrollWheelUp> <C-Y>
map <ScrollWheelDown> <C-E>
set title                               " change the terminal's level
colorscheme Seti                        " establish the colorscheme
" set background=dark
set noshowmode                          " Hide the default text mode (ex: -- INSERT -- below the statusline)
set colorcolumn=72,80                      " Show column at specified characters

" change cursor based on mode if inside tmux
if exists('$ITERM_PROFILE')
  if exists('$TMUX') 
    let &t_SI = "\<Esc>[3 q"
    let &t_EI = "\<Esc>[0 q"
  else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
  endif
end

" for tmux to automatically set paste and nopaste mode at the time pasting (as
" happens in VIM UI)
function! WrapForTmux(s)
  if !exists('$TMUX')
    return a:s
  endif

  let tmux_start = "\<Esc>Ptmux;"
  let tmux_end = "\<Esc>\\"

  return tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . tmux_end
endfunction

let &t_SI .= WrapForTmux("\<Esc>[?2004h")
let &t_EI .= WrapForTmux("\<Esc>[?2004l")

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()
" end automatic set paste/nopaste


if has('gui_running')
  set guifont=Source\ Code\ Pro\ for\ PowerLine:h13
  set guioptions-=m                     " remove the menu bar
  set guioptions-=T                     " remove the toolbar

  if has('gui_vimr')
    set transparency=5
  endif

  if has('gui_macvim')
    set transparency=5
  endif
else
  if &term == 'xterm' || &term == 'screen'
    set t_Co=256                        " use 256 colors in terminal
  endif
  augroup FastEscape
    autocmd!
    au InsertEnter * set timeoutlen=0
    au InsertLeave * set timeoutlen=1000
  augroup END
endif

" [MISC]
set history=1000                        " keep 1000 lines of command line history
set undolevels=1000                     " number of levels of undo
set visualbell                          " don't beep
set noerrorbells                        " don't beep
set nobackup
set nowritebackup
set noswapfile

" [KEY-MAPPINGS]
let mapleader = ","

inoremap jj <ESC>                       " map jj to <ESC>

noremap <silent><Leader>/ :nohls<CR>    " clear search highlights with <leader>/

nnoremap <leader>- <c-w>s<c-w>j         " splits window horizontally and switch to new one.
nnoremap <leader>+ <c-w>v<c-w>l         " splits window vertically and switches to new one.
nnoremap <c-j> <c-w>j                   " easier navigation between split windows.
nnoremap <c-k> <c-w>k                   " switch based on window direction relative to current buffer.
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
nnoremap <leader><leader> <c-^>         " alternate between buffers with <leader><leader>

nnoremap <space> za                     " fold/unfold with <space>
vnoremap <space> zf

" NERDTree toggle
map <leader>n :NERDTreeToggle<CR>

" Toggle Gundo window
nnoremap <F5> :GundoToggle<CR>

" FuzzyFinder with CtrlP
map <leader>p :CtrlP<CR>
map <leader>P :CtrlPMRU<CR>
nmap ; :CtrlPBuffer<CR>

" Show Ack search window.
map <leader>a :Ack 

" Load file type detection, etc.
if has("autocmd")
  autocmd GUIEnter * set visualbell t_vb=
  "autocmd BufEnter * silent! lcd %:p:h    " change the working directory to that of the file in the current buffer

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

  " Auto indent after several of Python's keywords.
  autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class

  " Trim whitespace from the ends of lines when saving a Python file.
  autocmd BufWritePre *.py normal m`:%s/\s\+$//e``
endif " has("autocmd")
