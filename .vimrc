set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'itchyny/lightline.vim'
Plugin 'https://github.com/scrooloose/nerdtree.git'
Plugin 'https://github.com/joshdick/onedark.vim.git'

call vundle#end()
filetype plugin indent on

set number
set modeline
set t_Co=256
syntax on
set laststatus=2
set tabstop=4
set shiftwidth=4
set expandtab

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

map <C-n> :NERDTreeToggle<CR>

let g:lightline = {
  \ 'colorscheme': 'one',
\ }

