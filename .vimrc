" KNote: This will start showing the status line
:set laststatus=2


" 1 set statusline=%t       "tail of the filename
" 2 set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
" 3 set statusline+=%{&ff}] "file format
" 4 set statusline+=%h      "help file flag
" 5 set statusline+=%m      "modified flag
" 6 set statusline+=%r      "read only flag
" 7 set statusline+=%y      "filetype
" 8 set statusline+=%=      "left/right separator
" 9 set statusline+=%c,     "cursor column
" 10 set statusline+=%l/%L   "cursor line/total lines
" 11 set statusline+=\ %P    "percent through file
:set statusline=%t[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%c,%l/%L\ %P


" Enable highlight for search
:set hlsearch


"Enable numbers
:set nu
