" GENERAL
:set encoding=utf-8
:set modelines=0
:set wrap
:set linebreak
:set number relativenumber numberwidth=4
:set showmode
:set showcmd
:set backspace=indent,eol,start
:set ttyfast
:set ruler

"toggle between number and relative number in insert mode
 :augroup numbertoggle
 :  autocmd!
 :  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
 :  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
 :augroup END

" TOP MENU BAR TABBING THROUGH COMMANDS
:set wildmenu
:set wildmode=list:longest

" FILE TYPES
filetype on
filetype plugin on
filetype indent on
syntax on

" turn off auto comments
:set formatoptions-=cro

" SEARCHING (INCREMENTAL AND HIGHLIGHT)
set incsearch
set hlsearch
set ignorecase
set smartcase

" INDENT
:set autoindent
:set smartindent

" STATUS
:set laststatus=2

" SHARE OSX CLIPBOARD WITH VIM
set clipboard+=unnamed

" Amount of lines to jump with 'ctrlD' and 'ctrlU'
set scroll=5

" Sounds 
set noerrorbells
set novisualbell
set t_vb=

" Tabs
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" TURN OFF ARROW IN INSERT MODE
inoremap <left> <nop>
inoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>

" TURN OFF ARROW IN NORMAL MODE
nnoremap <left> <nop>
nnoremap <right> <nop>
nnoremap <up> <nop>
nnoremap <down> <nop>

" MAP LEADER
:let mapleader = ","
:let maplocalleader = "\\"

" CUSTOM MAPPING

" movement by columns
:nnoremap j gj
:nnoremap k gk

" Just to beginning and end of lines easier. 
noremap H ^
noremap L $
noremap <c-H> ^
noremap <c-L> $

vnoremap H ^
vnoremap <c-H> ^
vnoremap <c-L> $
vnoremap L $

" make ; function as : to write commands (
noremap ; :
vnoremap ; :

" remap U to <C-r> for easier redo
nnoremap U <C-r>

" v will visually highlight a word
" nnoremap <leader>v viw

" opens .vimrc in vertical split mode
:nnoremap <leader>ev :vsplit $MYVIMRC<cr>

" reloads .virmc
:nnoremap <leader>sv :source $MYVIMRC<cr>

" rebinds esc (using <c-[> instead for ideavim compatibility)
:inoremap jk <c-[>
:inoremap jK <c-[>
:inoremap JK <c-[>
:inoremap Jk <c-[>

" unbind esc - undo later
:inoremap <esc> <nop>

"This unsets the "last search pattern" register by hitting return
nnoremap <leader><space> :noh<CR>

" Removes doc lookup mapping because it's easy to fat finger and never useful.
nnoremap K k
vnoremap K k

" Scroll larger amounts with c-j / c-k
nnoremap <c-j> 15gjzz
nnoremap <c-k> 15gkzz
vnoremap <c-j> 15gjzz
vnoremap <c-k> 15gkzz

" Swap implementations of ` and ' jump to markers
" By default, ' jumps to the marked line, ` jumps to the marked line and
" column, so swap them
nnoremap ' `
nnoremap ` 
