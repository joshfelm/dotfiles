return {
  -- { "sainnhe/gruvbox-material", name = "gruvbox-material", priority = 1000,
  --   -- config = function()
  --   --   vim.cmd([[colorscheme gruvbox-material]])
  --   -- end
  -- },
  { "catppuccin/nvim", name = "catppuccin",
    -- config = function()
      -- vim.cmd([[colorscheme catppuccin-macchiato]])
    -- end
  },
  -- {
  --   "sindrets/oxocarbon-lua.nvim"
  -- },
  -- { "nyoom-engineering/oxocarbon.nvim" },
  { "ellisonleao/gruvbox.nvim", priority = 1000 , lazy = false,
    -- colorscheme
    config = function(_, opts)
      require('gruvbox').setup(opts)
      -- vim.cmd([[colorscheme gruvbox]])
    end,
    opts = {
      terminal_colors = true, -- add neovim terminal colors
      undercurl = true,
      underline = true,
      bold = true,
      italic = {
        strings = false,
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
      overrides = {
        TreesitterContext = {bg = "#504945"},

        -- barbar
        BufferCurrent = {bg = "#3c3836", fg = "#d3869b"},
        BufferCurrentSign = {bg = "#3c3836", fg = "#8ec07c"},
        BufferInactiveMod = {bg = "#1d2021", fg = "#fb4934"},
        BufferInactive = {bg = "#1d2021", fg = "#928374"},
        BufferTabpageFill = {bg = "#1d2021"},
        BufferInactiveSign = {bg = "#1d2021", fg = "#1d2021"},
        BufferInactiveERROR = {bg = "#1d2021", fg = "#fb4934"},
        BufferInactiveHINT = {bg = "#1d2021", fg = "#8ec07c"},
        BufferInactiveINFO = {bg = "#1d2021", fg = "#83a598"},
        BufferInactiveWARN = {bg = "#1d2021", fg = "#fabd2f"},

        NvimTreeIndentMarker = {fg="#665c54"},

        -- git stuff
        NonText = {fg = "#7c6f64"},

        GitStagedAdd = {fg="#474409"},
        GitStagedAddNr = {fg="#474409"},
        GitStagedAddCul = {fg="#474409"},
        -- GitStagedAddLn = {},
        --
        GitSignsStagedAdd = {fg="#635f0d"},
        GitSignsStagedAddNr = {fg="#635f0d"},
        GitSignsStagedAddCul = {fg="#635f0d"},

        GitSignsStagedChange = {fg="#7a5712"},
        GitSignsStagedChangeNr = {fg="#7a5712"},
        GitSignsStagedChangeCul = {fg="#7a5712"},
        -- GitStagedChangeLn = {fg="#573e0d"},
        --
        GitSignsStagedChangeDelete = {fg="#7a5712"},
        GitSignsStagedChangeDeleteNr = {fg="#7a5712"},
        GitSignsStagedChangeDeleteCul = {fg="#7a5712"},

        GitStagedStagedDelete = {fg="#731310"},
        GitStagedStagedDeleteNr = {fg="#731310"},
        GitStagedStagedDeleteCul = {fg="#731310"},
        -- GitStagedDeleteLn = {},

        GitStagedStagedTopdelete = {fg="#731310"},
        GitStagedStagedTopdeleteNr = {fg="#731310"},
        GitStagedStagedTopdeleteCul = {fg="#731310"},
        -- GitStagedStagedTopdeleteLn = {},

        -- Pmenu = {bg="#7c6f64"}
        -- NormalFloat = {bg="#7c6f64"}

        -- TODO: invert vim diff colours
      },
      dim_inactive = false,
      transparent_mode = true,
    },
  },
  -- { 'rebelot/kanagawa.nvim',
  --   opts = {
  --     compile = false,             -- enable compiling the colorscheme
  --     undercurl = true,            -- enable undercurls
  --     commentStyle = { italic = true },
  --     functionStyle = {},
  --     keywordStyle = { italic = true},
  --     statementStyle = { bold = true },
  --     typeStyle = {},
  --     transparent = false,         -- do not set background color
  --     dimInactive = false,         -- dim inactive window `:h hl-NormalNC`
  --     terminalColors = true,       -- define vim.g.terminal_color_{0,17}
  --     colors = {                   -- add/modify theme and palette colors
  --         palette = {},
  --         theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
  --     },
  --     overrides = function(_) -- add/modify highlights
  --         return {}
  --     end,
  --     theme = "wave",              -- Load "wave" theme when 'background' option is not set
  --     background = {               -- map the value of 'background' option to a theme
  --         dark = "wave",           -- try "dragon" !
  --         light = "lotus"
  --     },
  --   }
  -- },
  -- indent guide
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true,
    -- use opts = {} for passing setup options
    -- this is equalent to setup({}) function
  },
  {
    'norcalli/nvim-colorizer.lua',
    config=function()
      require('colorizer').setup()
    end
  }, -- show colours in place
}
