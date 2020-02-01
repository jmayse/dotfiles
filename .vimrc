" Colors {{{

colorscheme jellybeans                   " define colorscheme
syntax enable                            " enable syntax processing
set termguicolors
" }}}
" Whitespace {{{

set tabstop=4                            " number of visual spaces per tab
set softtabstop=4                        " number of space in tab when editing
set expandtab                            " tabs are spaces
set modeline                             " modeline enable - Debian sets nomodelines by default
set modelines=1                          " modelines
filetype indent on                       " use file-specific indents
" }}}
" UI {{{

set number                               " line numbers
set showcmd                              " show command in bottom bar
set nocursorline                         " don't highlight current line
filetype indent on                       " file-specific indents
set wildmenu                             " set wildmenu
set lazyredraw                           " don't redraw unless we have to
set showmatch                            " highlight matches for [{()}]
" }}}
" Search {{{

set incsearch                            " search as you type
set hlsearch                             " highlight search matches
"mod-space turns off highlighting
nnoremap <leader><space> :nohlsearch<CR>
" }}}
" Folding {{{

set foldenable                           " enable folding
set foldmethod=indent                    " fold based on indentation
set foldlevelstart=10                    " open most folds by default
set foldnestmax=10                       " 10 nested fold max
" space open/closes folds
nnoremap <tab> za 
" }}}
" Movement and Text {{{

" move by visual line verticalls
nnoremap j gj
nnoremap k gk

" move to the beginning/end of line
nnoremap B ^
nnoremap E $

" highlight last inserted text
nnoremap gV `[v`]
" }}}
" Leader Shortcuts {{{
" space is leader
let mapleader=" "

" jk is escape
inoremap jk <esc>

" gundo
nnoremap <leader>u :GundoToggle<CR>

" manage vimrc
nnoremap <leader>ev :vsp $MYVIMRC<CR>
nnoremap <leader>ez :vsp ~/.zshrc<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

" save session
nnoremap <leader>s :mksession<CR>
" }}}
" On Launch {{{
call pathogen#infect()                   " pathogen

" }}}
" NERDTree {{{
map <C-l> :tabn<CR>
map <C-h> :tabp<CR>
map <C-n> :tabnew<CR>

let NERDTreeQuitOnOpen=1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" automatically open nerdtree on vim open
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" close vim if the only window left is nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" }}}
" NERDTree Git {{{
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }
" }}}
" TMUX {{{
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\" 
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif
" }}}
" Configuration {{{
augroup configgroup
    autocmd!
    autocmd VimEnter * highlight clear SignColumn
    autocmd BufWritePre *.php,*.py,*.js,*.txt,*.hs,*.java,*.md
                \:call <SID>StripTrailingWhitespaces()
    autocmd FileType java setlocal noexpandtab
    autocmd FileType java setlocal list
    autocmd FileType java setlocal listchars=tab:+\ ,eol:-
    autocmd FileType java setlocal formatprg=par\ -w80\ -T4
    autocmd FileType php setlocal expandtab
    autocmd FileType php setlocal list
    autocmd FileType php setlocal listchars=tab:+\ ,eol:-
    autocmd FileType php setlocal formatprg=par\ -w80\ -T4
    autocmd FileType ruby setlocal tabstop=2
    autocmd FileType ruby setlocal shiftwidth=2
    autocmd FileType ruby setlocal softtabstop=2
    autocmd FileType ruby setlocal commentstring=#\ %s
    autocmd FileType python setlocal commentstring=#\ %s
    autocmd BufEnter *.cls setlocal filetype=java
    autocmd BufEnter *.zsh-theme setlocal filetype=zsh
    autocmd BufEnter Makefile setlocal noexpandtab
    autocmd BufEnter *.sh setlocal tabstop=2
    autocmd BufEnter *.sh setlocal shiftwidth=2
    autocmd BufEnter *.sh setlocal softtabstop=2
augroup END
" }}}
" Backups {{{

set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup
" }}}
" Functions {{{

" toggle between number and relativenumber
function! ToggleNumber()
    if(&relativenumber == 1)
        set norelativenumber
        set number
    else
        set relativenumber
    endif
endfunc

" strips trailing whitespace at the end of files. this
" is called on buffer write in the autogroup above.
function! <SID>StripTrailingWhitespaces()
    " save last search & cursor position
    let _s=@/
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    let @/=_s
    call cursor(l, c)
endfunc
" }}}
" vim:foldmethod=marker:foldlevel=0
