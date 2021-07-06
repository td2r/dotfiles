" Vundle plugins
set nocompatible
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'tComment'
call vundle#end()

filetype plugin indent on

" Highlight search
set incsearch

" Tabs and indents
let &tabstop = (&ft ==# 'asm' ? 16 : 4)
let &shiftwidth = &tabstop
let &softtabstop = &shiftwidth
set expandtab smarttab autoindent smartindent

" Bounding line
autocmd BufNewFile,BufRead *.c,*.cpp,*.java,*.py,*.sh,*.vimrc
            \ set cc=85 | highlight ColorColumn ctermbg=8

" Brackets pairing
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O
inoremap {\<CR> {<CR>} printf("\n");<ESC>O

" sout in java
if (&ft ==# 'java')
    inoremap sout<TAB> System.out.println();<ESC>hi
endif

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
