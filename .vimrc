set nocompatible
set backspace=indent,eol,start
set number
set cindent
set laststatus=2
set statusline=%F%=[%05l/%05L,%05c]
set tabstop=2
set expandtab
set shiftwidth=2
syntax on
nnoremap <Space>. : <C-u>edit $MYVIMRC<Enter>
nnoremap <Space>s. : <C-u>source $MYVIMRC<Enter>
colorscheme desert
setlocal cursorline
let g:neocomplcache_enable_at_startup = 1
let versdiff_no_resize=80

" <Enter>で空行挿入
" http://vim-users.jp/2009/08/hack57/
nnoremap <Cr> :<C-u>call append(expand('.'), '')<Cr>j

" rootの.vimrcの設定(/root/.vimrc)
" 
" if filereadble(expand('/home/john/.vimrc'))
"   source /home/john/.vimrc
" endif
"
" だけを記述して、/home/john/.vimrcと常に同じ設定になる
" reference URI:
" http://d.hatena.ne.jp/thinca/20100205/1265307642
