return {
  { "sainnhe/gruvbox-material", name = "gruvbox-material", priority = 1000,
    -- config = function()
    --   vim.cmd([[colorscheme gruvbox-material]])
    -- end
  },
  { "catppuccin/nvim", name = "catppuccin",
    -- config = function()
    --   vim.cmd([[colorscheme catppuccin-macchiato]])
    -- end
  },
  {
    "sindrets/oxocarbon-lua.nvim"
  },
  { "nyoom-engineering/oxocarbon.nvim" },
  { "ellisonleao/gruvbox.nvim", priority = 1000 , lazy = false,
    -- colorscheme
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
        NormalFloat = {bg = "#504945"}
        -- TODO: invert vim diff colours
      },
      dim_inactive = false,
      transparent_mode = true,
    },
    config = true,
  },
  { 'rebelot/kanagawa.nvim',
    opts = {
      compile = false,             -- enable compiling the colorscheme
      undercurl = true,            -- enable undercurls
      commentStyle = { italic = true },
      functionStyle = {},
      keywordStyle = { italic = true},
      statementStyle = { bold = true },
      typeStyle = {},
      transparent = false,         -- do not set background color
      dimInactive = false,         -- dim inactive window `:h hl-NormalNC`
      terminalColors = true,       -- define vim.g.terminal_color_{0,17}
      colors = {                   -- add/modify theme and palette colors
          palette = {},
          theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
      },
      overrides = function(_) -- add/modify highlights
          return {}
      end,
      theme = "wave",              -- Load "wave" theme when 'background' option is not set
      background = {               -- map the value of 'background' option to a theme
          dark = "wave",           -- try "dragon" !
          light = "lotus"
      },
    }
  },
  -- indent guide
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true,
    -- use opts = {} for passing setup options
    -- this is equalent to setup({}) function
  },
  {'norcalli/nvim-colorizer.lua', config=true}, -- show colours in place
}
