set nocompatible
filetype off

" Vundle stuff
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'itchyny/lightline.vim'
Plugin 'https://github.com/scrooloose/nerdtree.git'
Plugin 'https://github.com/joshdick/onedark.vim.git'
Plugin 'https://github.com/leafgarland/typescript-vim.git'
Plugin 'https://github.com/ctrlpvim/ctrlp.vim'
Plugin 'posva/vim-vue'
Bundle 'jistr/vim-nerdtree-tabs'
Plugin 'ryanoasis/vim-devicons'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdcommenter'
Plugin 'mattn/emmet-vim'
Plugin 'pangloss/vim-javascript'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'mxw/vim-jsx'

call vundle#end()
filetype plugin indent on

" General configs
set number
set modeline
set t_Co=256
syntax on
set laststatus=2
set tabstop=4
set shiftwidth=4
set expandtab

" NERDTree stuff
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Key mappings
map <C-n> <plug>NERDTreeTabsToggle<CR>
map <C-i> :tabn<CR>
map <C-h> :tabp<CR>

" Highlight current line
:hi CursorLine   cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
:hi CursorColumn cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
:nnoremap <Leader>c :set cursorline! cursorcolumn!<CR>

" Lightline color theme
let g:lightline = {
  \ 'colorscheme': 'one',
  \ }

" Editor theme
colorscheme onedark
