local utils = require('utils')

local previewers = require("telescope.previewers")
local sorters = require("telescope.sorters")
local actions = require("telescope.actions")

local function config(_, opts)
  -- telescope
  --
  -- ctrl shift p requires emulator passthrough.
  local telescope = require('telescope')

  telescope.setup(opts)
  telescope.load_extension('cmdline')
  telescope.load_extension('undo')
  telescope.load_extension('luasnip')
  telescope.load_extension('nerdy')

  local recent_files = function()
    telescope.extensions.pretty_pickers.files({
      picker = 'oldfiles',
      options = {
        prompt_title = 'Recent Files',
        cwd = utils.get_root(),
        cwd_only = true,
      }
    })
  end

  local project_files = function()
    local opts = {}

    if vim.uv.fs_stat('.git') then
      opts.show_untracked = true
      opts.prompt_title = 'Git Files'

      telescope.extensions.pretty_pickers.files({
        picker = 'git_files',
        options = opts,
      })
    else
      local client = vim.lsp.get_clients()[1]

      if client then opts.cwd = client.config.root_dir end

      telescope.extensions.pretty_pickers.files({
        prompt_title = 'Project Files',
        picker = 'find_files',
        options = opts,
      })
    end
  end

  local config_files = function()
    telescope.extensions.pretty_pickers.files({
      picker = 'find_files',
      options = { prompt_title = 'Config Files', cwd = vim.fn.stdpath('config'), cwd_only = true },
    })
  end

  local find_text = function()
    telescope.extensions.pretty_pickers.grep({
      picker = 'live_grep',
    })
  end

  -- LSP related pickers
  local workspace_symbols = function()
    telescope.extensions.pretty_pickers.workspace_symbols({
      prompt_title = 'Workspace Goodies',
    })
  end

  local document_symbols = function()
    telescope.extensions.pretty_pickers.document_symbols({
      prompt_title = 'Document Goodies',
    })
  end

  local lsp_references = function()
    telescope.extensions.pretty_pickers.lsp_references({
      prompt_title = 'Language Server References',
    })
  end

  local tb = require('telescope.builtin')
  vim.keymap.set('v', '<leader>fw', function()
    local text = vim.getVisualSelection()
    tb.grep_string({ search = text })
  end, { silent = true, noremap = true })

  -- custom commands
  vim.api.nvim_create_user_command('FindFiles', project_files, {})
  vim.api.nvim_create_user_command('RecentFiles', recent_files, {})
  vim.api.nvim_create_user_command('FindText', find_text, {})
  vim.api.nvim_create_user_command('ConfigFiles', config_files, {})

  vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function()
      utils.Bufmap("n", "gd", "<cmd>Telescope lsp_definitions<CR>")
      utils.Bufmap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
      utils.Bufmap("n", "gr", "<cmd>Telescope lsp_references<CR>")
      utils.Bufmap("n", "gh",
        function()
          vim.lsp.buf.hover({border = "rounded", title = " info "})
        end
      )
    end
  })

  utils.Bufmap('n', '<leader>tr', recent_files, {desc = 'Recent files', silent = true, noremap = true})
  utils.Bufmap('n', "<leader>ff", project_files, {desc = 'Telescope find files'} )
  utils.Bufmap('n', "<leader>fg", find_text, {desc = 'Telescope live grep'} )
  utils.Bufmap('n', "<leader>tc", config_files, {desc = 'Telescope live grep'} )
  utils.Bufmap("n", "gd", "<cmd>Telescope lsp_definitions<CR>", {desc = 'LSP go to definition', silent = true, noremap = true})
  utils.Bufmap("n", "gr", lsp_references, {desc = 'LSP open references', silent = true, noremap = true})
  utils.Bufmap('n', '<leader>ws', workspace_symbols, { desc = 'Workspace symbols' })
  utils.Bufmap('n', '<leader>ds', document_symbols, { desc = 'Document symbols' })
  vim.keymap.set('n', "<leader><space>", tb.resume, {
      desc = 'Resume the last opened telescope prompt',
  })
end


return {
  {
    'nvim-telescope/telescope.nvim',
    config=config,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'jonarrien/telescope-cmdline.nvim',
      {
        'simeonoff/telescope-pretty-pickers.nvim',
        dependencies = {
          'nvim-tree/nvim-web-devicons',
        },
      },
      "debugloop/telescope-undo.nvim",
    },
    keys = {
      { "<C-S-P>", "<cmd>Telescope<cr>", desc = 'Telscope'},
      { "<leader>tt", "<cmd>Telescope<cr>" , desc = 'Telescope'},
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = 'Telescope buffers'},
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = 'Telescope help tags'},
      { '<leader>fw', "<cmd>lua require('telescope.builtin').grep_string()<cr>", desc = 'Telescope grep current word'}
    },
    opts = {
      defaults = {
        vimgrep_arguments = {
          "rg",
          "-L",
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
        layout_strategy = "flex",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
            preview_cutoff = 120,
          },
          vertical = {
            prompt_position = "top",
            mirror = true,
          },
          width = 0.8,
          height = 0.65,
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
            ['<C-j>'] = actions.move_selection_next,
            ['<C-k>'] = actions.move_selection_previous,
          },
        },
        cache_picker = {
          num_pickers = 50,
        },
        pickers = {
          live_grep = {
            initial_mode = "insert",
          },
          find_files = {
            theme = "dropdown",
          },
          nerdy = {},
          undo = {},
          luasnip = {},
        },
        extensions = {
          undo = {
            side_by_side = true,
            use_delta = false,
          },
          cmdline = {
            picker = {
              layout_config = {
                width = 120,
                height = 25,
              }
            },
            mappings = {
              complete = '<Tab>',
              run_selection = '<C-CR>',
              run_input = '<CR>'
            },
            -- triggers any shell command using overseer.nvim
            overseer = {
              enabled = true,
            }
          }
        },
      },
    }
  },
  {
    '2kabhishek/nerdy.nvim',
    dependencies = {
        'stevearc/dressing.nvim',
        'nvim-telescope/telescope.nvim',
    },
    cmd = 'Nerdy',
  },
  {
    'stevearc/overseer.nvim',
    lazy = true,
    opts = {},
  },
  {
    'benfowler/telescope-luasnip.nvim',
    dependencies = {
      'nvim-telescope/telescope.nvim'
    }
  }
}
