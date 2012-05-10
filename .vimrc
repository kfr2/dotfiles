" Vim configuration file for Kevin Richardson <kevin@magically.us>
" https://github.com/kfredrichardson/dotfiles/blob/master/.vimrc
" ----------
set nocompatible                       " Use Vim-only settings

" Call pathogen to load plugins and update helptags.
filetype off
call pathogen#infect()
call pathogen#helptags()

" [DISPLAY]
set nowrap						        " don't wrap lines
syntax on						        " turn on syntax highlighting
set number						        " always show line numbers
set ruler						        " show the cursor position all the time
set foldmethod=indent			        " fold around indents
set foldnestmax=10                      " set deepest fold level
set foldlevel=1                         " configures fold level beginning
set nofoldenable                        " don't enable folding by default
set showmatch					        " show matching parentheses
set noerrorbells visualbell t_vb=       " turn off screen flashing
autocmd GUIEnter * set visualbell t_vb=
set laststatus=2                        " Always show the statusline

" [TEXT-ENTRY]
set backspace=indent,eol,start	        " allow backspacing over everything in insert mode
set autoindent					        " auto indentation
set copyindent					        " copy previous indentation level
set tabstop=4                           " control number of spaces with tab
set shiftwidth=4		                " number of spaces to use with indenting (<,>)
set softtabstop=4                       " deletes N spaces as if they were <TAB>
set expandtab						    " use spaces instead of tabs when <TAB> is pressed
set smarttab					        " insert tabs at beginning of line according to shiftwidth
set shiftround					        " use multiples of shiftwidth for "<" and ">"

" [SEARCHING]
set hlsearch					        " highlight search terms
set incsearch					        " show search matches as you type
set ignorecase			                " ignore case when searching
set smartcase       					" ... unless term contains at least one capital letter
set showcmd		         				" display incomplete commands

" [GUI]
set title			                    " change the terminal's level
set background=dark
colorscheme solarized                   " establish the colorscheme
set guifont=Inconsolata:h13             " establish the font
set guioptions-=m				        " remove the menu bar
set guioptions-=T				        " remove the toolbar


" [MISC]
set history=50				            " keep 50 lines of command line history
set undolevels=100		                " number of levels of undo
"set autochdir					        " change the working directory to that of the file in the current buffer
set visualbell		              		" don't beep
set noerrorbells			            " don't beep
"set backupdir=~/.vim/tmp/backup/        " backups directory
set directory=~/.vim/tmp/swap/          " swap files
"set backup

" [KEY-MAPPINGS]
let mapleader = ","

noremap <silent><Leader>/ :nohls<CR>    " clear search highlights

nnoremap <c-j> <c-w>j                   " easier navigation between split windows.
nnoremap <c-k> <c-w>k                   " switch based on window direction relative to current buffer.
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
nnoremap <leader><leader> <c-^>         " alternate between buffers with <leader><leader>

" Turns on/off NERDTree.
map <leader>n :NERDTreeToggle<CR>

" FuzzyFinder
map <leader>f :FufFile **/<CR>
map <leader>F :FufTaggedFile<CR>
map <leader>s :FufTag<CR>

nmap <leader>a= :Tabularize /=<CR>
vmap <leader>a= :Tabularize /=<CR>
nmap <leader>a: :Tabularize /:\zs<CR>
vmap <leader>a: :Tabularize /:\zs<CR>

call togglebg#map("<F5>")               " Alternate between solarized background types.

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
