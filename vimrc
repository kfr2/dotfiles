" https://github.com/kfr2/dotfiles/blob/master/.vimrc
" ----------
set nocompatible                       " Use Vim-only settings

" Call Vundle to manage plugins.
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Plugins for Vundle to manage
" -----
" Usage:
" :BundleList -- list configured bundles
" :BundleInstall(!) -- install(update) bundles
" :BundleClean -- confirm removal of unused bundles
Bundle 'gmarik/vundle'

Bundle 'jeffkreeftmeijer/vim-numbertoggle'
Bundle 'jmcantrell/vim-virtualenv'
Bundle 'kien/ctrlp.vim'
Bundle 'Lokaltog/vim-powerline'
Bundle 'mileszs/ack.vim'
Bundle 'mnoble/tomorrow-night-vim'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'tpope/vim-fugitive'

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

" [SEARCHING]
" search using normal regex
nnoremap / /\v
vnoremap / /\v
set hlsearch                            " highlight search terms
set incsearch                           " show search matches as you type
set ignorecase                          " ignore case when searching
set smartcase                           " ... unless term contains at least one capital letter
set showcmd                             " display incomplete commands

" [GUI]
set mouse=a                             " enable use of the mouse
map <ScrollWheelUp> <C-Y>
map <ScrollWheelDown> <C-E>
set title                               " change the terminal's level
colorscheme Tomorrow-Night              " establish the colorscheme
set background=dark
set guifont=Inconsolata-dz\ for\ Powerline:h12 
let g:Powerline_symbols = 'fancy'       " establish the font. Powerline fonts are
                                        " available from http://bit.ly/zRuZ4V

if has('gui_running')
  set guioptions-=m                     " remove the menu bar
  set guioptions-=T                     " remove the toolbar
    if exists('+colorcolumn')
        set colorcolumn=80              " Highlight the 80th column (for PEP8, etc)
    endif
  if has('gui_macvim')
    set transparency=5
  endif
else
  if &term == 'xterm' || &term == 'screen'
    set t_Co=256                        " use 256 colors in terminal
  endif
endif

" [MISC]
set history=1000                        " keep 50 lines of command line history
set undolevels=1000                     " number of levels of undo
set visualbell                          " don't beep
set noerrorbells                        " don't beep
set nobackup
set nowritebackup
set noswapfile

" [KEY-MAPPINGS]
let mapleader = ","

inoremap jj <ESC>                       " map jj to <ESC>

noremap <silent><Leader>/ :nohls<CR>    " clear search highlights

nnoremap <leader>w <c-w>v<c-w>l         " <leader>w splits window vertically and switches to it.
nnoremap <c-j> <c-w>j                   " easier navigation between split windows.
nnoremap <c-k> <c-w>k                   " switch based on window direction relative to current buffer.
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
nnoremap <leader><leader> <c-^>         " alternate between buffers with <leader><leader>

" NERDTree toggle
map <leader>n :NERDTreeToggle<CR>

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
    
    " Highlight all characters past 79 columns.
    autocmd BufEnter * highlight OverLength ctermbg=White guibg=#F8F8F8
    autocmd BufEnter * match OverLength /\%79v.*/

  augroup END

  " Auto indent after several of Python's keywords.
  autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class

  " Trim whitespace from the ends of lines when saving a Python file.
  autocmd BufWritePre *.py normal m`:%s/\s\+$//e``

  " Enable easier jumping between relative Django files.
  let g:last_relative_dir = ''
  nnoremap \1 :call RelatedFile ("models.py")<cr>
  nnoremap \2 :call RelatedFile ("views.py")<cr>
  nnoremap \3 :call RelatedFile ("urls.py")<cr>
  nnoremap \4 :call RelatedFile ("admin.py")<cr>
  nnoremap \5 :call RelatedFile ("tests.py")<cr>
  nnoremap \6 :call RelatedFile ( "templates/" )<cr>
  nnoremap \7 :call RelatedFile ( "templatetags/" )<cr>
  nnoremap \8 :call RelatedFile ( "management/" )<cr>
  nnoremap \0 :e settings.py<cr>
  nnoremap \9 :e urls.py<cr>

  fun! RelatedFile(file)
    " This is to check that the directory looks djangoish
    if filereadable(expand("%:h"). '/models.py') || isdirectory(expand("%:h") . "/templatetags/")
      exec "edit %:h/" . a:file
      let g:last_relative_dir = expand("%:h") . '/'
      return ''
    endif
    if g:last_relative_dir != ''
      exec "edit " . g:last_relative_dir . a:file
      return ''
    endif
    echo "Cant determine where relative file is : " . a:file
    return ''
  endfun

  fun SetAppDir()
    if filereadable(expand("%:h"). '/models.py') || isdirectory(expand("%:h") . "/templatetags/")
      let g:last_relative_dir = expand("%:h") . '/'
      return ''
    endif
  endfun

  autocmd BufEnter *.py call SetAppDir()

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
      \ | wincmd p | diffthis
endif
