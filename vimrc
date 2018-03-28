" Allows mouse usage in terminal
set mouse=a

" UTF8
set encoding=utf-8

" Use syntax highlighting
syntax on
filetype on

" comments can be read easier
colorscheme desert

" removing tabs to spaces for better json editing
set tabstop=2
set expandtab

" Turning off auto indent when pasting text into vim
set paste

" setting search highlighing
set hlsearch

" Python stuff. Mostly ripped from:
"   https://realpython.com/blog/python/vim-and-python-a-match-made-in-heaven/
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix

highlight BadWhitespace ctermbg=red guibg=darkred
au BufRead,BufNewFile, *.py,*.pyw match BadWhitespace /\s\+$/

set foldmethod=indent
set foldlevel=99
nnoremap <space> za

" C stuff
au BufNewFile,BufRead *.c,*.h
    \ set syntax=c |
    \ set softtabstop=2 |
    \ set shiftwidth=2 |
    \ set expandtab |
    \ set autoindent

au BufRead,BufNewFile, *.c,*.h match BadWhitespace /\s\+$/
