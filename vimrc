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
" 1. General Settings
" 2. VIM UI
" 3. Files and Bakckup 
"
"------------------------------------------------------------------------------------------

"=========================================================
"	1. General Settings
"=========================================================

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" keep 50 lines of command line history
set history=200		

" Don't use Ex mode, use Q for formatting
map Q gq

" Set leader key to comma
let mapleader = ","
let g:mapleader = ","

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

"=========================================================
"	2. VIM UI
"=========================================================

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Show the cursor position all the time
set ruler

" Display incomplete commands in the lower right corner
set showcmd

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Do incremental searching
set incsearch		

" After a search, ESC switches of highlighting
nnoremap <leader><space> :nohl<cr>

"=========================================================
"	3. Files and Backup
"=========================================================

" Do not keep a backup file, since mostly Git is used
set nobackup

" Set to auto read when a file is changed from the outside
set autoread

" Fast saving
nmap <leader>w :w!<cr>




" Only do this part when compiled with support for autocommands.
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

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif
