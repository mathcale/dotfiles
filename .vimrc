"
" @mathcale's Vim Wizardry
"
set encoding=utf8

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
Plugin 'farmergreg/vim-lastplace'
Plugin 'Shougo/neocomplete.vim'
Plugin 'jceb/vim-orgmode'
Plugin 'tpope/vim-speeddating'
Plugin 'Townk/vim-autoclose'
Plugin 'maksimr/vim-jsbeautify'
Plugin 'reedes/vim-pencil'
Plugin 'ajh17/Spacegray.vim'
Plugin 'majutsushi/tagbar'
Plugin 'xolox/vim-easytags'
Plugin 'docunext/closetag.vim'
Plugin 'xolox/vim-misc'
Plugin 'sarahlim/wild-cherry-vim'

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
set cursorline
let base16colorspace=256

" NERDTree stuff
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Key mappings
map <C-b> <plug>NERDTreeTabsToggle<CR>
map <C-i> :tabn<CR>
map <C-h> :tabp<CR>
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()
nmap <C-m> :TagbarToggle<CR>

" Highlight current line
:hi CursorLine   cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
:hi CursorColumn cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
:nnoremap <Leader>c :set cursorline! cursorcolumn!<CR>

" Lightline color theme
let g:lightline = {
  \ 'colorscheme': 'one',
  \ }

" Editor theme
" colorscheme onedark
colorscheme wildcherry

" Line Highlight for wildcherry theme
:hi CursorLine   cterm=NONE ctermbg=53 ctermfg=white guibg=#19101e guifg=#ffffff
:hi CursorColumn cterm=NONE ctermbg=53 ctermfg=white guibg=#19101e guifg=#ffffff
:nnoremap <Leader>c :set cursorline! cursorcolumn!<CR>

" Markdown Syntax Support
augroup markdown
    au!
    au BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
augroup END

" Vim-pencil Configuration
augroup pencil
    autocmd!
    autocmd FileType markdown,mkd call pencil#init()
    autocmd FileType text         call pencil#init()
augroup END

" Neocomplete Settings
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
endif
