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
Plug 'catppuccin/nvim'
Plug 'tpope/vim-repeat'
" Plug 'ayu-theme/ayu-vim'
Plug 'airblade/vim-gitgutter'
Plug 'vim-scripts/indentpython.vim'
Plug 'preservim/nerdtree' |
            \ Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tmhedberg/SimpylFold'
" Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
"Plug 'itchyny/lightline.vim'
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
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-sensible'
Plug 'honza/vim-snippets'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'hankchiutw/nerdtree-ranger.vim'
Plug 'WolfgangMehner/vim-plugins'
Plug 'Yggdroot/indentLine'
Plug 'danro/rename.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'ryanoasis/vim-devicons'
"Plug 'autozimu/LanguageClient-neovim', {
"     \ 'branch': 'next',
"     \ 'do': 'bash install.sh',
"     \ }
" Plug 'maximbaz/lightline-ale'
Plug 'easymotion/vim-easymotion'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

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

" ---TREE-SITTER--- {{{
lua <<EOF
  require('nvim-treesitter.configs').setup {
  ensure_installed = { "c", "lua", "vim", "python", "vimdoc", "query" },
  highlight = { enable = true},
  indent = { enable = true },
}
EOF
"  }}}

"---GENERIC-VIM--- {{{
if $TERM == "xterm-256color"
    set t_Co=256
endif

let g:BASH_Ctrl_j = 'off'

nnoremap <C-l> :nohl<cr>
nnoremap J mzJ`z
nnoremap K gt
nnoremap <C-K> gT

set clipboard=unnamed

"Change leader to ","
let mapleader=","

" Add a heading/subheading to current line
nnoremap <leader>= yypVr=<Esc>==
nnoremap <leader>- yypVr-<Esc>==

" Make pasting easier
inoremap <c-v> <c-V>
inoremap <c-z> <ESC>ui
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
set updatetime=200

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

" SOL and EOL easier
nnoremap H ^
nnoremap L $
vnoremap H ^
vnoremap L $

" }}}

"---NERDTREE---{{{
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-e> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

let NERDTreeMapActivateNode='<space>'

" Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

let g:NERDTreeGitStatusUseNerdFonts = 1

let g:NERDTreeGitStatusIndicatorMapCustom = {
                \ 'Modified'  :'M',
                \ 'Staged'    :'+',
                \ 'Untracked' :'U',
                \ 'Renamed'   :'➜',
                \ 'Unmerged'  :'═',
                \ 'Deleted'   :'D',
                \ 'Dirty'     :'●',
                \ 'Ignored'   :'☒',
                \ 'Clean'     :'✔︎',
                \ 'Unknown'   :'?',
                \ }
"}}}

"---MOLOKAI {{{
" :colo molokai
colorscheme catppuccin-mocha
let g:rehash256 = 1
let g:molokai_original = 1
"}}}

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
let g:gitgutter_override_sign_column_highlight=1
let g:gitgutter_sign_added = '▐'
let g:gitgutter_sign_modified = ''
highlight GitGutterChange guifg=#add8e6 
highlight GitGutterAdd guifg=#b8bb26
highlight SignColumn ctermbg=233
"}}}

"---VIMTEX--- {{{
let g:tex_flavor = 'latex'
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

"---FZF---{{{
let $FZF_DEFAULT_COMMAND = 'find . ! -readable -prune -o -not -path "*/\.git/*" -printf "%P\\n"'
nmap <silent> <leader>f :FZF ~<cr>
nmap <silent> <leader>F :FZF<cr>
"}}}

"---ALE--- {{{
let g:ale_enabled = 1
nmap <silent> <leader>aj :ALENext<cr>
nmap <silent> <leader>ak :ALEPrevious<cr>
nmap <F8> <Plug>(ale_fix)
highlight clear ALEWarning
highlight ALEWarningSign guibg=NONE guifg=Yellow
highlight clear ALEError
highlight ALEError guibg=DarkRed 
highlight ALEErrorSign guibg=#b30404 guifg=#e8d94f
let g:ale_fixers = {
            \   '*': ['remove_trailing_lines', 'trim_whitespace'],
            \   'c': ['clang-tidy'],
            \}
let g:ale_vim_vint_show_style_issues = 1
let g:ale_echo_cursor = 1
let g:ale_echo_msg_error_str = 'Error'
let g:ale_echo_msg_format = '%code: %%s'
let g:ale_echo_msg_warning_str = 'Warning'
let g:ale_fix_on_save = 0
let g:ale_keep_list_window_open = 0
let g:ale_lint_delay = 200
let g:ale_lint_on_enter = 1
let g:ale_lint_on_save = 1
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_text_changed = 1
let g:ale_linter_aliases = {}
let g:ale_linters = {
\   'c': ['clangd'],
\   'python': ['jedils', 'pylint'],
\   'vim': ['vimls'],
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
let g:ale_statusline_format = ['✗ %d', '⚡︎%d', '']
let g:ale_warn_about_trailing_whitespace = 0
let g:ale_completion_enabled = 0
" call deoplete#custom#option('sources', {
" \ '_': ['ale', 'clangd'],
" \})

let g:ale_floating_preview= 1
autocmd User ALELint highlight ALEErrorSign guifg=#fb4934 guibg=#3c3836 gui=bold
nnoremap <silent> gd :ALEGoToDefinition<CR>
nnoremap <silent> <leader>gd :tabnew %<CR><c-o>:ALEGoToDefinition<CR>gT
nnoremap <silent> gh :ALEHover<CR>
let g:ale_floating_window_border = ['│', '─', '╭', '╮', '╯', '╰']
nnoremap <silent> <F2> :ALERename<CR>
" }}}

" ---DEOPLETE--- {{{
call deoplete#custom#source('_', 'matchers', ['matcher_full_fuzzy'])
call deoplete#custom#source('ale', 'rank', 999)
autocmd CompleteDone * silent! pclose!
"  }}}

" ---AIRLINE--- {{{
" set laststatus=2				" Enable lightline
set noshowmode					" Turn off -- Insert--
let g:airline_theme='base16_dracula'
let g:airline#extensions#hunks#non_zero_only = 0
let g:airline_powerline_fonts = 1
let g:airline_section_z = airline#section#create(['%p%%% '])
let g:airline_section_b = airline#section#create([' %{airline#util#wrap(airline#extensions#hunks#get_hunks(),100)}%{airline#util#wrap(airline#extensions#branch#get_head(),80)}'])
let g:airline_section_warning = airline#section#create(['ale_warning_count', 'syntastic-warn', 'languageclient_warning_count'])
let g:airline_symbols.branch=''
let g:airline_symbols.dirty='+'
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


"{{{ ---FUNCTIONS
"Search current working directory for word under cursor (used for xhci
"searching mostly, might remove later)
nnoremap <C-S> *N:exe ":!grep -rnw . -e ".strpart(getreg('/'), 2, (strlen(getreg('/'))-4))<CR>

"}}}
finish
" vim:foldmethod=marker:foldlevel=0
