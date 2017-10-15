" GENERAL
:set wrap
:set linebreak
:set number relativenumber numberwidth=4

"toggle between number and relative number in insert mode
 :augroup numbertoggle
 :  autocmd!
 :  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
 :  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
 :augroup END

" TOP MENU BAR TABBING THROUGH COMMANDS
:set wildmenu

" FILE TYPES
filetype on
filetype plugin on
filetype indent on
syntax on

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

" Visual Bell
set visualbell

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

" space will visually highlight a word
nnoremap <leader><space> viw

" opens .vimrc in vertical split mode
:nnoremap <leader>ev :vsplit $MYVIMRC<cr>

" reloads .virmc
:nnoremap <leader>sv :source $MYVIMRC<cr>

" rebinds esc (using <c-[> instead for ideavim compatibility)
:inoremap jk <c-[>

" unbind esc - undo later
:inoremap <esc> <nop>

"This unsets the "last search pattern" register by hitting return
nnoremap <leader><space> :noh<CR>

