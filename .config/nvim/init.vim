"---Plugins--- {{{
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call plug#begin('~/.config/plugged')

Plug 'urso/haskell_syntax.vim'
Plug 'tomasr/molokai'
Plug 'morhetz/gruvbox'
Plug 'rhysd/vim-grammarous'
" Plug 'ayu-theme/ayu-vim'
Plug 'airblade/vim-gitgutter'
Plug 'vim-scripts/indentpython.vim'
Plug 'scrooloose/nerdtree'
Plug 'tmhedberg/SimpylFold'
" Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf'
Plug 'SirVer/ultisnips'
Plug 'kana/vim-operator-user'
Plug 'haya14busa/vim-operator-flashy'
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1
Plug 'tpope/vim-commentary'
Plug 'lervag/vimtex'
Plug 'w0rp/ale'
Plug 'tpope/vim-sensible'
Plug 'honza/vim-snippets'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'WolfgangMehner/vim-plugins'
Plug 'Yggdroot/indentLine'
Plug 'danro/rename.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'autozimu/LanguageClient-neovim', {
     \ 'branch': 'next',
     \ 'do': 'bash install.sh',
     \ }
Plug 'maximbaz/lightline-ale'
Plug 'easymotion/vim-easymotion'

" All of your Plugins must be added before the following line
call plug#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
" }}}

"---GENERIC-VIM--- {{{
if $TERM == "xterm-256color"
    set t_Co=256
endif

let g:BASH_Ctrl_j = 'off'

" map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
" \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
" \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
"split navigations
" nnoremap <C-j> <C-w>j
" nnoremap <C-k> <C-w>k


nnoremap <C-l> :let @/=""<cr>
nnoremap J mzJ`z
nnoremap K gt
nnoremap <C-K> gT

set clipboard=unnamed

"Change leader to ","
let mapleader=","

" Keep the cursor in place while joining lines
" nnoremap J mzJ`z

" Add a heading/subheading to current line
nnoremap <leader>= yypVr=<Esc>==
nnoremap <leader>- yypVr-<Esc>==

" Make pasting easier
inoremap <c-v> <c-V>
inoremap <c-z> <ESC>ui
" inoremap <c-BS> <c-w>
inoremap <C-s> <ESC>:w<ENTER>a
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

"---NERDTREE---{{{
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

let NERDTreeMapActivateNode='<space>'

" Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
"}}}

"---FUNCTIONS---{{{
function! s:Usepack(package)
    execute "normal! magg/Other\<cr>o\\usepackage{". a:package. "}\<esc>`a"
endfunction

function! s:Import(import)
    execute "normal! magg/import\<cr>o\"". a:import ."\"\<esc>`a"
endfunction
"}}}

" ---DEOPLETE--- {{{
" inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" inoremap <silent><expr> <C-j> pumvisible() ? "\<C-Y>" : "\<CR>"

inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"
" }}}

"---GRAMMAROUS--- {{{
let g:grammarous#hooks = {}
let g:grammarous#show_first_error = 1
function! g:grammarous#hooks.on_check(errs) abort
    nmap <buffer><C-n> <Plug>(grammarous-move-to-next-error)
    nmap <buffer><C-p> <Plug>(grammarous-move-to-previous-error)
endfunction

let g:grammarous#disabled_rules = {
            \ '*' : ['WHITESPACE_RULE', 'EN_QUOTES'],
            \ 'help' : ['WHITESPACE_RULE', 'EN_QUOTES', 'SENTENCE_WHITESPACE', 'UPPERCASE_SENTENCE_START', 'ENGLISH_WORD_REPEAT_RULE'],
            \ }

function! g:grammarous#hooks.on_reset(errs) abort
    nunmap <buffer><C-n>
    nunmap <buffer><C-p>
endfunction
"}}}

"---FLASHY---{{{
map y <Plug>(operator-flashy)
nmap Y <Plug>(operator-flashy)$
let g:operator#flashy#flash_time=300
"}}}

"---ULTISNIPS--- {{{
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/UltiSnips']
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit='context'
" }}}

"---GITGUTTER---{{{
nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)
let g:gitgutter_override_sign_column_highlight = 0
highlight SignColumn ctermbg=233
"}}}

"---VIMTEX--- {{{
" let g:vimtex_compiler_progname = 'nvr'
let g:tex_flavor = 'latex'
" }}}

"---AYU {{{
set termguicolors
" let ayucolor="dark"
" :colo sublimemonokai
" }}}

"---VIM-COMMANDS--- {{{
:command! Init tabnew ~/.config/nvim/init.vim
:command! Src source ~/.config/nvim/init.vim
:command! -nargs=1 Up call s:Usepack(<f-args>)
:command! -nargs=1 Imp call s:Import(<f-args>)
" }}}

"---C-SUPPORT--- {{{
let g:C_UseTool_cmake    = 'yes'		" C stuff
let g:C_UseTool_doxygen  = 'yes'		" ^^
" }}}

"---AUTO-PAIRS--- {{{
let g:AutoPairsFlyMode = 0
let g:AutoPairsShortcutBackInsert = '<M-b>'
" }}}

"---LIGHTLINE_ALE {{{
let g:lightline = {
    \ 'colorscheme': 'one',
    \ 'component_expand': {
    \ 'linter_checking': 'lightline#ale#checking',
    \ 'linter_warnings': 'lightline#ale#warnings',
    \ 'linter_errors': 'lightline#ale#errors',
    \ 'linter_ok': 'lightline#ale#ok',
    \ },
    \ 'component_type': {
    \     'linter_checking': 'left',
    \     'linter_warnings': 'warning',
    \     'linter_errors': 'error',
    \     'linter_ok': 'left',
    \ },
    \ 'active': { 
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'readonly', 'filename', 'modified', 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ]]
    \ },
    \ 'component_function': {
    \   'wordcount': 'Wcount',
    \ },
    \ }

" }}}

"---FZF---{{{
let $FZF_DEFAULT_COMMAND = 'find . ! -readable -prune -o -not -path "*/\.git/*" -printf "%P\\n"'
nmap <silent> <leader>f :FZF ~<cr>
nmap <silent> <leader>F :FZF<cr>
"}}}

"---ALE--- {{{
autocmd User ALELint highlight ALEErrorSign guifg=#fb4934 guibg=#3c3836 gui=bold
nmap <silent> <leader>aj :ALENext<cr>
nmap <silent> <leader>ak :ALEPrevious<cr>
nmap <F8> <Plug>(ale_fix)
highlight clear ALEWarning
highlight ALEWarningSign guibg=NONE guifg=Yellow
highlight clear ALEError
highlight ALEError guibg=DarkRed 
highlight ALEErrorSign guibg=#b30404 guifg=#e8d94f
let g:ale_fixers = {
            \    '*': ['remove_trailing_lines', 'trim_whitespace'],
            \    'haskell': ['brittany'],
            \}
let g:ale_vim_vint_show_style_issues = 1
let g:ale_echo_cursor = 1
let g:ale_echo_msg_error_str = 'Error'
let g:ale_echo_msg_format = '%code: %%s'
let g:ale_echo_msg_warning_str = 'Warning'
let g:ale_enabled = 1
let g:ale_fix_on_save = 0
let g:ale_keep_list_window_open = 0
let g:ale_lint_delay = 200
let g:ale_lint_on_enter = 1
let g:ale_lint_on_save = 1
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_text_changed = 1
let g:ale_linter_aliases = {}
let g:ale_linters = {
\   'c': ['clang'],
\}
let g:ale_open_list = 0
let g:ale_set_highlights = 1    "enable highlights"
let g:ale_set_loclist = 1
let g:ale_set_quickfix = 0
let g:ale_set_signs = 1
let g:ale_sign_column_always = 0
let g:ale_sign_error = '✗'
let g:ale_sign_offset = 10000
let g:ale_sign_warning = '⚡︎'
let g:ale_statusline_format = ['x %d', '⚡︎%d', '']
let g:ale_warn_about_trailing_whitespace = 0
let g:ale_completion_enabled = 1
" }}}

" ---LIGHTLINE--- {{{
set laststatus=2				" Enable lightline
set noshowmode					" Turn off -- Insert--
" }}}

"---AYU--- {{{
let ayucolor="dark"
"}}}

"---INDENT-GUIDE--- {{{
let g:indentLine_color_term = 5		" Makes indent guide use colorscheme colors
let g:indentLine_char = '¦'			" Change indent char
let g:indentLine_enabled = 1			" Enable indent highlight
let g:indentLine_showFirstIndentLevel = 1
autocmd BufRead,BufNewFile *.tex IndentLinesDisable
" autocmd BufRead,BufNewFile *.tex colorscheme ayu
autocmd BufEnter *.json IndentLinesDisable
" }}}

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
    autocmd BufRead,BufNewFile *.tex,*.md setlocal spell
    autocmd BufEnter *.tex ALEDisable
    autocmd BufEnter *.vim setlocal filetype=vim
    autocmd BufEnter *.nvim setlocal filetype=vim
    autocmd BufEnter *.tex,*.md setlocal tw=74
    " autocmd BufEnter *.tex setlocal fo+=t
    autocmd BufEnter *.tex let g:AutoPairs={'(':')', '[':']', '{':'}','"':'"', '$':'$', '`':"'", '``':'"'}
    autocmd FileType vim let g:AutoPairs={'(':')', '[':']', '{':'}',"'":"'", '`':'`'}
    autocmd BufEnter *.tex setlocal concealcursor=""
    autocmd BufEnter *.tex setlocal conceallevel=0
    autocmd BufEnter *.tex hi! link Conceal Normal
    autocmd BufEnter *.tex highlight Conceal guifg=#ffcd59
    autocmd BufEnter *.tex setlocal foldmethod=marker
    autocmd BufEnter *.tex inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<Tab>"
 
    autocmd BufNewFile, BufRead *.tex set foldlevelstart=0
    autocmd BufNewFile, BufRead *.py setlocal tapstop=4
    autocmd BufNewFile, BufRead *.py setlocal softtabstop=4
    autocmd BufNewFile, BufRead *.py setlocal shitwidth=4
    autocmd BufNewFile, BufRead *.py setlocal textwidth=79
    autocmd BufNewFile, BufRead *.py setlocal expandtab
    autocmd BufNewFile, BufRead *.py setlocal autoindent
    autocmd BufNewFile, BufRead *.py setlocal fileformat=unix
    augroup END
    augroup vimrc
        au!
        au VimEnter * inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<Tab>"
    augroup END

    augroup reload_vimrc

    autocmd!
    autocmd BufWritePost ~/.config/nvim/init.vim source ~/.config/nvim/init.vim
    augroup END
" }}}

"---MOLOKAI {{{
" :colo molokai
:colo gruvbox
let g:rehash256 = 1
let g:molokai_original = 1
"}}}

"{{{ ---FUNCTIONS
"Search current working directory for word under cursor (used for xhci
"searching mostly, might remove later)
nnoremap <C-S> *N:exe ":!grep -rnw . -e ".strpart(getreg('/'), 2, (strlen(getreg('/'))-4))<CR>

"}}}
packloadall
" vim:foldmethod=marker:foldlevel=0
