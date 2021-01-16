"---GENERIC-VIM--- {{{
if $TERM == "xterm-256color"
    set t_Co=256
endif

set autoindent

" map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
" \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
" \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
"split navigations
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> :let @/=""<cr>

set clipboard=unnamed

"Change leader to ","
let mapleader=","

" Keep the cursor in place while joining lines
nnoremap J mzJ`z

" Add a heading/subheading to current line
nnoremap <leader>= yypVr=<Esc>==
nnoremap <leader>- yypVr-<Esc>==

" Make pasting easier
inoremap <c-v> <c-V>
inoremap <c-z> <ESC>ui
" inoremap <c-BS> <c-w>

" Don't let x and c to spoil the yank register
nnoremap x "_x
nnoremap c "_c

" For folds
set foldmethod=indent
set modelines=1
set foldenable
set foldlevelstart=10 "open most folds by default
set foldnestmax=10 "max 10 nested folds
nnoremap <space> za

let g:ruby_host_prog = '/var/lib/gems/2.5.0/gems/neovim-0.8.0/exe/neovim-ruby-host'
set guifont=Go

" move vertically by visual line
nnoremap j gj
nnoremap k gk


" Title
set title
execute "set titleold=Terminal"
set backspace=indent,eol,start			" Make backspace work
syntax on					" Turn on highlighting
set number					" Turn on line numbers
set relativenumber

" Change tab spaces and make soft
:set tabstop=4
autocmd Filetype css setlocal tabstop=2
:set shiftwidth=4
:set expandtab

" Fix ctrl backspace (doesn't work)
" noremap! <C-BS> <C-w>
inoremap <c-h> <c-w>

" Make searching better
set smartcase
set ignorecase

" I don't remember why I did this
cnoreabbrev W w

" Make it easier to hit command
nnoremap ; :
vnoremap ; :
inoremap jk <ESC>
inoremap kj <ESC>
" }}}

"---FUNCTIONS---{{{
function! s:Usepack(package)
    execute "normal! magg/Other\<cr>o\\usepackage{". a:package. "}\<esc>`a"
endfunction
"}}}

"---autocommands--- {{{
augroup configgroup
    autocmd!
    autocmd VimEnter * highlight clear SignColumn
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
    autocmd BufRead,BufNewFile *.tex setlocal spell
    autocmd BufEnter *.tex ALEDisable
    autocmd BufEnter *.vim setlocal filetype=vim
    autocmd BufEnter *.nvim setlocal filetype=vim
    autocmd BufEnter *.tex setlocal tw=74
    autocmd BufEnter *.tex setlocal fo+=t
    autocmd BufEnter *.tex let g:AutoPairs={'(':')', '[':']', '{':'}','"':'"', '$':'$', '`':"'", '``':'"'}
    autocmd FileType vim let g:AutoPairs={'(':')', '[':']', '{':'}',"'":"'", '`':'`'}
    autocmd BufEnter *.tex setlocal concealcursor=""
    autocmd BufEnter *.tex setlocal conceallevel=0
    autocmd BufEnter *.tex hi! link Conceal Normal
    autocmd BufEnter *.tex highlight Conceal guifg=#ffcd59
    autocmd BufEnter *.tex setlocal foldmethod=marker
    autocmd BufNewFile, BufRead *.tex set foldlevelstart=0
    autocmd BufNewFile, BufRead *.py setlocal tapstop=4
    autocmd BufNewFile, BufRead *.py setlocal softtabstop=4
    autocmd BufNewFile, BufRead *.py setlocal shitwidth=4
    autocmd BufNewFile, BufRead *.py setlocal textwidth=79
    autocmd BufNewFile, BufRead *.py setlocal expandtab
    autocmd BufNewFile, BufRead *.py setlocal autoindent
    autocmd BufNewFile, BufRead *.py setlocal fileformat=unix
augroup END
" }}}

" vim:foldmethod=marker:foldlevel=0
