" GENERAL
:set wrap
:set linebreak
:set number numberwidth=4

" TOP MENU BAR TABBING THROUGH COMMANDS
:set wildmenu

" SHARE OSX CLIPBOARD WITH VIM
set clipboard+=unnamed

" Amount of lines to jump with 'ctrlD' and 'ctrlU'
set scroll=5

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
