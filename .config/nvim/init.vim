"---Plugins--- {{{
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call plug#begin('~/.config/plugged')

Plug 'rhysd/vim-grammarous'
Plug 'tpope/vim-repeat'
Plug 'airblade/vim-gitgutter'
Plug 'vim-scripts/indentpython.vim'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'kevinhwang91/rnvimr'
Plug 'tmhedberg/SimpylFold'
Plug 'nvim-telescope/telescope.nvim'
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
Plug 'tomtom/tcomment_vim'
Plug 'lervag/vimtex'
Plug 'w0rp/ale'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-sensible'
Plug 'honza/vim-snippets'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'WolfgangMehner/vim-plugins'
Plug 'Yggdroot/indentLine'
Plug 'danro/rename.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'easymotion/vim-easymotion'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-lua/plenary.nvim'
Plug 'shatur/neovim-session-manager'
Plug 'goolord/alpha-nvim'

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

"---LUA--- {{{
lua <<EOF
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    require('nvim-treesitter.configs').setup({
        ensure_installed = { "c", "lua", "vim", "python", "vimdoc", "query" },
        highlight = { enable = true},
        indent = { enable = true },
    }) 

    require('catppuccin').setup({
        custom_highlights = function(colors)
        return {
            Date = { fg = colors.blue },
        }
    end

    })

    local function my_on_attach(bufnr)
        local api = require "nvim-tree.api"

        local function opts(desc)
            return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        local api = require("nvim-tree.api")

        local function edit_or_open()
          local node = api.tree.get_node_under_cursor()

          if node.nodes ~= nil then
            -- expand or collapse folder
            api.node.open.edit()
          else
            -- open file
            api.node.open.edit()
            -- Close the tree if file was opened
            api.tree.close()
          end
        end

        -- open as vsplit on current node
        local function vsplit_preview()
          local node = api.tree.get_node_under_cursor()

          if node.nodes ~= nil then
            -- expand or collapse folder
            api.node.open.edit()
          else
            -- open file as vsplit
            api.node.open.vertical()
          end

          -- Finally refocus on tree if it was lost
          api.tree.focus()
        end

        -- global keymap
        vim.api.nvim_set_keymap("n", "<C-E>", ":NvimTreeToggle<cr>", {silent = true, noremap = false})
        -- default mappings {{{

        vim.keymap.set('n', '<C-]>',   api.tree.change_root_to_node,        opts('CD'))
        --vim.keymap.set('n', '<C-e>',   api.node.open.replace_tree_buffer,   opts('Open: In Place'))
        vim.keymap.set('n', '<C-k>',   api.node.show_info_popup,            opts('Info'))
        vim.keymap.set('n', '<C-r>',   api.fs.rename_sub,                   opts('Rename: Omit Filename'))
        vim.keymap.set('n', '<C-t>',   api.node.open.tab,                   opts('Open: New Tab'))
        vim.keymap.set('n', '<C-v>',   api.node.open.vertical,              opts('Open: Vertical Split'))
        vim.keymap.set('n', '<C-x>',   api.node.open.horizontal,            opts('Open: Horizontal Split'))
        vim.keymap.set('n', '<BS>',    api.node.navigate.parent_close,      opts('Close Directory'))
        vim.keymap.set('n', '<CR>',    api.node.open.edit,                  opts('Open'))
        vim.keymap.set('n', '<Tab>',   api.node.open.preview,               opts('Open Preview'))
        vim.keymap.set('n', '>',       api.node.navigate.sibling.next,      opts('Next Sibling'))
        vim.keymap.set('n', '<',       api.node.navigate.sibling.prev,      opts('Previous Sibling'))
        vim.keymap.set('n', '.',       api.node.run.cmd,                    opts('Run Command'))
        vim.keymap.set('n', '-',       api.tree.change_root_to_parent,      opts('Up'))
        vim.keymap.set('n', 'a',       api.fs.create,                       opts('Create File Or Directory'))
        vim.keymap.set('n', 'bd',      api.marks.bulk.delete,               opts('Delete Bookmarked'))
        vim.keymap.set('n', 'bt',      api.marks.bulk.trash,                opts('Trash Bookmarked'))
        vim.keymap.set('n', 'bmv',     api.marks.bulk.move,                 opts('Move Bookmarked'))
        vim.keymap.set('n', 'B',       api.tree.toggle_no_buffer_filter,    opts('Toggle Filter: No Buffer'))
        vim.keymap.set('n', 'c',       api.fs.copy.node,                    opts('Copy'))
        vim.keymap.set('n', 'C',       api.tree.toggle_git_clean_filter,    opts('Toggle Filter: Git Clean'))
        vim.keymap.set('n', '[c',      api.node.navigate.git.prev,          opts('Prev Git'))
        vim.keymap.set('n', ']c',      api.node.navigate.git.next,          opts('Next Git'))
        vim.keymap.set('n', 'd',       api.fs.remove,                       opts('Delete'))
        vim.keymap.set('n', 'D',       api.fs.trash,                        opts('Trash'))
        vim.keymap.set('n', 'E',       api.tree.expand_all,                 opts('Expand All'))
        vim.keymap.set('n', 'e',       api.fs.rename_basename,              opts('Rename: Basename'))
        vim.keymap.set('n', ']e',      api.node.navigate.diagnostics.next,  opts('Next Diagnostic'))
        vim.keymap.set('n', '[e',      api.node.navigate.diagnostics.prev,  opts('Prev Diagnostic'))
        vim.keymap.set('n', 'F',       api.live_filter.clear,               opts('Live Filter: Clear'))
        vim.keymap.set('n', 'f',       api.live_filter.start,               opts('Live Filter: Start'))
        vim.keymap.set('n', 'gy',      api.fs.copy.absolute_path,           opts('Copy Absolute Path'))
        vim.keymap.set('n', 'ge',      api.fs.copy.basename,                opts('Copy Basename'))
        vim.keymap.set('n', 'I',       api.tree.toggle_gitignore_filter,    opts('Toggle Filter: Git Ignore'))
        vim.keymap.set('n', 'J',       api.node.navigate.sibling.last,      opts('Last Sibling'))
        vim.keymap.set('n', 'K',       api.node.navigate.sibling.first,     opts('First Sibling'))
        vim.keymap.set('n', 'L',       api.node.open.toggle_group_empty,    opts('Toggle Group Empty'))
        vim.keymap.set('n', 'M',       api.tree.toggle_no_bookmark_filter,  opts('Toggle Filter: No Bookmark'))
        vim.keymap.set('n', 'm',       api.marks.toggle,                    opts('Toggle Bookmark'))
        vim.keymap.set('n', 'o',       api.node.open.edit,                  opts('Open'))
        vim.keymap.set('n', 'O',       api.node.open.no_window_picker,      opts('Open: No Window Picker'))
        vim.keymap.set('n', 'p',       api.fs.paste,                        opts('Paste'))
        vim.keymap.set('n', 'P',       api.node.navigate.parent,            opts('Parent Directory'))
        vim.keymap.set('n', 'q',       api.tree.close,                      opts('Close'))
        vim.keymap.set('n', 'r',       api.fs.rename,                       opts('Rename'))
        vim.keymap.set('n', 'R',       api.tree.reload,                     opts('Refresh'))
        vim.keymap.set('n', 's',       api.node.run.system,                 opts('Run System'))
        vim.keymap.set('n', 'S',       api.tree.search_node,                opts('Search'))
        vim.keymap.set('n', 'u',       api.fs.rename_full,                  opts('Rename: Full Path'))
        vim.keymap.set('n', 'U',       api.tree.toggle_custom_filter,       opts('Toggle Filter: Hidden'))
        vim.keymap.set('n', 'W',       api.tree.collapse_all,               opts('Collapse'))
        vim.keymap.set('n', 'x',       api.fs.cut,                          opts('Cut'))
        vim.keymap.set('n', 'y',       api.fs.copy.filename,                opts('Copy Name'))
        vim.keymap.set('n', 'Y',       api.fs.copy.relative_path,           opts('Copy Relative Path'))
        vim.keymap.set('n', '<2-LeftMouse>',  api.node.open.edit,           opts('Open'))
        vim.keymap.set('n', '<2-RightMouse>', api.tree.change_root_to_node, opts('CD'))
        --}}}
        -- custom mappings
        vim.keymap.set("n","?",         api.tree.toggle_help,           opts('Help'))
        vim.keymap.set("n", "l",        edit_or_open,                   opts("Edit or Open"))
        vim.keymap.set("n", "L",        vsplit_preview,                 opts("Vsplit Preview"))
        vim.keymap.set("n", "h",        api.node.navigate.parent_close, opts("Close"))
        vim.keymap.set("n", "H",        api.tree.collapse_all,          opts("Collapse All"))
        vim.keymap.set('n', "<C-h>",       api.tree.toggle_hidden_filter,       opts('Toggle Filter: Hidden'))
    end

    require("nvim-tree").setup({
        filters = {
            dotfiles = false,
            git_clean = false,
            no_buffer = false,
            custom = {
                "node_modules", -- filter out node_modules directory
                ".git", -- filter out .git directory
            },
            exclude = {},
        },
        disable_netrw = true,
        hijack_netrw = true,
        --open_on_setup = false,
        open_on_tab = false,
        hijack_cursor = false,
        update_cwd = true,
        hijack_directories = {
            enable = true,
            auto_open = true,
        },
        diagnostics = {
            enable = true,
            icons = {
                hint = "",
                info = "",
                warning = "",
                error = "",
            },
        },
        update_focused_file = {
            enable = true,
            update_cwd = true,
            ignore_list = {},
        },
        git = {
            enable = true,
            ignore = true,
            timeout = 500,
        },
        view = {
            width = 30,
            --height = 30,
            --hide_root_folder = false,
            side = "left",
            --auto_resize = true,
            --mappings = {
                --custom_only = false,
            --},
            number = false,
            relativenumber = false,
        },
        actions = {
            --quit_on_open = true,
            --window_picker = { enable = true },
        },
        renderer = {
            highlight_git = true,
            root_folder_modifier = ":t",
            icons = {
                show = {
                    file = true,
                    folder = true,
                    folder_arrow = true,
                    git = true,
                },
                glyphs = {
                    default = "",
                    symlink = "",
                    git = {
                        unstaged = "●",
                        staged = "+",
                        unmerged = "═",
                        renamed = "R",
                        deleted = "D",
                        untracked = "U",
                        ignored = "I",
                    },
                    folder = {
                        default = "",
                        open = "",
                        empty = "",
                        empty_open = "",
                        symlink = "",
                    },
                },
                
            },
        },

        on_attach = my_on_attach,
    })

    local Path = require('plenary.path')
    local config = require('session_manager.config')
    require('session_manager').setup({
      sessions_dir = Path:new(vim.fn.stdpath('data'), 'sessions'), -- The directory where the session files will be saved.
      session_filename_to_dir = session_filename_to_dir, -- Function that replaces symbols into separators and colons to transform filename into a session directory.
      dir_to_session_filename = dir_to_session_filename, -- Function that replaces separators and colons into special symbols to transform session directory into a filename. Should use `vim.loop.cwd()` if the passed `dir` is `nil`.
      autoload_mode = config.AutoloadMode.Disabled, -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
      autosave_last_session = true, -- Automatically save last session on exit and on session switch.
      autosave_ignore_not_normal = true, -- Plugin will not save a session when no buffers are opened, or all of them aren't writable or listed.
      autosave_ignore_dirs = {}, -- A list of directories where the session will not be autosaved.
      autosave_ignore_filetypes = { -- All buffers of these file types will be closed before the session is saved.
        'gitcommit',
        'gitrebase',
      },
      autosave_ignore_buftypes = {}, -- All buffers of these bufer types will be closed before the session is saved.
      autosave_only_in_session = false, -- Always autosaves session. If true, only autosaves after a session is active.
      max_path_length = 80,  -- Shorten the display path if length exceeds this threshold. Use 0 if don't want to shorten the path at all.
    })

    local alpha = require('alpha')
    require('alpha.term')

    local header = {
       "                                                     ",
       "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
       "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
       "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
       "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
       "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
       "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
       "                                                     ",
    }
    local make_header = function()
        local lines = {}
        for i, line_chars in pairs(header) do
          local hi = i > 10 and "Bulbasaur" .. (i - 10) or "PokemonLogo" .. i
          local line = {
            type = "text",
            val = line_chars,
            opts = {
              hl = "AlphaSpecialKey" .. i,
              shrink_margin = false,
              position = "center",
            },
          }
          table.insert(lines, line)
        end

        local output = {
          type = "group",
          val = lines,
          opts = { position = "center" },
        }

        return output
    end

    local margin_fix = vim.fn.floor(vim.fn.winwidth(0) / 2 - 46 / 2)

    local marginTopPercent = 0.05
    local headerPadding = vim.fn.max({ 4, vim.fn.floor(vim.fn.winheight(0) * marginTopPercent) })

    local padding = function(value)
        return { type = "padding", val = value }
    end

    local button = function(sc, txt, keybind, padding)
        local sc_ = sc:gsub("%s", ""):gsub("SPC", "<leader>")
        local text = padding and (" "):rep(padding) .. txt or txt

        local offset = padding and padding + 3 or 3

        local opts = {
          width = 46,
          shortcut = sc,
          cursor = -1,
          align_shortcut = "right",
          hl_shortcut = "AlphaButtonShortcut",
          hl = {
            { "AlphaButtonIcon", 0, margin_fix + offset },
            {
              "AlphaButton",
              offset,
              #text,
            },
          },
        }

        if keybind then
          opts.keymap = { "n", sc_, keybind, { noremap = true, silent = true } }
        end

        return {
          type = "button",
          val = text,
          on_press = function()
            local key = vim.api.nvim_replace_termcodes(sc_, true, false, true)
            vim.api.nvim_feedkeys(key, "normal", false)
          end,
          opts = opts,
        }
    end

    local thingy = io.popen('echo "$(date +%a) $(date +%d) $(date +%b)" | tr -d "\n"')
    local date = thingy:read("*a")
    thingy:close()


    local heading = {
        type = "text",
        val = "· Today is " .. date .. " ·",
        opts = {
            position = "center",
            hl = "Date",
        },
    }

    local terminal = {
        type = "terminal",
        command = vim.fn.expand("$HOME") .. "/.config/nvim/thisisfine.sh",
        width = 46,
        height = 25,
        opts = {
            redraw = true,
            window_config = {},
        },
    }

    local section = {
        heading = heading,
        terminal = make_header(),
        buttons = {
          type = "group",
          val = {
            button( "o", "  Open file", ":RnvimrToggle<CR>"),
            button( "l", "  Restore Session"  , ":SessionManager load_last_session<CR>"),
            button( "u", "  Update Plugins"  , ":PlugUpdate<CR>"),
            button( "r", "  Recent files"   , ":Telescope oldfiles<CR>"),
            button( "s", "  Settings" , ":e $MYVIMRC<CR>"),
            button( "q", "  Quit NVIM", ":qa<CR>"),
          },
          opts = {
            spacing = 1,
          },
        },
    }

    local config = {
        layout = {
          padding(headerPadding),
          section.terminal,
          padding(4),
          section.heading,
          padding(2),
          section.buttons,
        },
        opts = {
          margin = margin_fix,
        },
    }

    alpha.setup(config)

    -- Send config to alpha
    alpha.setup(config)

    -- Disable folding on alpha buffer
    vim.cmd([[
        autocmd FileType alpha IndentLinesDisable
        autocmd FileType alpha setlocal nofoldenable
    ]])
EOF
"  }}}

" ---NVIMTREE--- {{{
nnoremap <leader>n :NvimTreeFocus<CR>
nnoremap <C-e> :NvimTreeToggle<CR>
" Start nvimtree when Vim is started without file arguments.
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NvimTreeOpen | endif
"  }}}

" ---RNVIMR (explorer)--- {{{
" Make Ranger replace Netrw and be the file explorer
let g:rnvimr_enable_ex = 1

" Make Ranger to be hidden after picking a file
let g:rnvimr_enable_picker = 1

" Replace `$EDITOR` candidate with this command to open the selected file
let g:rnvimr_edit_cmd = 'drop'

" Disable a border for floating window
let g:rnvimr_draw_border = 0

" Hide the files included in gitignore
let g:rnvimr_hide_gitignore = 1

" Change the border's color
let g:rnvimr_border_attr = {'fg': 14, 'bg': -1}

" Make Neovim wipe the buffers corresponding to the files deleted by Ranger
let g:rnvimr_enable_bw = 1

" Add a shadow window, value is equal to 100 will disable shadow
let g:rnvimr_shadow_winblend = 70

" Draw border with both
let g:rnvimr_ranger_cmd = ['ranger', '--cmd=set draw_borders both']

" Link CursorLine into RnvimrNormal highlight in the Floating window
highlight link RnvimrNormal CursorLine

nnoremap <silent> <M-o> :RnvimrToggle<CR>
tnoremap <silent> <M-o> <C-\><C-n>:RnvimrToggle<CR>

" Resize floating window by all preset layouts
tnoremap <silent> <M-i> <C-\><C-n>:RnvimrResize<CR>

" Resize floating window by special preset layouts
tnoremap <silent> <M-l> <C-\><C-n>:RnvimrResize 1,8,9,11,5<CR>

" Resize floating window by single preset layout
tnoremap <silent> <M-y> <C-\><C-n>:RnvimrResize 6<CR>

" Map Rnvimr action
let g:rnvimr_action = {
            \ '<C-t>': 'NvimEdit tabedit',
            \ '<C-x>': 'NvimEdit split',
            \ '<C-v>': 'NvimEdit vsplit',
            \ 'gw': 'JumpNvimCwd',
            \ 'yw': 'EmitRangerCwd'
            \ }

" Add views for Ranger to adapt the size of floating window
let g:rnvimr_ranger_views = [
            \ {'minwidth': 90, 'ratio': []},
            \ {'minwidth': 50, 'maxwidth': 89, 'ratio': [1,1]},
            \ {'maxwidth': 49, 'ratio': [1]}
            \ ]

" Customize the initial layout
let g:rnvimr_layout = {
            \ 'relative': 'editor',
            \ 'width': float2nr(round(0.7 * &columns)),
            \ 'height': float2nr(round(0.7 * &lines)),
            \ 'col': float2nr(round(0.15 * &columns)),
            \ 'row': float2nr(round(0.15 * &lines)),
            \ 'style': 'minimal'
            \ }

" Customize multiple preset layouts
" '{}' represents the initial layout
let g:rnvimr_presets = [
            \ {'width': 0.600, 'height': 0.600},
            \ {},
            \ {'width': 0.800, 'height': 0.800},
            \ {'width': 0.950, 'height': 0.950},
            \ {'width': 0.500, 'height': 0.500, 'col': 0, 'row': 0},
            \ {'width': 0.500, 'height': 0.500, 'col': 0, 'row': 0.5},
            \ {'width': 0.500, 'height': 0.500, 'col': 0.5, 'row': 0},
            \ {'width': 0.500, 'height': 0.500, 'col': 0.5, 'row': 0.5},
            \ {'width': 0.500, 'height': 1.000, 'col': 0, 'row': 0},
            \ {'width': 0.500, 'height': 1.000, 'col': 0.5, 'row': 0},
            \ {'width': 1.000, 'height': 0.500, 'col': 0, 'row': 0},
            \ {'width': 1.000, 'height': 0.500, 'col': 0, 'row': 0.5}
            \ ]
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

"---CATPPUCCIN {{{
colorscheme catppuccin-mocha
let g:rehash256 = 1
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
let g:gitgutter_sign_modified = '▐'
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
" let $FZF_DEFAULT_COMMAND = 'find . ! -readable -prune -o -not -path "*/\.git/*" -printf "%P\\n"'
" nmap <silent> <leader>f :FZF ~<cr>
" nmap <silent> <leader>F :FZF<cr>
"}}}

"---TELESCOPE---{{{
" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
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
autocmd FileType TelescopePrompt call deoplete#custom#buffer_option('auto_complete', v:false) "disable on custom buffers
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

"---INDENT-GUIDE--- {{{
" let g:indentLine_color_term = 5		" Makes indent guide use colorscheme colors
let g:indentLine_char = '¦'			" Change indent char
let g:indentLine_enabled = 1			" Enable indent highlight
let g:indentLine_showFirstIndentLevel = 1
autocmd BufRead,BufNewFile *.tex IndentLinesDisable
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
        " autocmd BufWritePost ~/.config/nvim/init.vim source ~/.config/nvim/init.vim
        augroup END
    " }}}

    "{{{ ---FUNCTIONS
    "Search current working directory for word under cursor (used for xhci
    "searching mostly, might remove later)
    nnoremap <C-S> *N:exe ":!grep -rnw . -e ".strpart(getreg('/'), 2, (strlen(getreg('/'))-4))<CR>

    "}}}
    finish
" vim:foldmethod=marker:foldlevel=0
