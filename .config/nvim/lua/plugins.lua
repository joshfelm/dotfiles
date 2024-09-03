return {
  { "ellisonleao/gruvbox.nvim", priority = 1000 , lazy = false,
    -- colorscheme
    opts = {
      terminal_colors = true, -- add neovim terminal colors
      undercurl = true,
      underline = true,
      bold = true,
      italic = {
        strings = true,
        emphasis = true,
        comments = true,
        operators = false,
        folds = true,
      },
      strikethrough = true,
      invert_selection = false,
      invert_signs = false,
      invert_tabline = false,
      invert_intend_guides = false,
      inverse = true, -- invert background for search, diffs, statuslines and errors
      contrast = "", -- can be "hard", "soft" or empty string
      palette_overrides = {},
      overrides = {},
      dim_inactive = false,
      transparent_mode = false,
    },
    config = function()
      vim.cmd([[colorscheme gruvbox]])
    end
  },
  {'nvim-lua/plenary.nvim'},
  {'norcalli/nvim-colorizer.lua', config=true}, -- show colours in place
  {
    "neovim/nvim-lspconfig",
    -- cmd = "Mason",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "hrsh7th/nvim-cmp",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    }
	},
  -- cmp: autocompletion
  {'hrsh7th/cmp-nvim-lsp'},
  {'hrsh7th/cmp-buffer'},
  {'hrsh7th/cmp-path'},
  {'hrsh7th/cmp-cmdline'},
  {'hrsh7th/nvim-cmp', lazy = true},
  {'onsails/lspkind.nvim'}, -- lsp icons
  {
    -- markdown preview
    "toppair/peek.nvim",
    event = { "VeryLazy" },
    build = "deno task --quiet build:fast",
    config = function()
        vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
        vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
        require("peek").setup({
          app = 'browser',
        })
    end,
  },
  {'romgrk/barbar.nvim'}, -- tab handler
  {'nvim-tree/nvim-tree.lua', lazy = true}, -- explorer
  {'nvim-tree/nvim-web-devicons', lazy = true},
  {'kevinhwang91/rnvimr'}, --ranger
  {'nvim-telescope/telescope.nvim'},
  {
    'yamatsum/nvim-cursorline',
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      vim.api.nvim_set_hl(0, "FlashLabel", { bg = '#cc241d', fg = '#ebdbb2' }),
      vim.api.nvim_set_hl(0, "FlashMatch", { bg = '#458588', fg = '#fabd2f' })
    },
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "<leader>S", mode = { "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" }, --dont trample on vim-surround
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      keywords = {
        FIX = {
          icon = " ", -- icon used for the sign, and in search results
          color = "error", -- can be a hex color, or a named color (see below)
          alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
          -- signs = false, -- configure signs for some keywords individually
        },
        TODO = { icon = " ", color = "info" },
        HACK = { icon = " ", color = "warning" },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
        PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
        TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
      },
      signs = false,
    }
  },
  {
    'nvim-lualine/lualine.nvim',
    requires = {'nvim-tree/nvim-web-devicons', opt = true }
  },
  -- invaluable vim plugins
  {'honza/vim-snippets'},
  {'tpope/vim-sensible'},
  {'tpope/vim-fugitive'},
  {'tpope/vim-surround'},
  {'tpope/vim-repeat'},
  -- indent guide
  {
    'lukas-reineke/indent-blankline.nvim',
    main = "ibl",
    opts={},
    config=true
  },
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true,
    -- use opts = {} for passing setup options
    -- this is equalent to setup({}) function
  },
  {'nvim-treesitter/nvim-treesitter', build = ":TSUpdate"},
  {'nvim-treesitter/nvim-treesitter-context'},
  {'lewis6991/gitsigns.nvim'},
  {'shatur/neovim-session-manager'},
  {'goolord/alpha-nvim'}, -- dashboard
  {'sindrets/diffview.nvim'},
  { 'echasnovski/mini.trailspace', version = false, config = true }, -- complain about whitespace
  -- {
  --   'ErichDonGubler/lsp_lines.nvim', version = false, config = true, -- lsp show errors under line
  -- },
  {
    'echasnovski/mini.ai', version = false, config = true,
  },
  -- tmux integration
  -- {
  --   'christoomey/vim-tmux-navigator',
  --   keys = {
  --     { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
  --     { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
  --     { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
  --     { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
  --     { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
  --   }
  -- },
  -- zellij integration
  {
    "https://git.sr.ht/~swaits/zellij-nav.nvim",
    lazy = true,
    event = "VeryLazy",
    keys = {
      { "<c-h>", "<cmd>ZellijNavigateLeft<cr>",  { silent = true, desc = "navigate left"  } },
      { "<c-j>", "<cmd>ZellijNavigateDown<cr>",  { silent = true, desc = "navigate down"  } },
      { "<c-k>", "<cmd>ZellijNavigateUp<cr>",    { silent = true, desc = "navigate up"    } },
      { "<c-l>", "<cmd>ZellijNavigateRight<cr>", { silent = true, desc = "navigate right" } },
    },
    opts = {},
  },
  -- auto-save
  {
    "Pocco81/auto-save.nvim",
    opts={},
    config = true,
  },
  -- obsidian integration
  {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = true,
    ft = "markdown",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  -- zen mode
  { "folke/twilight.nvim", },
  {
    "folke/zen-mode.nvim",
    opts = {
      window = {
        width = 0.85,
        options = {
          number = false,
        },
      },
      plugins = {
        tmux = { enabled = true },
        gitsigns = { enabled = true },
        kitty = {
          enabled = true,
          font = "+2",
        }
      }
    }
  },
  {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },
}
