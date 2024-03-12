" -------------------------- Vundle plugins ---------------------------------
set nocompatible " Required
filetype off
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
" Let Vundle manage itself
Plugin 'gmarik/Vundle.vim'
" Idk, smth for cpp highlight
Plugin 'octol/vim-cpp-enhanced-highlight'
" Comment/uncomment on ctrl+/ twice
Plugin 'tComment'
" Highlight current search entry
Plugin 'peterrincker/vim-searchlight'
" :noh on cursor move
Plugin 'jesseleite/vim-noh'
" Colorscheme
Plugin 'morhetz/gruvbox'
Plugin 'alessandroyorba/alduin'
call vundle#end()
filetype plugin indent on

" -------------------------- Common settings --------------------------------
" Return to last edit position when opening files
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" let g:alduin_Shout_Dragon_Aspect = 1
colorscheme alduin
" colorscheme gruvbox
" colorscheme vividchalk

" ------------------------- Cursor style ------------------------------------
" Change cursor style in different modes
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" Reset the cursor on start (for older versions of vim, usually not required)
augroup myCmds
au!
autocmd VimEnter * silent !echo -ne "\e[2 q"
augroup END

" Other options (replace the number after \e[):
" 0 -> blinking block.
" 1 -> blinking block (default).
" 2 -> steady block.
" 3 -> blinking underline.
" 4 -> steady underline.
" 5 -> blinking bar (xterm).
" 6 -> steady bar (xterm).

" ------------------------- Settings flags -----------------------------------
" Fix backspace in insert mode
set backspace=indent,eol,start

" Highlight search
set incsearch
" Disable bells
set belloff=all
set novisualbell

" Tabs and indents
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smarttab
set expandtab
set autoindent
set smartindent

" Enumerate lines
set number

" Enable syntax highlighting
syntax on

" No swap file!
set noswapfile

" Auto-read externaly modified file
" Use :e to reload
set autoread

" Show line number, column number, virtual column number and the relative
" position on right bottom
set ruler

" Highlight all search entries
" Use :noh to hide
set hlsearch

" Move cursor with mouse tap!
" set mouse=a

set undodir=~/.vim/undo//
" Undo even after re-open file!
set undofile
" Maximum number of changes that can be undone
set undolevels=1000
" Maximum number lines to save for undo on a buffer reload
set undoreload=10000

" Okay, may be useful
set encoding=utf-8
set fileencodings=utf-8,ucs-bom,cp1251,koi8-r,default,latin1

" ------------------------- Mappings -----------------------------------------
" Brackets pairing
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O
inoremap {\<CR> {<CR>} printf("\n");<ESC>O

" Iterate over tabs faster!
nmap <C-l> :tabnext<CR> " gt
imap <C-l> <Esc>:tabnext<CR>
nmap <C-h> :tabprevious<CR> " gT
imap <C-h> <Esc>:tabprevious<CR>
nmap <C-n> :tabnew<CR>

" Okay
map ё `
map й q
map ц w
map у e
map к r
map е t
map н y
map г u
map ш i
map щ o
map з p
map х [
map ъ ]
map ф a
map ы s
map в d
map а f
map п g
map р h
map о j
map л k
map д l
map ж ;
map э '
map я z
map ч x
map с c
map м v
map и b
map т n
map ь m
map б ,
map ю .
map Ё ~
map Й Q
map Ц W
map У E
map К R
map Е T
map Н Y
map Г U
map Ш I
map Щ O
map З P
map Х {
map Ъ }
map Ф A
map Ы S
map В D
map А F
map П G
map Р H
map О J
map Л K
map Д L
map Ж :
map Э "
map Я Z
map Ч X
map С C
map М V
map И B
map Т N
map Ь M
map Б <
map Ю >

" ------------------------- Filetype dependent settings --------------------------
"  Better use ftplugin for some more complicated cases.
"  This realisation has problems with re-loading files with different
"  extensions

" sout in java
autocmd BufRead,BufNewFile *.java
    \ inoremap sout<TAB> System.out.println();<ESC>hi

" Bounding line
autocmd BufNewFile,BufRead *.c,*.cpp,*.java,*.py,*.sh,*.vimrc
            \ set cc=85 | highlight ColorColumn ctermbg=8

" 2 spaces tab for .sh
autocmd BufNewFile,BufRead *.sh
            \ set tabstop=2 shiftwidth=2 softtabstop=2

" 16 spaces tab for assembler
autocmd BufNewFile,BufRead *.asm,.*nasm
            \ set tabstop=16 shiftwidth=16 softtabstop=16

" ------------------------- Compilation --------------------------------------
"  This only useful for competitive programming tasks
let s:compile_line = {
            \ "asm"  : "nasm -f elf64 % -o %:r.o && ld %:r.o -o %:r",
            \ "c"    : "gcc -g % -o %:r.out",
            \ "cpp"  : has('win32') || has('win32unix')
            \               ? "g++ -O2 -Wall -std=gnu++11 % -o %:r.exe"
            \               : "g++ -fsanitize=address -g % -o %:r.out",
            \ "java" : "javac %",
            \ "sh"   : "chmod u+x %"
            \}

let s:run_line = {
            \ "asm"    : "./%:r",
            \ "c"      : "./%:r.out",
            \ "cpp"    : has('win32') || has('win32unix')
            \               ? "./%:r.exe"
            \               : "./%:r.out",
            \ "java"   : "java %:r",
            \ "python" : "python3 %",
            \ "sh"     : "./%"
            \}

function! Compile() abort
    if (has_key(s:compile_line, &ft))
        execute("!" . get(s:compile_line, &ft))
    else
        echo 'No compile script for this filetype'
    endif
endfunction

function! Compile_and_run(...) abort
    if (has_key(s:run_line, &ft))
        " call feedkeys("\<CR>")
        silent call Compile()
        unsilent execute( "!" . get(s:run_line, &ft)) . (a:0 ? " < %:h/" . a:1 : "")
    else
        echo 'No execute script for this filetype'
    endif
endfunction

noremap <C-F10> :call Compile()<CR>
noremap <F10> :call Compile_and_run()<CR>
noremap <S-F10> :call Compile_and_run("data.in")<CR>
" ------------------------- \Compilation -------------------------------------
