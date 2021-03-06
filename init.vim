

" disable bell 
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

set nocompatible
set noswapfile " better speed, but a little danger  
set nobackup   " no backup 
set autoread   " auto reload a file 
set autochdir  

set backspace=2
set backspace=indent,eol,start

" keep command or search history
set history=400

"" edit basic setting 
" set clipboard=unamed  " connect clipboard with vim register
set paste

"" 
set virtualedit=all
set nowrap

set tabstop=4      "stay the same with 8
set softtabstop=4
set shiftwidth=4
set expandtab

"" basic behavior 
set incsearch
set hlsearch

"" file format not dos 
set fileformat=unix 

"" GUI
colorscheme koehler
set guioptions-=m " remove menu
set guioptions-=T " remove toolbar
set guioptions+=a " autoselect ???
set guioptions+=R " right hand scroller 
set laststatus=2  " always show the status line
syntax on
filetype plugin indent on

set list listchars=tab:>-,trail:_
hi SpecialKey guifg=#333333 

hi Visual term=None cterm=None gui=None guibg=grey40

set nu

"" MY special mapping 
 nnoremap <c-s> <ESC>:w<CR>
 inoremap <c-s> <ESC>:w<CR>

 " open file explorer
 nnoremap <a-e> :e .<CR>

 nnoremap - "_

 nnoremap <SPACE> <PageDown>
 nnoremap <S-SPACE> <PageUp>
 nnoremap <c-k> 5gk
 nnoremap <c-j> 5gj
 nnoremap <c-h> 15h
 nnoremap <c-l> 15l
 xnoremap <c-k> 5gk
 xnoremap <c-j> 5gj
 xnoremap <c-h> 15h
 xnoremap <c-l> 15l
 
 cnoremap <c-k> <Up>
 cnoremap <c-j> <Down>
 
 let mapleader = "s"
 nnoremap s <ESC>

 "" TabPage """""""""""""""""""""""""""""""
 nnoremap <A-h> :tabp<CR>
 nnoremap <A-l> :tabn<CR>

 " copy file path 
 nnoremap <c-g> :silent let @*=expand("%:p")<CR>:silent let @"=expand("%:p")<CR>:echo expand("%:p")<CR>:silent let @f=expand("%:p") . ":" . line('.')<CR>

 " use control v as paste clipboard
 cnoremap <c-v> <c-r>*

