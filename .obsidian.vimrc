" -- Movement --
map j gj
nmap k gk
nmap H ^
nmap L $
" allows me to jump to start and end of lines with ctrl + h and ctrl + l
unmap <C-h>
unmap <C-l>
nmap <C-h> ^
nmap <C-l> $
vmap <C-h> ^
vmap <C-l> $

" --- EDITING ---
"  Bind jk to esc
imap jk <Esc>
imap jK <Esc>
imap JK <Esc>
imap Jk <Esc>

" --- SCROLLING ---
" We use an exmap to turn the complex command into a single word
" This bypasses the 'single word' bug in the plugin
unmap <C-j>
unmap <C-k>
nmap <C-j> 15gjzz
nmap <C-k> 15gkzz
vmap <C-j> 15gjzz
vmap <C-k> 15gkzz

" Auto-center page up and page down
nmap <C-u> <C-u>zz
nmap <C-d> <C-d>zz

" --- UTILITY ---
" In Obsidian 1.7.2+, you MUST include <CR> for Ex commands like nohl
nmap <Space>/ :nohl<CR>

" Swap jump to marker logic
nmap ' `
nmap ` '

" Paste/Delete without losing buffer
vmap <Space>p "_dP
vmap <Space>d "_d
nmap <Space>d "_d
