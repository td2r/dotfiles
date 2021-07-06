" Vundle plugins
set nocompatible
filetype on
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'tComment'
call vundle#end()
filetype plugin indent on

" Autoindents
set autoindent
set smartindent

" Highlight search
set incsearch

" Tab settings
set smarttab
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

" Brackets pairing
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O
inoremap {\<CR> {<CR>} printf("\n");<ESC>O

" Bounding line
autocmd BufNewFile,BufRead *.c,*.cpp,*.java,*.py,*.js,*.sh set cc=85 | highlight ColorColumn ctermbg=8

" sout in java
autocmd BufNewFile,BufRead *.java inoremap sout<TAB> System.out.println();<ESC>hi

" asm file settings
autocmd BufNewFile,BufRead *.asm set ft=nasm | set shiftwidth=16 | set tabstop=16 | set softtabstop=16

let s:compile_line = {
            \ "asm"  : "nasm -f elf64 % -o %:r.o && ld %:r.o -o %:r",
            \ "c"    : "gcc -g % -o %:r.out",
            \ "cpp"  : has('win32')
            \               ? "g++ -O2 -Wall -std=gnu++11 -fsanitize=address % -o %:r.exe"
            \               : "g++ -fsanitize=address -g % -o %:r.out",
            \ "java" : "javac %"
            \}

let s:run_line = {
            \ "asm"    : "./%:r",
            \ "c"      : "./%:r.out",
            \ "cpp"    : has('win32')
            \               ? "%:r.exe"
            \               : "./%:r.out",
            \ "java"   : "java %:r",
            \ "python" : "python3 %"
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
        execute( "!"
                    \ . (has_key(s:compile_line, &ft) ? get(s:compile_line, &ft) . " && " : "")
                    \ . get(s:run_line, &ft)) . (a:0 ? " < %:h/" . a:1 : "")
    else
        echo 'No execute script for this filetype'
    endif
endfunction

noremap <C-F10> :call Compile()<CR>
noremap <F10> :call Compile_and_run()<CR>
noremap <S-F10> :call Compile_and_run("data.in")<CR>
