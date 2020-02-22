set nocompatible             " be iMproved, required
filetype off                 " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'tComment'
Plugin 'asmx86_64'

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
autocmd BufNewFile,BufRead *.cpp,*.java,*.py,*.sh set cc=85 | highlight ColorColumn ctermbg=8

" Use asm plugin if .asm
autocmd BufNewFile,BufRead *.asm set syntax=asmx86_64 | set shiftwidth=16

" Compiling & running .cpp files
command! CPPc !g++ -g % -o %.out
command! CPPcr !g++ -g % -o %.out && ./%.out

" Compiling & running .java files
command! Jc !javac %
command! -nargs=* Jcr !javac % && java %:r <args>
