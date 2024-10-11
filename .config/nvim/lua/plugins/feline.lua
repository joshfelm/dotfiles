-- configure feline
local function config(_, opts)
  local colorscheme = vim.g.colors_name
  -- local palette = require('nightfox.palette').load(colorscheme)
  local feline = require('feline')
  local vi_mode = require('feline.providers.vi_mode')
  local file = require('feline.providers.file')
  local lsp = require('feline.providers.lsp')

  local theme = {
    fg = '#928374',
    bg = '#1d2021',
    black ='#1B1B1B',
    skyblue = '#458588',
    cyan = '#83a597',
    green = '#689d6a',
    oceanblue = '#1d2021',
    magenta = '#d3869b',
    orange = '#fe8019',
    red = '#cc241d',
    violet = '#b16286',
    white = '#ebdbb2',
    yellow = '#d79921',
  }

  local c = {
    -- left
    vim_status = {
      provider = function()
        local s
        if require('lazy.status').has_updates() then
          s = require('lazy.status').updates()
        else
          s = ' '
        end
        s = string.format('%s', s)
        return s
      end,
      hl = function()
        return { fg = vi_mode.get_mode_color(), bg = theme.bg }
      end,
    },

    file_name = {
      provider = {
        name = 'file_info',
        opts = { colored_icon = true },
      },
      hl = { fg = theme.yellow, bg = theme.bg },
      left_sep = {
        always_visible = true,
        str = string.format('%s', ' │ '),
        hl = { fg = 'none', bg = theme.bg },
      },
    },

    file_format = {
      provider = {
        name = 'file_type',
        opts = { filetype_icon = true, colored_icon = true },
      },
      -- hl = { fg = theme.yellow, bg = theme.bg },
      right_sep = {
        always_visible = true,
        str = string.format('%s', '  '),
        hl = { fg = 'none', bg = theme.bg },
      },
    },

    -- diagnostics = {
    --   provider = function()
    --     local lsp = require('filine.proivders.lsp')
    --     if lsp.diagnostic_exist() then
    --
    --   end
    -- },

    diagnostics_err = {
      provider = 'diagnostic_errors',
      hl = { fg = theme.red, bg = theme.bg },
    },

    diagnostics_warn = {
      provider = 'diagnostic_warnings',
      hl = { fg = theme.yellow, bg = theme.bg },
      right_sep = {
        always_visible = true,
        str = string.format('%s', '  '),
        hl = { fg = 'none', bg = theme.bg },
      },
    },
    git_branch = {
      provider = function()
        local git = require('feline.providers.git')
        local branch, icon = git.git_branch()
        local s
        if #branch > 0 then
          s = string.format('%s%s', icon, branch)
        else
          s = string.format('')
        end
        return s
      end,
      hl = { fg = theme.fg, bg = theme.bg },
      left_sep = {
        always_visible = true,
        str = string.format('%s', ' │ '),
        hl = { fg = 'none', bg = theme.bg },
      },
    },

    git_add = {
      provider = 'git_diff_added',
      hl = { fg = theme.green, bg = theme.bg },
      left_sep = {
        always_visible = true,
        str = string.format('%s', ' '),
        hl = { fg = 'none', bg = theme.bg },
      },
    },
    git_change = {
      provider = 'git_diff_changed',
      hl = { fg = theme.yellow, bg = theme.bg },
      opt = { colored_icon = true},
    },
    git_del = {
      provider = 'git_diff_removed',
      hl = { fg = theme.red, bg = theme.bg },
      opt = { colored_icon = true},
    },

    lsp = {
      provider = function()
        if not lsp.is_lsp_attached() then return '󱏎 LSP' end
        return string.format('%s', require('lsp-progress').progress())
      end,
      hl = function()
        if not lsp.is_lsp_attached() then
          return { fg = theme.fg, bg = theme.bg }
        end
        return { fg = theme.green, bg = theme.bg }
      end,
      right_sep = {
        always_visible = true,
        str = string.format('%s', '  '),
        hl = { fg = 'none', bg = theme.bg },
      },
    },

    -- right
    vi_mode = {
      provider = function()
        return string.format('%s', vi_mode.get_vim_mode())
      end,
      hl = function()
        return { fg = vi_mode.get_mode_color(), bg = theme.bg }
      end,
      right_sep = {
        always_visible = true,
        str = string.format('%s', '  '),
        hl = { fg = 'none', bg = theme.bg },
      },
    },

    macro = {
      provider = function()
        local s
        local recording_register = vim.fn.reg_recording()
        if #recording_register == 0 then
          s = ''
        else
          s = string.format('Recording @%s', recording_register)
        end
        return s
      end,
      hl = { fg = theme.fg, bg = theme.bg },
      right_sep = {
        always_visible = false,
        str = string.format('%s', '  '),
        hl = { fg = 'none', bg = theme.bg },
      },
    },

    search_count = {
      provider = 'search_count',
      hl = { fg = theme.yellow, bg = theme.bg },
      right_sep = {
        always_visible = false,
        str = string.format('%s', '  '),
        hl = { fg = 'none', bg = theme.bg },
      },
    },

    cursor_position = {
      provider = {
        name = 'position',
        opts = { padding = true },
      },
      hl = { fg = theme.blue, bg = theme.bg },
      right_sep = {
        always_visible = true,
        str = string.format('%s', ' '),
        hl = { fg = 'none', bg = theme.bg },
      },
    },

    scroll_bar = {
      provider = {
        name = 'scroll_bar',
        opts = { reverse = true },
      },
      hl = { fg = theme.blue, bg = theme.bg },
    },

    -- inactive statusline
    in_file_info = {
      provider = function()
        if vim.api.nvim_buf_get_name(0) ~= '' then
          return file.file_info({}, { colored_icon = false })
        else
          return file.file_type(
            {},
            { colored_icon = false, case = 'lowercase' }
          )
        end
      end,
      hl = { fg = theme.blue, bg = theme.bg },
    },
  }

  local active = {
    { -- left
      c.vim_status,
      c.file_name,
      c.git_branch,
      c.git_add,
      c.git_change,
      c.git_del,
    },
    { -- right
      c.macro,
      c.diagnostics_err,
      c.diagnostics_warn,
      c.file_format,
      c.lsp,
      c.search_count,
      c.cursor_position,
    },
  }

  local inactive = {
    { -- left
    },
    { -- right
      c.in_file_info,
    },
  }

  opts.components = { active = active, inactive = inactive }

  require('feline').setup(opts)
  require'feline'.use_theme(theme)
end

return {
  'freddiehaddad/feline.nvim',
  config = config,
  dependencies = {
    'lewis6991/gitsigns.nvim',
    'nvim-tree/nvim-web-devicons',
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
    },
  },
  init = function()
    -- update statusbar when there's a plugin update
    vim.api.nvim_create_autocmd('User', {
      pattern = 'LazyCheck',
      callback = function() vim.opt.statusline = vim.opt.statusline end,
    })

    -- update statusbar with LSP progress
    -- FIX: this does not work, bugs out with nvimtree
    vim.api.nvim_create_augroup('feline_augroup', { clear = true })
    vim.api.nvim_create_autocmd('User', {
      group = 'feline_augroup',
      pattern = 'LspProgressStatusUpdated',
      callback = vim.schedule_wrap(function()
        vim.cmd('redrawstatus')
      end),
    })

    -- hide the mode
    vim.opt.showmode = false

    -- hide search count on command line
    vim.opt.shortmess:append({ S = true })
  end,
  opts = {
    force_inactive = {
      filetypes = {
        '^dapui_*',
        '^help$',
        '^neotest*',
        '^NvimTree$',
        '^qf$',
      },
    },
    disable = { filetypes = { '^alpha$' } },
  },
}
