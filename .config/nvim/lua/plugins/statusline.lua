local t = require('theme')

local theme = t.theme

local feline_theme = {
  normal = {
    a = { fg = theme.green, bg = theme.bg, gui = 'bold' }, -- green
    b = { fg = theme.yellow, bg = theme.bg },               -- fg, black
    c = { fg = theme.fg1, bg = theme.bg },               -- fg, bg
    x = { fg = theme.fg1, bg = theme.bg },
    y = { fg = theme.fg, bg = theme.bg },
    z = { fg = theme.fg, bg = theme.bg },
  },
  insert = {
    a = { fg = theme.red, bg = theme.bg, gui = 'bold' }, -- red
    b = { fg = theme.yellow, bg = theme.bg },
    c = { fg = theme.fg1, bg = theme.bg },
    x = { fg = theme.fg1, bg = theme.bg },
    y = { fg = theme.fg, bg = theme.bg },
    z = { fg = theme.fg, bg = theme.bg },
  },
  visual = {
    a = { fg = theme.skyblue, bg = theme.bg, gui = 'bold' }, -- skyblue
    b = { fg = theme.yellow, bg = theme.bg },
    c = { fg = theme.fg1, bg = theme.bg },
    x = { fg = theme.fg1, bg = theme.bg },
    y = { fg = theme.fg, bg = theme.bg },
    z = { fg = theme.fg, bg = theme.bg },
  },
  command = {
    a = { fg = theme.yellow, bg = theme.bg, gui = 'bold' }, -- yellow
    b = { fg = theme.yellow, bg = theme.bg },
    c = { fg = theme.fg1, bg = theme.bg },
    x = { fg = theme.fg1, bg = theme.bg },
    y = { fg = theme.fg, bg = theme.bg },
    z = { fg = theme.fg, bg = theme.bg },
  },
  replace = {
    a = { fg = theme.orange, bg = theme.bg, gui = 'bold' }, -- orange
    b = { fg = theme.yellow, bg = theme.bg },
    c = { fg = theme.fg1, bg = theme.bg },
    x = { fg = theme.fg1, bg = theme.bg },
    y = { fg = theme.fg, bg = theme.bg },
    z = { fg = theme.fg, bg = theme.bg },
  },
  inactive = {
    a = { fg = theme.fg1, bg = theme.bg1, gui = 'bold' },
    b = { fg = theme.fg1, bg = theme.bg1 },
    c = { fg = theme.fg1, bg = theme.bg1 },
  },
}

local c = {
  mode_component = {
    function()
      return '' -- Neovim icon (requires Nerd Font)
    end,
    color = function()
      local mode_colors = {
        n      = theme.green,
        i      = theme.red,
        v      = theme.skyblue,
        V      = theme.violet,
        ['␖']  = theme.white,
        R      = theme.orange,
        c      = theme.yellow,
        s      = theme.skyblue,
        t      = theme.yellow,
      }

      local mode = vim.api.nvim_get_mode().mode
      local fg = mode_colors[mode] or theme.grey -- fallback color
      return { fg = fg, bg = theme.bg }
    end,
    padding = { left = 1, right = 1 },
  },

  tabstop = {
    function()
      return ' ' .. vim.opt.tabstop:get()
    end,
  },

  sep = {
    function()
      return '│'
    end,
    color = function()
      return {fg = theme.white, bg = theme.bg }
    end,
    padding = {left = 0, right = 0}
  }
}

return {
  {
    'nvim-lualine/lualine.nvim',
    event = "VeryLazy",
    opts = {
      options = {
        icons_enabled = true,
        theme = feline_theme,
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
        disabled_filetypes = {
          statusline = { 'NvimTree', 'alpha', 'DiffviewFiles', 'snacks_dashboard' },
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        }
      },
      sections = {
        --lualine_a = { {'mode', fmt = function(str) return '' end} },
        lualine_a = { c.mode_component },
        lualine_b = {
          c.sep,
          {
            'filetype',
            icon_only = true,
            colored = true,
            padding = { left = 1, right = 0 },
          },
          {
            'filename',
            file_status = true,      -- Displays file status (readonly status, modified status)
            newfile_status = false,  -- Display new file status (new file means no write after created)
            path = 0,                -- 0: Just the filename
            -- 1: Relative path
            -- 2: Absolute path
            -- 3: Absolute path, with tilde as the home directory
            -- 4: Filename and parent dir, with tilde as the home directory

            shorting_target = 40,    -- Shortens path to leave 40 spaces in the window
            -- for other components. (terrible name, any suggestions?)
            symbols = {
              modified = '',      -- Text to show when the file is modified.
              readonly = '󰌾',      -- Text to show when the file is non-modifiable or readonly.
              unnamed = '[No Name]', -- Text to show for unnamed buffers.
              newfile = '[New]',     -- Text to show for newly created file before first write
            },
            padding = { left = 0, right = 1 },
          },
          c.sep,
        },
        lualine_c = {
          {
            'branch',
            icon = ''
          },
          {
            'diff',
            symbols = {
              added     = ' ',
              modified  = ' ',
              removed   = ' ',
            }
          },
          {
            'lsp_progress'
          }
        },
        lualine_x = {{
          'diagnostics',

          sections = { 'error', 'warn' },
          symbols = {
            error = ' ',
            warn = ' ',
          }
        },
          'encoding',
          'fileformat'},
        lualine_y = {
          'filetype',
          c.tabstop,
          {
            'lsp_status',
            color = {fg = theme.green, bg = theme.bg}
          },
          {
            'searchcount',
            color = {fg = theme.yellow, bg = theme.bg}
          }
        },
        lualine_z = {'location'}
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {}
    },
    requires = {'nvim-tree/nvim-web-devicons', opt = false },
    dependencies = {
      {
        'linrongbin16/lsp-progress.nvim',
        opts = {
          spinner = {
            '⠋',
            '⠙',
            '⠸',
            '⢰',
            '⣠',
            '⣄',
            '⡆',
            '⠇',
          },
          client_format = function(_, spinner, series_messages)
            return #series_messages > 0 and (spinner .. ' LSP')
              or ' LSP'
          end,
          format = function(client_messages)
            local sign = ' LSP'
            if #client_messages > 0 then
              return table.concat(client_messages)
            end
            if #vim.lsp.get_clients() > 0 then return sign end
            return '󱏎 LSP'
          end,
        },
        'arkav/lualine-lsp-progress',
      },
    },
  }
}
