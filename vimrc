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
"     0. Vundle Necessary          VNDL
"     1. General Settings          GSTG
"     2. VIM UI                    VIUI
"     3. Files and Backup          FLBK
"     4. Colors and Fonts          CLFT
"     5. Tab and Indent            TBIT
"     6. Visual Mode               VSMD
"     7. Search, Tabs, Windows     STWN
"     8. Status Line               STLN
"     9. MISC Mappings             MPNG
"------------------------------------------------------------------------------------------

"=========================================================
"	0. Vundle Necessary
"=====================================================VNDL

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Keep Plugin commands between vundle#begin/end.

" Nerd Commenter
Plugin 'scrooloose/nerdcommenter'

" All Plugins must be added before the following line
call vundle#end()            " required

" Enable file type detection.
" Also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on
" To ignore plugin indent changes, instead use:
"filetype plugin on

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just
" :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal

" ******** Non-Plugin stuff after this line

"=========================================================
"	1. General Settings
"=====================================================GSTG

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" keep 200 lines of command line history
set history=200		

" Set leader key to <comma>
let mapleader = ","
let g:mapleader = ","

" In many terminal emulators the mouse works just fine, thus enable it.
" Disable mouse for now
if has('mouse')
  set mouse-=a
endif


"=========================================================
"	2. VIM UI
"=====================================================VIUI

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Show the cursor position all the time
set ruler

" Show line number
set number

" Highlight current line
set cursorline

" Display incomplete commands in the lower right corner
set showcmd

" Show mode in status
set showmode

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" For all text files set 'textwidth' to 78 characters.
autocmd FileType text setlocal textwidth=78

" For C/C++, turn on C style indent
autocmd FileType c,cpp : set cindent

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
" Also don't do it when the mark is in the first line, that is the default
" position when opening a file.
autocmd BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

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
set wildignore=*.o,*~,*.pyc,*.sw,*.bak

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

" Turn on auto indent
set autoindent

" Turn off smart indent since filetype indent is on
"set smartindent


"=========================================================
"	6. Visual Mode
"=====================================================VSMD

" Visual mode pressing * or # searches for the current selection
" " Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>


"=========================================================
"	7. Search, Tabs, Windows
"=====================================================STWN

" Map <space> to / (search)
map <space> /

" Ignore case when searching
set ignorecase

" When search contains CAPITAL letters, do case-sensitive searching
set smartcase

" Do incremental searching
set incsearch		

" After a search, <leader> + <space> switches of highlighting
nnoremap <leader><space> :nohl<cr>

" Tab navigation with H and L
nnoremap H gT
nnoremap L gt
" Close tabs with X, open new tabs with T
nnoremap X :tabclose<CR>
nnoremap T :tabedit<space>


"=========================================================
"	8. Status Line
"=====================================================STLN

" Always show the status line
set laststatus=2

" TODO: Use a status line plugin


"=========================================================
"	0. Misc Mappings
"=====================================================MPNG

" Swich ; and : to save my pinky finger
nnoremap ; :
nnoremap : ;

" Don't use Ex mode, use Q for formatting
map Q gq

" F5 toggles paste mode
nnoremap <F5> :set invpaste paste?<CR>
set pastetoggle=<F2>
