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

" INDENT
:set autoindent
:set smartindent

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

" rebinds esc
:inoremap jk <esc>

" unbind esc - undo later
:inoremap <esc> <nop>
