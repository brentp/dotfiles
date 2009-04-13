" vimrc file for following the coding standards specified in PEP 7 & 8.
"
" To use this file, source it in your own personal .vimrc file (``source
" <filename>``) or, if you don't have a .vimrc file, you can just symlink to it
" (``ln -s <this file> ~/.vimrc``).  All options are protected by autocmds
" (read below for an explanation of the command) so blind sourcing of this file
" is safe and will not affect your settings for non-Python or non-C files.
"
"
" All setting are protected by 'au' ('autocmd') statements.  Only files ending
" in .py or .pyw will trigger the Python settings while files ending in *.c or
" *.h will trigger the C settings.  This makes the file "safe" in terms of only
" adjusting settings for Python and C files.
"
" Only basic settings needed to enforce the style guidelines are set.
" Some suggested options are listed but commented out at the end of this file.


au BufRead,BufNewFile *py,*pyw,*.c,*.h set tabstop=4

set shiftwidth=4
set tabstop=4
set expandtab

" Replace tabs with the equivalent number of spaces.
" Also have an autocmd for Makefiles since they require hard tabs.
" Python: yes
" C: no
" Makefile: no
au BufRead,BufNewFile *.c,*.h set noexpandtab
au BufRead,BufNewFile Makefile* set noexpandtab
    
highlight BadWhitespace ctermbg=red guibg=red
" Display tabs at the beginning of a line in Python mode as bad.
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
" Make trailing whitespace be flagged as bad.
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" Wrap text after a certain number of characters
" Python: 79 
" C: 79
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h set textwidth=79

" Turn off settings in 'formatoptions' relating to comment formatting.
" - c : do not automatically insert the comment leader when wrapping based on
"    'textwidth'
" - o : do not insert the comment leader when using 'o' or 'O' from command mode
" - r : do not insert the comment leader when hitting <Enter> in insert mode
" Python: not needed
" C: prevents insertion of '*' at the beginning of every line in a comment
au BufRead,BufNewFile *.c,*.h set formatoptions-=c formatoptions-=o formatoptions-=r


" ----------------------------------------------------------------------------
" The following section contains suggested settings.  While in no way required
" to meet coding standards, they are helpful.

" Set the default file encoding to UTF-8: ``set encoding=utf-8``

" Puts a marker at the beginning of the file to differentiate between UTF and
" UCS encoding (WARNING: can trick shells into thinking a text file is actually
" a binary file when executing the text file): ``set bomb``

" For full syntax highlighting:
let python_highlight_all=1
syntax on``

" Automatically indent based on file type: 
filetype indent on
" Keep indentation level from previous line: 
set autoindent

" Folding based on indentation: 
"set foldmethod=indent

" #######################################################
" #######################################################
" #######################################################
" end python.org file.
" #######################################################
" #######################################################
" #######################################################

" find match while typing
"
set incsearch
set fileformat=unix
set smartindent
set showmatch
filetype plugin on
filetype plugin indent on
set nocompatible

" Autocomplete vim commands on tab
set wildmenu  
set wildmode=list:longest,full
"set wildchar=<TAB>

"set number    " Line numbering
set hlsearch  " Highlight search
hi Search       term=reverse  ctermfg=White ctermbg=Black guibg=Black guifg=White

set laststatus=2
set statusline=%<%f\ %h%r%m%=%-14.(%l,%c%V%)\ %P
"set statusline=(%(%l,%c%))\ %<%F%=\ [%M%R%H%Y]\ [ascii\ %3b]\ %P

let g:miniBufExplSplitBelow = 0
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplUseSingleClick = 1

" http://dotfiles.org/~starg/.vimrc
" Map F6 to execute a Python script interactively. NICE
autocmd FileType python imap <F6> <C-O>:w<CR>:!ipython -i "%"<CR>
autocmd FileType python map <F6> :w<CR>:!ipython -i "%"<CR>

set history=200

behave mswin " for copy/paste

" clipboard use right click:
set clipboard+=unnamed

set lazyredraw
" magic in search pattersn
set magic
" show the uncompleted command
set showcmd

set nostartofline
set notextmode
set visualbell
set backspace=indent,eol,start


set nowritebackup

" after opening a sp window, can jump up/down with ctrl + j/k
" NICE
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_


" Tell vim to remember certain things when we exit
" "  '10 : marks will be remembered for up to 10 previously edited files
" "  "100 : will save up to 100 lines for each register
" "  :20 : up to 20 lines of command-line history will be remembered
" "  % : saves and restores the buffer list
" "  n... : where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.viminfo
 
" jump to last know position in file:
" http://vimdoc.sourceforge.net/htmldoc/eval.html#last-position-jump
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


" Syntax Checking entire file
" Usage: :make (check file)
" :clist (view list of errors
" :cn, :cp (move around list of errors)
autocmd BufRead *.py set makeprg=python\ -c\ \"import\ py_compile,sys;\ sys.stderr=sys.stdout;\ py_compile.compile(r'%')\"
autocmd BufRead *.py set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m

set encoding=utf-8

" tab completion of python comands
" import re
" "re.f<tab> brings up a menu.
let g:SuperTabDefaultCompletionType = "<C-X><C-O>"
autocmd FileType python set omnifunc=pythoncomplete#Complete
inoremap <TAB> <C-x><C-o>
inoremap <TAB> <C-r>=InsertTabWrapper()<CR>
set expandtab

" http://www.mattrope.com/computers/conf/vimrc.html
" InsertTabWrapper() {{{
" Tab completion of tags/keywords if not at the beginning of the
" line.  Very slick.
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
" InsertTabWrapper() }}}

" http://stackoverflow.com/questions/164847/what-is-in-your-vimrc#164935
" highlight the word under the cursor
highlight flicker cterm=bold ctermfg=red
au CursorMoved <buffer> exe 'match flicker /\V\<'.escape(expand('<cword>'), '/').'\>/'




" http://blog.sontek.net/2008/05/11/python-with-a-modular-ide-vim/
" execute the visually selected block by hitting Ctrl + h
python << EOL
import vim
def EvaluateCurrentRange():
    eval(compile('\n'.join(vim.current.range),'','exec'),globals())
EOL
map <C-h> :py EvaluateCurrentRange()

" http://stackoverflow.com/questions/164847/what-is-in-your-vimrc#165267
" Make cursor move as expected with wrapped lines:
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk


let g:clipbrdDefaultReg = '+'


" TODO: more stuff from here:
" http://blog.sontek.net/2008/05/11/python-with-a-modular-ide-vim/


autocmd BufRead *.as set filetype=actionscript
autocmd BufRead *.hx set filetype=actionscript
autocmd BufRead *.clj set filetype=clojure

filetype plugin indent on
syntax on
set nocompatible
let clj_highlight_builtins = 1
let clj_paren_rainbow = 1


" allow using the mouse to set cursor location, etc.
set mouse=a
