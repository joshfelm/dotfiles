"---Plugins--- {{{
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call plug#begin('~/.config/plugged')

Plug 'rhysd/vim-grammarous'
Plug 'tpope/vim-repeat'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'onsails/lspkind.nvim'
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
Plug 'tomtom/tcomment_vim'
Plug 'lervag/vimtex'
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
    vim.g.mapleader = ","
    vim.g["pumheight"] = 12
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

        -- Set up nvim-cmp.
      local cmp = require'cmp'
      local lspkind = require('lspkind')

      local kind_icons = {
          Text = "",
          Method = "󰆧",
          Function = "󰊕",
          Constructor = "",
          Field = "󰇽",
          Variable = "󰂡",
          Class = "󰠱",
          Interface = "",
          Module = "",
          Property = "󰜢",
          Unit = "",
          Value = "󰎠",
          Enum = "",
          Keyword = "󰌋",
          Snippet = "",
          Color = "󰏘",
          File = "󰈙",
          Reference = "",
          Folder = "󰉋",
          EnumMember = "",
          Constant = "󰏿",
          Struct = "",
          Event = "",
          Operator = "󰆕",
          TypeParameter = "󰅲",
    }

      cmp.setup({
        snippet = {
          -- REQUIRED - you must specify a snippet engine
          expand = function(args)
            --vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
            vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
            -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
          end,
        },
        window = {
          -- completion = cmp.config.window.bordered(),
          -- documentation = cmp.config.window.bordered(),
        },
        formatting = {
          --format = function(entry, vim_item)
          --  vim_item.abbr = string.sub(vim_item.abbr, 1, 45)
          --  return vim_item
          --end
          fields = {"abbr", "kind", "menu"},
          format = lspkind.cmp_format({
            mode = 'symbol',
            maxwidth = 50,
            ellipsis_char = '...',
            show_labelDetails=true,
            before = function (entry, vim_item)
                return vim_item
            end
          })
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-a>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<TAB>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources({
        { 
            name = "nvim_lsp",
            max_item_count = 200,
        },
          -- { name = 'vsnip' }, -- For vsnip users.
          -- { name = 'luasnip' }, -- For luasnip users.
          { name = 'ultisnips' }, -- For ultisnips users.
        }, {
          -- { name = 'snippy' }, -- For snippy users.
          { name = 'buffer', max_item_count = 5},
        }),
      })
      -- Set configuration for specific filetype.
      cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
          { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
        }, {
          { name = 'buffer' },
        })
      })

      -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer', max_item_count = 0 }
        }
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path', }
        }, {
          { name = 'cmdline' }
        }),
        matching = { disallow_symbol_nonprefix_matching = false }
      })

      -- Set up lspconfig.
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
      require('lspconfig')['clangd'].setup {
        capabilities = capabilities
      }
    local nvim_lsp = require('lspconfig')

    nvim_lsp.clangd.setup {
        cmd = {'clangd', '--background-index'},
        init_options = {
            clangdFileStatus = true,
            clangdSemanticHighlighting = true
        },
        filetypes = {'c', 'cpp', 'cxx', 'cc'},
        settings = {
            root_dir = vim.loop.cwd(),
            ['clangd'] = {
                ['compilationDatabasePath'] = 'build/',
                ['fallbackFlags'] = {'-std=c++17'}
            }
        }
    }

    function vim.getVisualSelection()
        vim.cmd('noau normal! "vy"')
        local text = vim.fn.getreg('v')
        vim.fn.setreg('v', {})

        text = string.gsub(text, "\n", "")
        if #text > 0 then
            return text
        else
            return ''
        end
    end

    --vim.keymap.set("n", "<leader>fa", "<CMD>Telescope live_grep default_text="..vim.fn.expand('<cword>').."<CR>", {noremap = true, silent=false, expr = true})
    local tb = require('telescope.builtin')
    vim.api.nvim_set_keymap('n', '<leader>fw', [[<cmd>lua require('telescope.builtin').grep_string()<cr>]], { silent = true, noremap = true })
    vim.keymap.set('v', '<leader>fw', function()
        local text = vim.getVisualSelection()
        tb.grep_string({ search = text })
    end, { silent = true, noremap = true })

    vim.api.nvim_create_autocmd('LspAttach', {
        desc = 'LSP actions',
        callback = function()
            local bufmap = function(mode, lhs, rhs)
                local opts = {buffer = true, silent = true, noremap = false}
                vim.keymap.set(mode, lhs, rhs, opts)
            end

            bufmap("n", "gd", "<cmd>Telescope lsp_definitions<CR>")
            bufmap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
            bufmap("n", "gr", "<cmd>Telescope lsp_references<CR>")
            bufmap("n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>" )
        end

    })

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

        api.events.subscribe(api.events.Event.TreeOpen, function ()
            vim.wo.statusline = ' '
        end)

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

    vim.api.nvim_set_keymap("n", "<C-E>", ":NvimTreeToggle<cr>", {silent = true, noremap = false})
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

    local previewers = require("telescope.previewers")
    local sorters = require("telescope.sorters")
    local actions = require("telescope.actions")
    require("telescope").setup({
        defaults = {
          vimgrep_arguments = {
            "rg",
            "-L",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
          },
          prompt_prefix = "   ",
          selection_caret = "> ",
          entry_prefix = "  ",
          initial_mode = "insert",
          selection_strategy = "reset",
          sorting_strategy = "ascending",
          layout_strategy = "horizontal",
          layout_config = {
            horizontal = {
              prompt_position = "top",
              preview_width = 0.55,
              results_width = 0.8,
            },
            vertical = {
              mirror = false,
            },
            width = 0.8,
            height = 0.65,
            preview_cutoff = 120,
          },
          file_sorter = sorters.get_fuzzy_file,
          file_ignore_patterns = {
            "node_modules",
            ".git",
          },
          generic_sorter = sorters.get_generic_fuzzy_sorter,
          path_display = { "truncate" },
          winblend = 0,
          border = {},
          borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
          color_devicons = true,
          set_env = {
            ["COLORTERM"] = "truecolor",
          },
          file_previewer = previewers.vim_buffer_cat.new,
          grep_previewer = previewers.vim_buffer_vimgrep.new,
          qflist_previewer = previewers.vim_buffer_qflist.new,
          buffer_previewer_maker = previewers.buffer_previewer_maker,
          mappings = {
            n = {
              ["q"] = actions.close,
            },
          },
          cache_picker = {
            num_pickers = 50,
          },
          extensions = {
            undo = {
              side_by_side = true,
              use_delta = false,
            },
          },
        },
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

        config = function()
        local path_ok, plenary_path = pcall(require, "plenary.path")
        if not path_ok then
            return
        end

        local dashboard = require("alpha.themes.dashboard")
        local cdir = vim.fn.getcwd()
        local if_nil = vim.F.if_nil

        local nvim_web_devicons = {
            enabled = true,
            highlight = true,
        }

        local function get_extension(fn)
            local match = fn:match("^.+(%..+)$")
            local ext = ""
            if match ~= nil then
                ext = match:sub(2)
            end
            return ext
        end

        local function icon(fn)
            local nwd = require("nvim-web-devicons")
            local ext = get_extension(fn)
            return nwd.get_icon(fn, ext, { default = true })
        end

        local function file_button(fn, sc, short_fn, autocd)
            short_fn = short_fn or fn
            local ico_txt
            local fb_hl = {}

            if nvim_web_devicons.enabled then
                local ico, hl = icon(fn)
                local hl_option_type = type(nvim_web_devicons.highlight)
                if hl_option_type == "boolean" then
                    if hl and nvim_web_devicons.highlight then
                        table.insert(fb_hl, { hl, 0, #ico })
                    end
                end
                if hl_option_type == "string" then
                    table.insert(fb_hl, { nvim_web_devicons.highlight, 0, #ico })
                end
                ico_txt = ico .. "  "
            else
                ico_txt = ""
            end
            local cd_cmd = (autocd and " | cd %:p:h" or "")
            local file_button_el = dashboard.button(sc, ico_txt .. short_fn,
                "<cmd>e " .. vim.fn.fnameescape(fn) .. cd_cmd .. " <CR>")
            local fn_start = short_fn:match(".*[/\\]")
            if fn_start ~= nil then
                table.insert(fb_hl, { "Comment", #ico_txt - 2, #fn_start + #ico_txt })
            end
            file_button_el.opts.hl = fb_hl
            return file_button_el
        end

        local default_mru_ignore = { "gitcommit" }

        local mru_opts = {
            ignore = function(path, ext)
                return (string.find(path, "COMMIT_EDITMSG")) or (vim.tbl_contains(default_mru_ignore, ext))
            end,
            autocd = false
        }

        --- @param start number
        --- @param cwd string? optional
        --- @param items_number number? optional number of items to generate, default = 10
        local function mru(start, cwd, items_number, opts)
            opts = opts or mru_opts
            items_number = if_nil(items_number, 10)

            local oldfiles = {}
            for _, v in pairs(vim.v.oldfiles) do
                if #oldfiles == items_number then
                    break
                end
                local cwd_cond
                if not cwd then
                    cwd_cond = true
                else
                    cwd_cond = vim.startswith(v, cwd)
                end
                local ignore = (opts.ignore and opts.ignore(v, get_extension(v))) or false
                if (vim.fn.filereadable(v) == 1) and cwd_cond and not ignore then
                    oldfiles[#oldfiles + 1] = v
                end
            end
            local target_width = 35

            local tbl = {}
            for i, fn in ipairs(oldfiles) do
                local short_fn
                if cwd then
                    short_fn = vim.fn.fnamemodify(fn, ":.")
                else
                    short_fn = vim.fn.fnamemodify(fn, ":~")
                end

                if #short_fn > target_width then
                    short_fn = plenary_path.new(short_fn):shorten(1, { -2, -1 })
                    if #short_fn > target_width then
                        short_fn = plenary_path.new(short_fn):shorten(1, { -1 })
                    end
                end

                local shortcut = tostring(i + start - 1)

                local file_button_el = file_button(fn, shortcut, short_fn, opts.autocd)
                tbl[i] = file_button_el
            end
            return {
                type = "group",
                val = tbl,
                opts = {},
            }
        end

        local header = {
            type = "text",
            --val = {
            --    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡠⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
            --    "⠀⠀⠀⠀⠀⠀⠀⠀⠐⠒⠒⠒⠂⠀⠤⠤⠤⣄⣀⡀⠘⢆⠀⠀⠀⠀⠀⠀⠀⣀⣤⣶⡿⠋⣀⣔⣒⣉⣀⠤⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠎⠀⣀⣀⡤⠤⠤⠄⠀⠒⠒⠒⠒⠀⠀⠀⠀⠀⠀⠀⠀",
            --    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⣉⣽⢾⡇⠀⠀⠀⠀⠀⢰⣿⣟⣵⣿⢿⣿⣛⣿⣿⣻⢿⣦⠤⠀⠀⠀⠀⠀⠀⠀⠠⣾⢾⣍⣁⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
            --    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣤⡴⠶⠛⠋⠉⠁⠀⢠⡏⠀⠀⠀⠀⠰⣲⡿⡟⠋⢹⣿⠟⠛⠉⠉⠙⢻⣗⢻⣇⠀⠀⠀⠀⠀⠀⠀⠀⠈⣧⠀⠀⠉⠉⠛⠳⠶⣤⣄⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
            --    "⠀⠀⠀⠀⠀⠀⢀⣤⠶⠟⠋⠉⠀⠀⠀⠀⠀⠀⠀⠀⡾⠀⠀⠀⠀⠀⠀⠀⠁⢀⡴⠋⠀⠀⠀⠀⠀⢀⠿⣿⣸⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⡆⠀⠀⠀⠀⠀⠀⠀⠈⠉⠛⠶⢦⣀⠀⠀⠀⠀⠀⠀",
            --    "⠀⠀⠀⢀⣠⠞⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣟⣿⡟⣿⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠛⢦⡀⠀⠀⠀",
            --    "⠀⠀⣴⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣾⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡠⣶⣿⣾⣾⣿⣇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣸⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⢷⡄⠀",
            --    "⠀⣼⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⠴⠖⠚⠛⣛⠻⢧⣤⣤⣄⣀⡠⣤⣤⣶⣶⣶⣾⣿⣿⣳⣝⣿⡿⣻⣽⢺⣿⣿⣿⣶⣶⣶⡤⣀⣤⣤⣤⠟⢛⡛⠛⠒⠶⢤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⡄",
            --    "⢰⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⡴⠋⠀⠀⠀⠀⡴⠁⠀⠀⠀⠉⠉⠛⠛⠾⠯⣟⣻⡿⠿⣟⣯⣿⣿⣷⣿⣿⡇⡏⣻⣿⣟⡿⠯⠗⠛⠋⠉⠁⠀⠀⠀⠱⡄⠀⠀⠀⠈⠳⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⢧",
            --    "⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀⡜⠀⠀⠀⠀⠀⢰⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣤⣾⣯⣹⣷⣝⢿⣿⣿⣻⣵⣏⣿⣧⣤⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⠀⠀⠀⠀⠀⠸⡀⠀⠀⠀⠀⠀⠀⠀⠀⢸",
            --    "⢸⠀⠀⠀⠀⠀⠀⠀⠀⢀⠁⠀⠀⠀⠀⠀⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠯⣷⣿⣿⣿⣷⣷⣿⣿⣽⣸⡯⠏⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠀⠀⠀⠀⠀⠀⢁⠀⠀⠀⠀⠀⠀⠀⠀⢸",
            --    "⢸⠀⠀⠀⠀⠀⠀⠀⠀⠘⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⡉⠩⡏⡏⣟⢿⡿⣿⣽⣇⡯⠉⡉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⠀⠀⠀⠀⠀⠀⠀⠀⢸",
            --    "⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠁⡇⣿⣷⣿⣿⢿⠏⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸",
            --    "⠀⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣶⢶⣶⢄⠀⠀⢠⣾⢻⣿⣽⣯⣿⣸⣸⣿⣆⠀⠀⣠⢴⣶⢶⣤⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡆",
            --    "⠀⢁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⡿⣾⣯⣿⢸⣷⣄⣴⣯⡺⣝⡿⡿⣿⣽⡿⣻⣶⢀⣾⣧⢿⡞⣿⣽⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠁",
            --    "⠀⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⠀⠟⠈⠇⠀⠙⢿⣯⠟⠀⢏⣿⣿⣿⡟⣇⠹⢿⣿⠟⠁⠸⠃⠸⠃⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠀",
            --    "⠀⠀⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠀⠀⠘⣼⣽⣿⣦⣿⠀⠈⠀⠀⠀⣀⣀⣀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⠀",
            --    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠨⣟⣿⣯⡼⡧⣴⣶⣿⠿⠿⠿⠿⣿⣿⣿⣷⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
            --    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⡜⡿⡿⣫⣻⡝⠒⠉⠉⠈⠈⠉⠉⠘⠙⢿⣿⣏⣦⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
            --    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣤⣶⣿⢿⠟⠘⣿⣿⣗⣻⣦⡀⠀⠀⠀⠀⠀⠀⠀⢸⣿⢧⣿⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
            --    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠲⣤⣀⣀⣀⣀⣀⣠⣤⣶⣾⡿⠿⠛⠉⠀⠀⠀⠀⠀⢺⣿⣷⣝⢿⣶⣄⣀⡀⠀⠠⢴⣿⣽⣿⡿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
            --    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠙⠛⠛⠋⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠺⢿⣶⣝⡿⣿⣿⣿⣿⣿⣿⡿⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
            --},
            val = {
                "",
                "",
                "",
                "███    ██ ███████  ██████  ██    ██ ██ ███    ███ ",
                "████   ██ ██      ██    ██ ██    ██ ██ ████  ████ ",
                "██ ██  ██ █████   ██    ██ ██    ██ ██ ██ ████ ██ ",
                "██  ██ ██ ██      ██    ██  ██  ██  ██ ██  ██  ██ ",
                "██   ████ ███████  ██████    ████   ██ ██      ██ ",
                "                                                  ",
                "",
            },
            opts = {
                position = "center",
                hl = "AlphaHeader",
                -- wrap = "overflow";
            },
        }

        local section_mru = {
            type = "group",
            val = {
                {
                    type = "text",
                    val = "Recent files",
                    opts = {
                        hl = "SpecialComment",
                        shrink_margin = false,
                        position = "center",
                    },
                },
                { type = "padding", val = 1 },
                {
                    type = "group",
                    val = function()
                        return { mru(0, cdir) }
                    end,
                    opts = { shrink_margin = false },
                },
            },
        }

        local buttons = {
            type = "group",
            val = {
                { type = "text",    val = "Quick links", opts = { hl = "SpecialComment", position = "center" } },
                { type = "padding", val = 1 },
                dashboard.button("e", "  New file", "<cmd>ene<CR>"),
                dashboard.button("o", "  Open file", ":RnvimrToggle<CR>"),
                dashboard.button("l", "  Restore Last Session"  , ":SessionManager load_last_session<CR>"),
                dashboard.button("c", "  Load CWD Session"  , ":SessionManager load_current_dir_session<CR>"),
                dashboard.button("u", "  Update Plugins"  , ":PlugUpdate<CR>"),
                dashboard.button("r", "  Recent files"   , ":Telescope oldfiles<CR>"),
                dashboard.button("s", "  Settings" , ":e $MYVIMRC<CR>"),
                dashboard.button("f f", "󰈞  Find file", "<cmd>Telescope find_files<CR>"),
                dashboard.button("f g", "󰊄  Live grep", "<cmd>Telescope live_grep<CR>"),
                dashboard.button("q", "  Quit NVIM", "<cmd>qa<CR>"),
            },
            position = "center",
        }
        local footer = {
            type = "text",
            val = function()
                return "[" .. cdir .. "]"
            end,
            opts = {
                position = "center",
                hl = "AlphaFooter"
            },
        }

        local config = {
            layout = {
                header,
                { type = "padding", val = 2 },
                section_mru,
                { type = "padding", val = 2 },
                buttons,
                { type = "padding", val = 2 },
                footer,
            },
            opts = {
                margin = 5,
                setup = function()
                    vim.api.nvim_create_autocmd('DirChanged', {
                        pattern = '*',
                        group = "alpha_temp",
                        callback = function()
                            cdir = vim.fn.getcwd()
                            require('alpha').redraw()
                            vim.cmd('AlphaRemap')
                        end,
                    })
                end,
            },
        }

        require 'alpha'.setup(config)
    end
    config()

    -- disable statusline in dashboard
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "alpha",
        callback = function()
          local old_laststatus = vim.opt.laststatus

          vim.api.nvim_create_autocmd("BufUnload", {
            buffer = 0,
            callback = function()
              vim.opt.laststatus = old_laststatus
            end,
          })

          vim.opt.laststatus = 0
        end,
      })

      vim.api.nvim_exec(
        [[
        au BufEnter,BufWinEnter,WinEnter,CmdwinEnter * if bufname('%') == "NvimTree" | set laststatus=0 | else | set laststatus=2 | endif
        ]],
        false
        )
    -- Disable folding on alpha buffer
    vim.cmd([[
        autocmd FileType alpha IndentLinesDisable
        autocmd FileType alpha setlocal nofoldenable
        autocmd FileType TelescopePrompt IndentLinesDisable
    ]])
EOF
"  }}}

" ---NVIMTREE--- {{{
nnoremap <leader>n :NvimTreeFocus<CR>
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
nnoremap <leader>tt <cmd>Telescope<cr>
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
"}}}

"---ALE--- {{{
" let g:ale_enabled = 0
" nmap <silent> <leader>aj :ALENext<cr>
" nmap <silent> <leader>ak :ALEPrevious<cr>
" nmap <F8> <Plug>(ale_fix)
" highlight clear ALEWarning
" highlight ALEWarningSign guibg=NONE guifg=Yellow
" highlight clear ALEError
" highlight ALEError guibg=DarkRed 
" highlight ALEErrorSign guibg=#b30404 guifg=#e8d94f
" let g:ale_fixers = {
"             \   '*': ['remove_trailing_lines', 'trim_whitespace'],
"             \   'c': ['clang-tidy'],
"             \}
" let g:ale_vim_vint_show_style_issues = 1
" let g:ale_echo_cursor = 1
" let g:ale_echo_msg_error_str = 'Error'
" let g:ale_echo_msg_format = '%code: %%s'
" let g:ale_echo_msg_warning_str = 'Warning'
" let g:ale_fix_on_save = 0
" let g:ale_keep_list_window_open = 0
" let g:ale_lint_delay = 200
" let g:ale_lint_on_enter = 1
" let g:ale_lint_on_save = 1
" let g:ale_lint_on_insert_leave = 1
" let g:ale_lint_on_text_changed = 1
" let g:ale_linter_aliases = {}
" let g:ale_linters = {
" \   'c': ['clangd'],
" \   'python': ['jedils', 'pylint'],
" \   'vim': ['vimls'],
" \}
" let g:ale_open_list = 0
" let g:ale_set_highlights = 1    "enable highlights"
" let g:ale_set_loclist = 1
" let g:ale_set_quickfix = 0
" let g:ale_set_signs = 1
" let g:ale_sign_column_always = 0
" let g:ale_sign_error = '✗'
" let g:ale_sign_offset = 10000
" let g:ale_sign_warning = '⚡︎'
" let g:ale_statusline_format = ['✗ %d', '⚡︎%d', '']
" let g:ale_warn_about_trailing_whitespace = 0
" let g:ale_completion_enabled = 0
"
" let g:ale_floating_preview= 1
" autocmd User ALELint highlight ALEErrorSign guifg=#fb4934 guibg=#3c3836 gui=bold
" " nnoremap <silent> gd :ALEGoToDefinition<CR>
" " nnoremap <silent> <leader>gd :tabnew %<CR><c-o>:ALEGoToDefinition<CR>gT
" " nnoremap <silent> gh :ALEHover<CR>
" let g:ale_floating_window_border = ['│', '─', '╭', '╮', '╯', '╰']
" nnoremap <silent> <F2> :ALERename<CR>
" }}}

" ---DEOPLETE--- {{{
" call deoplete#custom#source('_', 'matchers', ['matcher_full_fuzzy'])
" call deoplete#custom#source('ale', 'rank', 999)
" call deoplete#custom#source('ale', 'rank', 999)
" let g:deoplete#lsp#handler_enabled
" autocmd FileType TelescopePrompt call deoplete#custom#buffer_option('auto_complete', v:false) "disable on custom buffers
" autocmd FileType TelescopePrompt IndentLinesDisable
" autocmd CompleteDone * silent! pclose!
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
" let g:airline_exclude_filetypes = ["alpha", "vim"]

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
