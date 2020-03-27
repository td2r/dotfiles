set nocompatible             " be iMproved, required
filetype off                 " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'tComment'

call vundle#end()            " required
filetype plugin indent on    " required

" Some magic words
set autoindent
set smartindent

" Highlights word when search
set incsearch

" Tab settings
set shiftwidth=4
set tabstop=4
set softtabstop=4
set smarttab
set expandtab

" Match { with {} and {; with {};
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O
inoremap {\<CR> {<CR>} printf("\n");<ESC>O

" Colorcolumn width=80, color=darkgreen
autocmd BufNewFile,BufRead *.cpp,*.java,*.py,*.js,*.sh set cc=85 | highlight ColorColumn ctermbg=8

" asm file settings
autocmd BufNewFile,BufRead *.asm set ft=nasm | set shiftwidth=16 | set tabstop=16 | set softtabstop=16

" Compiling & running .c files
command! Cc !gcc -g % -o %.out
command! Ccr !gcc -g % -o %.out && ./%.out

" Compiling & running .cpp files
command! CPPc !g++ -g % -o %.out
command! CPPcr !g++ -g % -o %.out && ./%.out

" asm compile
command! ASMc !nasm -f elf64 % -o %:r.o && ld %:r.o -o %:r
command! ASMcr !nasm -f elf64 % -o %:r.o && ld %:r.o -o %:r && ./%:r
" asm debug
command! ASMd !~/edb-debugger/build/edb --run %:r

" Compiling & running .java files
command! Jc !javac %
command! -nargs=* Jcr !javac % && java %:r <args>

" Run Python program
command! Pr !python3 %
