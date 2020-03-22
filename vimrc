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
"     0. Plugins using vim-plug    VPLG
"     1. General Settings          GSTG
"     2. VIM UI                    VIUI
"     3. Files and Backup          FLBK
"     4. Colors and Fonts          CLFT
"     5. Tab and Indent            TBIT
"     6. Visual Mode               VSMD
"     7. Search, Tabs, Windows     STWN
"     8. Status Line               STLN
"     9. MISC Mappings             MPNG
"    10. Plugin Specific           PLGN
"------------------------------------------------------------------------------------------

"=========================================================
"	0. Plugins using vim-plug
"=====================================================VPLG

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Set encoding displayed
set encoding=utf-8
" Set encoding written to file
set fileencoding=utf-8

" Initialize
call plug#begin('~/.vim/plugged')

" Keep Plugin commands between plug#begin() and plug#()end.

" Material theme
Plug 'kaicataldo/material.vim'

" Nerd Commenter
Plug 'scrooloose/nerdcommenter'

" Tagslist
Plug 'vim-scripts/taglist.vim'

" Nerd Tree with Tabs
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'

" Airline for status line
Plug 'bling/vim-airline'

" Theme support for airline
Plug 'vim-airline/vim-airline-themes'

" Git wrapper
Plug 'tpope/vim-fugitive'

" Automatically switch between relative and absolute line numbering in
" different modes
Plug 'myusuf3/numbers.vim'

" Fuzzy search
Plug 'ctrlpvim/ctrlp.vim'

" Icons for NerdTree
" Always add this last
Plug 'ryanoasis/vim-devicons'

" All Plugins must be added before the following line
call plug#end()            " required

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
" Enable mouse for now
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

" Automatically change current working directory
autocmd BufEnter * silent! lcd %:p:h

"=========================================================
"	4. Colors and Fonts
"=====================================================CLFT

" Use Terminal's color pallete
set t_Co=256

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Use Material theme

" For Neovim 0.1.3 and 0.1.4 - https://github.com/neovim/neovim/pull/2198
if (has('nvim'))
  let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
endif
" For Neovim > 0.1.5 and Vim > patch 7.4.1799 - https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162
" Based on Vim patch 7.4.1770 (`guicolors` option) - https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd
" https://github.com/neovim/neovim/wiki/Following-HEAD#20160511
if (has('termguicolors'))
  set termguicolors
endif

set background=dark
let g:material_theme_style = 'darker'
colorscheme material

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


"=========================================================
"	9. Misc Mappings
"=====================================================MPNG

" Swich ; and : to save my pinky finger
nnoremap ; :
nnoremap : ;

" Don't use Ex mode, use Q for formatting
map Q gq

" F5 toggles paste mode
nnoremap <F5> :set invpaste paste?<CR>
set pastetoggle=<F2>

" iTerm2 mappings
:map <C-a> <Home>
:imap <C-a> <Home>
:cmap <C-a> <Home>
:map <C-e> <End>
:imap <C-e> <End>
:cmap <C-e> <End>

"=========================================================
"	10. Plugin Specific
"=====================================================PLGN

"---------- Taglist ----------

let Tlist_Inc_Winwidth=0
" Open TagList window on startup
"let Tlist_Auto_Open=1

" Use <F8> to toggle TagList window on/off
nnoremap <silent> <F8> :TlistToggle<CR>

" Only show the tags of currenet file
let Tlist_Show_One_File=1

" To process files even when the taglist window is not open
let Tlist_Process_File_Always=1

" Quit Vim if TagList is the only window left
let Tlist_Exit_OnlyWindow=1

" Keep TagList window on the right
let Tlist_Use_Right_Window=1

"---------- NerdTree and NERDTreeTabs ----------

" Quit if NERDTree is the last window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Use <F3> to toggle NERDTreeTabs window
map <F3> <plug>NERDTreeTabsToggle<CR>

" Start NerdTreeTabs automatically with consoles
let g:nerdtree_tabs_open_on_console_startup=1

"---------- NerdCommenter ----------
vmap ++ <plug>NERDCommenterToggle
nmap ++ <plug>NERDCommenterToggle

"---------- Airline ----------
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:airline_theme='onedark'

" unicode symbols
"let g:airline_left_sep = '»'
"let g:airline_left_sep = '▶'
"let g:airline_right_sep = '«'
"let g:airline_right_sep = '◀'
"let g:airline_symbols.linenr = '␊'
"let g:airline_symbols.linenr = '␤'
"let g:airline_symbols.linenr = '¶'
"let g:airline_symbols.branch = '⎇'
"let g:airline_symbols.paste = 'ρ'
"let g:airline_symbols.paste = 'Þ'
"let g:airline_symbols.paste = '∥'
"let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
"let g:airline_left_sep = ''
"let g:airline_left_alt_sep = ''
"let g:airline_right_sep = ''
"let g:airline_right_alt_sep = ''
"let g:airline_symbols.branch = ''
"let g:airline_symbols.readonly = ''
"let g:airline_symbols.linenr = ''
