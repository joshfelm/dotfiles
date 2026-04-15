local function config(_, opts)
  vim.g.barbar_auto_setup = false -- disable auto-setup

  -- barbar mappings
  -- Move to previous/next
  require('barbar').setup(opts)
end

return {
  {
    'romgrk/barbar.nvim',
    config=config,
    lazy = false,
    opts = {
      -- Enable/disable animations
      animation = true,

      -- Automatically hide the tabline when there are this many buffers left.
      -- Set to any value >=0 to enable.
      auto_hide = false,

      -- Enable/disable current/total tabpages indicator (top right corner)
      tabpages = true,

      -- Enables/disable clickable tabs
      --  - left-click: go to buffer
      --  - middle-click: delete buffer
      clickable = true,

      -- Excludes buffers from the tabline
      exclude_name = {'package.json'},

      -- A buffer to this direction will be focused (if it exists) when closing the current buffer.
      -- Valid options are 'left' (the default), 'previous', and 'right'
      focus_on_close = 'left',

      -- Hide inactive buffers and file extensions. Other options are `alternate`, `current`, and `visible`.
      -- hide = {extensions = true},

      -- Disable highlighting alternate buffers
      highlight_alternate = false,

      -- Disable highlighting file icons in inactive buffers
      highlight_inactive_file_icons = false,

      -- Enable highlighting visible buffers
      highlight_visible = true,

      icons = {
        -- Configure the base icons on the bufferline.
        -- Valid options to display the buffer index and -number are `true`, 'superscript' and 'subscript'
        buffer_index = false,
        buffer_number = false,
        button = '󰅙 ',
        -- Enables / disables diagnostic symbols
        diagnostics = {
          [vim.diagnostic.severity.ERROR] = {enabled = true, icon = " "},
          [vim.diagnostic.severity.WARN] = {enabled = true, icon = " "},
          [vim.diagnostic.severity.INFO] = {enabled = false, icon = " "},
          [vim.diagnostic.severity.HINT] = {enabled = false},
        },
        gitsigns = {
          added = {enabled = false, icon = '+'},
          changed = {enabled = false, icon = '~'},
          deleted = {enabled = false, icon = '-'},
        },
        filetype = {
          -- Sets the icon's highlight group.
          -- If false, will use nvim-web-devicons colors
          custom_colors = false,

          -- Requires `nvim-web-devicons` if `true`
          enabled = true,
        },
        separator = {left = '', right = ''},
        -- separator = {left = '▎', right = ''},

        -- If true, add an additional separator at the end of the buffer list
        separator_at_end = false,

        -- Configure the icons on the bufferline when modified or pinned.
        -- Supports all the base icon options.
        modified = {button = '●'},
        pinned = {button = '', filename = true},

        -- Use a preconfigured buffer appearance— can be 'default', 'powerline', or 'slanted'
        preset = 'default',

        -- Configure the icons on the bufferline based on the visibility of a buffer.
        -- Supports all the base icon options, plus `modified` and `pinned`.
        alternate = {filetype = {enabled = false}},
        current = {buffer_index = false},
        inactive = {button = '󰅙 '},
        visible = {modified = {buffer_number = false}},
      },

      -- If true, new buffers will be inserted at the start/end of the list.
      -- Default is to insert after current buffer.
      insert_at_end = false,
      insert_at_start = false,

      -- Sets the maximum padding width with which to surround each tab
      maximum_padding = 1,

      -- Sets the minimum padding width with which to surround each tab
      minimum_padding = 1,

      -- Sets the maximum buffer name length.
      maximum_length = 30,

      -- Sets the minimum buffer name length.
      minimum_length = 15,

      -- If set, the letters for each buffer in buffer-pick mode will be
      -- assigned based on their name. Otherwise or in case all letters are
      -- already assigned, the behavior is to assign letters in order of
      -- usability (see order below)
      semantic_letters = true,

      -- Set the filetypes which barbar will offset itself for
      sidebar_filetypes = {
        -- Use the default values: {event = 'BufWinLeave', text = '', align = 'left'}
        NvimTree = {
          text = 'Files',
          align = 'center',
          event = 'BufWipeout'
        },
        DiffviewFiles = {
          text = 'Source Control',
          align = 'center',
        },
      },

      -- New buffer letters are assigned in this order. This order is
      -- optimal for the qwerty keyboard layout but might need adjustment
      -- for other layouts.
      letters = 'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP',

      -- Sets the name of unnamed buffers. By default format is "[Buffer X]"
      -- where X is the buffer number. But only a static string is accepted here.
      no_name_title = nil,
    },
    keys = {
      { '<A-,>', '<CMD>BufferPrevious<CR>', desc = 'Barbar: go to previous tab' },
      { '<A-.>', '<CMD>BufferNext<CR>', desc = 'Barbar: go to next tab' },
      { '<A-1>', '<Cmd>BufferGoto 1<CR>', desc = 'Barbar: go to tab 1' },
      { '<A-2>', '<Cmd>BufferGoto 2<CR>', desc = 'Barbar: go to tab 2' },
      { '<A-3>', '<Cmd>BufferGoto 3<CR>', desc = 'Barbar: go to tab 3' },
      { '<A-4>', '<Cmd>BufferGoto 4<CR>', desc = 'Barbar: go to tab 4' },
      { '<A-5>', '<Cmd>BufferGoto 5<CR>', desc = 'Barbar: go to tab 5' },
      { '<A-6>', '<Cmd>BufferGoto 6<CR>', desc = 'Barbar: go to tab 6' },
      { '<A-7>', '<Cmd>BufferGoto 7<CR>', desc = 'Barbar: go to tab 7' },
      { '<A-8>', '<Cmd>BufferGoto 8<CR>', desc = 'Barbar: go to tab 8' },
      { '<A-9>', '<Cmd>BufferGoto 9<CR>', desc = 'Barbar: go to tab 9' },
      { '<A-0>', '<Cmd>BufferLast<CR>', desc = 'Barbar: go to last buffer' },
      { '<A-p>', '<Cmd>BufferPin<CR>', desc = 'Barbar: pin/unpin buffer' },
      { '<A-c>', '<Cmd>BufferClose<CR>', desc = 'Barbar: close buffer' },
      { '<A-,>', '<CMD>BufferPrevious<CR>', desc = 'Barbar: go to previous tab' },
      { '<A-.>', '<CMD>BufferNext<CR>', desc = 'Barbar: go to next tab' },
      -- Goto buffer in position...
      { '<A-1>', '<Cmd>BufferGoto 1<CR>', desc = 'Barbar: go to tab 1' },
      { '<A-2>', '<Cmd>BufferGoto 2<CR>', desc = 'Barbar: go to tab 2' },
      { '<A-3>', '<Cmd>BufferGoto 3<CR>', desc = 'Barbar: go to tab 3' },
      { '<A-4>', '<Cmd>BufferGoto 4<CR>', desc = 'Barbar: go to tab 4' },
      { '<A-5>', '<Cmd>BufferGoto 5<CR>', desc = 'Barbar: go to tab 5' },
      { '<A-6>', '<Cmd>BufferGoto 6<CR>', desc = 'Barbar: go to tab 6' },
      { '<A-7>', '<Cmd>BufferGoto 7<CR>', desc = 'Barbar: go to tab 7' },
      { '<A-8>', '<Cmd>BufferGoto 8<CR>', desc = 'Barbar: go to tab 8' },
      { '<A-9>', '<Cmd>BufferGoto 9<CR>', desc = 'Barbar: go to tab 9' },
      { '<A-0>', '<Cmd>BufferLast<CR>', desc = 'Barbar: go to last buffer' },
      -- Pin/unpin buffer
      { '<A-p>', '<Cmd>BufferPin<CR>', desc = 'Barbar: pin/unpin buffer' },
      -- Close buffer
      { '<A-c>', '<Cmd>BufferClose<CR>', desc = 'Barbar: close buffer' },
      -- Wipeout buffer
      --                 :BufferWipeout
      -- Close commands
      --                 :BufferCloseAllButCurrent
      --                 :BufferCloseAllButPinned
      --                 :BufferCloseAllButCurrentOrPinned
      --                 :BufferCloseBuffersLeft
      --                 :BufferCloseBuffersRight
      { '<A-l>', '<Cmd>BufferCloseBuffersRight<CR>', desc = 'Barbar: close buffers to the right' },
      { '<A-h>', '<Cmd>BufferCloseBuffersLeft<CR>', desc = 'Barbar: close buffers to the left' },
      { '<A-s-c>', '<Cmd>BufferRestore<CR>', desc = 'Barbar: restore bufer' },
      -- Magic buffer-picking mode
      { '<C-p>', '<Cmd>BufferPick<CR>', desc = 'Barbar: enter buffer picking mode' },

      -- { "K", desc = "<CMD>BufferNext<CR>" },
      -- { "J", desc = "<CMD>BufferPrevious<CR>" },

      -- make gt work
      { "gt", "<CMD>BufferNext<CR>", desc = 'Barbar: fix gt' },
      { "gT", "<CMD>BufferPrevious<CR>", desc = 'Barbar: fix gT' },
    }
  }, -- tab handler
}
