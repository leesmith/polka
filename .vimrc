scriptencoding utf-8

"=============================================
" Initialization
"=============================================

" declare ruby path
let g:ruby_path = system('echo $HOME/.rbenv/shims')

" Start .vimrc
set nocompatible
filetype plugin indent on

" minpac
packadd minpac

if exists('*minpac#init')
  call minpac#init({'verbose': 3})
  call minpac#add('k-takata/minpac', {'type': 'opt'})
  call minpac#add('airblade/vim-gitgutter')
  call minpac#add('altercation/vim-colors-solarized')
  call minpac#add('ctrlpvim/ctrlp.vim')
  call minpac#add('jgdavey/tslime.vim')
  call minpac#add('jgdavey/vim-turbux')
  call minpac#add('mattn/emmet-vim')
  call minpac#add('mileszs/ack.vim')
  call minpac#add('nathanaelkane/vim-indent-guides')
  call minpac#add('pangloss/vim-javascript')
  call minpac#add('posva/vim-vue')
  call minpac#add('prettier/vim-prettier')
  call minpac#add('tpope/vim-bundler')
  call minpac#add('tpope/vim-commentary')
  call minpac#add('tpope/vim-endwise')
  call minpac#add('tpope/vim-fugitive')
  call minpac#add('tpope/vim-markdown')
  call minpac#add('tpope/vim-ragtag')
  call minpac#add('tpope/vim-rails')
  call minpac#add('tpope/vim-rake')
  call minpac#add('tpope/vim-repeat')
  call minpac#add('tpope/vim-surround')
  call minpac#add('vim-airline/vim-airline')
  call minpac#add('vim-airline/vim-airline-themes')
  call minpac#add('vim-ruby/vim-ruby')
  call minpac#add('vim-scripts/matchit.zip')

  " minpac utility commands
  command! PackUpdate call minpac#update()
  command! PackClean call minpac#clean()
  command! PackStatus call minpac#status()

  " use solarized for colorscheme
  if isdirectory($HOME . "/.vim/pack/minpac/start/vim-colors-solarized")
    colorscheme solarized
  endif

  " vim-airline
  let g:airline_powerline_fonts=1
  let g:airline_theme='solarized'

  " set sign column for vim-gitgutter
  highlight SignColumn ctermbg=8

  " Prettier: run before saving (async)
  " let g:prettier#autoformat = 0
  " autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync

  " Prettier: print spaces between brackets
  let g:prettier#config#bracket_spacing = 'true'

  " Prettier: single quotes over double quotes
  let g:prettier#config#single_quote = 'true'
endif

"=============================================
" Options
"=============================================

" Enable utf-8
set encoding=utf-8

" Color
set t_Co=256
set background=dark
syntax on

" Highlight breakpoints
au BufEnter *.rb syn match error contained "\<binding.pry\>"

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
set colorcolumn=100

" Buffers
set hidden

" History
set history=1000
set undolevels=1000

" Backup Directories
set backupdir=~/.vim/backups,.
set directory=~/.vim/swaps,.
if exists('&undodir')
  set undodir=~/.vim/undo,.
endif

" Fix backspace
set backspace=indent,eol,start

" GUI options
if (has('gui_running'))
  set guifont=Inconsolata-dz:h12
  set guioptions-=T
  set guioptions-=m
endif

" Highlight unwanted spaces
set list listchars=tab:»·,trail:·

" Preserve indentation while pasting text from the OS X clipboard
noremap <leader>p :set paste<CR>:put  *<CR>:set nopaste<CR>

" Remove delay when pressing esc when in insert mode
set noesckeys

" Set tags file search order
set tags=./tags;

"=============================================
" Remaps
"=============================================

let mapleader=','
let maplocalleader=','

" No arrow keys
map <Left>  :echo "ಠ_ಠ"<cr>
map <Right> :echo "ಠ_ಠ"<cr>
map <Up>    :echo "ಠ_ಠ"<cr>
map <Down>  :echo "ಠ_ಠ"<cr>

" Jump key
nnoremap ` '
nnoremap ' `

" Change pane
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Turn off search highlight
nnoremap <localleader>/ :nohlsearch<CR>

" Trim trailing whitespace
nnoremap <localleader>ws m`:%s/\s\+$//e<CR>``

"=============================================
" Autocommands
"=============================================

" Remove trailing whitespace on save of ruby files
au BufWritePre *.rb :%s/\s\+$//e

" edit OSX crontab in-place
autocmd FileType crontab setlocal nowritebackup

"=============================================
" Additional Config Files
"=============================================

" Load user settings
if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif

"=============================================
" Rails.vim projections
"=============================================

if !exists('g:rails_projections')
  let g:rails_projections = {}
endif

call extend(g:rails_projections, {
      \ "app/presenters/*.rb": {
      \   "command": "presenter",
      \   "test": "spec/presenter/%s_spec.rb",
      \   "alternate": "spec/presenter/%s_spec.rb",
      \   "template": "class %S\nend" },
      \ "app/services/*.rb": {
      \   "command": "service",
      \   "test": "spec/service/%s_spec.rb",
      \   "alternate": "spec/service/%s_spec.rb",
      \   "template": "class %S\nend" },
      \ "app/workers/*.rb": {
      \   "command": "worker",
      \   "template": "class %S\nend" }
      \ }, 'keep')

if !exists('g:rails_gem_projections')
  let g:rails_gem_projections = {}
endif

call extend(g:rails_gem_projections, {
      \ "active_model_serializers": {
      \   "app/serializers/*_serializer.rb": {
      \     "command": "serializer",
      \     "template": "class %SSerializer < ActiveModel::Serializer\nend",
      \     "affinity": "model"}},
      \ "rspec": {
      \   "spec/support/*.rb": {
      \     "command": "support"}},
      \ "cucumber": {
      \   "features/*.feature": {
      \     "command": "feature",
      \     "template": "Feature: %h"},
      \   "features/support/*.rb": {
      \     "command": "support"},
      \   "features/support/env.rb": {
      \     "command": "support"},
      \   "features/step_definitions/*_steps.rb": {
      \     "command": "steps"}},
      \ "carrierwave": {
      \   "app/uploaders/*_uploader.rb": {
      \     "command": "uploader",
      \     "template": "class %SUploader < CarrierWave::Uploader::Base\nend"}},
      \ "draper": {
      \   "app/decorators/*_decorator.rb": {
      \     "command": "decorator",
      \     "affinity": "model",
      \     "template": "class %SDecorator < ApplicationDecorator\nend"}},
      \ "fabrication": {
      \   "spec/fabricators/*_fabricator.rb": {
      \     "command": ["fabricator", "factory"],
      \     "alternate": "app/models/%s.rb",
      \     "related": "db/schema.rb#%p",
      \     "test": "spec/models/%s_spec.rb",
      \     "template": "Fabricator :%s do\nend",
      \     "affinity": "model"}},
      \ "factory_bot": {
      \   "spec/factories/*.rb": {
      \     "command": "factory",
      \     "alternate": "app/models/%s.rb",
      \     "related": "db/schema.rb#%p",
      \     "test": "spec/models/%s_spec.rb",
      \     "template": "FactoryBot.define do\n  factory :%s do\n  end\nend",
      \     "affinity": "model"},
      \   "spec/factories.rb": {
      \      "command": "factory"},
      \   "test/factories.rb": {
      \      "command": "factory"}}
      \ }, 'keep')
