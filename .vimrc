"=============================================
" Initialization
"=============================================

" Load pathogen if it is found
if filereadable(expand('~/.vim/bundles/vim-pathogen/autoload/pathogen.vim'))
  source ~/.vim/bundles/vim-pathogen/autoload/pathogen.vim
  call pathogen#infect(expand('~/.vim/bundles'))
endif

" Start .vimrc
set nocompatible
filetype plugin indent on

"=============================================
" Options
"=============================================

" Color
set t_Co=256
set background=dark
colorscheme solarized
syntax on

" Turn off error bells
set noerrorbells
set visualbell
set t_vb=

" Search
set ignorecase
set smartcase
set hlsearch
set incsearch

" Tab completion
set wildmode=list:longest,full
set wildignore=*.swp,*.o,*.so,*.exe,*.dll
set wildmenu

" Scroll
set scrolloff=3

" Tab settings
set ts=2
set sw=2
set expandtab

" Hud
set ruler
set number
set cursorline
set laststatus=2 " Always show status bar
set nowrap

" Buffers
set hidden

" History
set history=1000
set undolevels=1000

" Fix backspace
set backspace=indent,eol,start

" GUI options
if (has('gui_running'))
  set guifont=Inconsolata-dz:h12
  set guioptions-=T
  set guioptions-=m
endif

"=============================================
" Remaps
"=============================================

let mapleader=','
let maplocalleader=','

" Jump key
nnoremap ` '
nnoremap ' `

" Change pane
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Trim trailing whitespace
nnoremap <localleader>ts m`:%s/\s\+$//e<CR>``

"=============================================
" Additional Config Files
"=============================================

" Load user settings
if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif