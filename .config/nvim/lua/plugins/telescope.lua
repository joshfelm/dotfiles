require('utils')

local previewers = require("telescope.previewers")
local sorters = require("telescope.sorters")
local actions = require("telescope.actions")

local function config(_, opts)
  -- telescope
  --
  -- ctrl shift p requires emulator passthrough.
  Bufmap("n", "<C-S-P>", "<cmd>Telescope<cr>")

  require("telescope").setup(opts)
  require('telescope').load_extension('cmdline')
  require('telescope').load_extension('undo')
  require('telescope').load_extension('luasnip')
  require('telescope').load_extension('nerdy')

  local tb = require('telescope.builtin')
  vim.keymap.set('v', '<leader>fw', function()
    local text = vim.getVisualSelection()
    tb.grep_string({ search = text })
  end, { silent = true, noremap = true })
end


return {
  {
    'nvim-telescope/telescope.nvim',
    config=config,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'jonarrien/telescope-cmdline.nvim',
      "debugloop/telescope-undo.nvim",
    },
    keys = {
      { "<C-S-P>", "<cmd>Telescope<cr>", desc = 'Telscope'},
      { "<leader>tt", "<cmd>Telescope<cr>" , desc = 'Telescope'},
      { "<leader>ff", '<cmd>Telescope find_files<cr>', desc = 'Telescope find files'},
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = 'Telescope live grep'},
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
