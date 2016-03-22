"
" ****** My VIM Configurations  ******
"
" Maintained by:
" 	Haiyang Han
" 	Ph.D. of Computer Engineering
" 	Northwestern University
"	haiyang1992@gmail.com
" 
" Backed up at https://github.com/haiyang1992/vim
"
" Sections
"     *** Jump to each section by searching for the tags
"     1. General Settings          GSTG
"     2. VIM UI                    VIUI
"     3. Files and Backup          FLBK
"     4. Colors and Fonts          CLFT
"     5. Tab and Indent            TBIT
"------------------------------------------------------------------------------------------

"=========================================================
"	1. General Settings
"=====================================================GSTG

" Enable file type detection.
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" keep 200 lines of command line history
set history=200		

" Don't use Ex mode, use Q for formatting
map Q gq

" Set leader key to <comma>
let mapleader = ","
let g:mapleader = ","

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif


"=========================================================
"	2. VIM UI
"=====================================================VIUI

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Show the cursor position all the time
set ruler

" Display incomplete commands in the lower right corner
set showcmd

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

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

" Ignore case when searching
set ignorecase

" When search contains CAPITAL letters, do case-sensitive searching
set smartcase

" Do incremental searching
set incsearch		

" After a search, ESC switches of highlighting
nnoremap <leader><space> :nohl<cr>

" For regular expressions turn magic on
set magic

" Briefly jump to matching bracket when bracket is inserted
set showmatch
" Blink the matching bracket for 2 tenths of a second
set mat=2

" Always keep current line in center 
nnoremap j jzz
nnoremap k kzz
nnoremap G Gzz

" Turn on wildmenu
set wildmenu

" First tab will complete to longest string and show the the match list
" second tab will complete to first full match and open the wildmenu.
set wildmode=longest:list,full

" Ignore compiled files
set wildignore=*.o,*~,*.pyc

" Set height of command bar to 2
set cmdheight=2

" Move to next/previous line in normal and visual mode using left and right
" arrow keys
set whichwrap+=<,>

" Turn off error notification
set noerrorbells
set novisualbell
set vb t_vb=


"=========================================================
"	3. Files and Backup
"=====================================================FLBK

" Do not keep a backup file, since mostly Git is used
set nobackup

" Set to auto read when a file is changed from the outside
set autoread

" Fast saving
nmap <leader>w :w!<cr>

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif


"=========================================================
"	4. Colors and Fonts 
"=====================================================CLFT
"

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Use Solarized color scheme
" Use Terminal's color pallete
set t_Co=16
let g:solarized_termcolors=16
set background=dark
colorscheme solarized


"=========================================================
"	5. Tabs and Indent
"=====================================================TBIT

" Replace tab with spaces
set expandtab

" Use smart tabs, not needed when shiftwidth == softtabstop
"set smarttab

" Make 1 tab = 4 spaces
set shiftwidth=4
set softtabstop=4
