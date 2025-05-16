require('utils')
require('colorscheme')
-- configure feline
local function config(_, opts)
  local vi_mode = require('feline.providers.vi_mode')
  local file = require('feline.providers.file')
  local lsp = require('feline.providers.lsp')

  local vi_mode_colors = {
    ["StatusComponentVimNormal"] = Theme.green,
    ["StatusComponentVimInsert"] = Theme.red,
    ["StatusComponentVimVisual"] = Theme.skyblue,
    ["StatusComponentVimLines"] = Theme.violet,
    ["StatusComponentVimBlock"] = Theme.magenta,
    ["StatusComponentVimCommand"] = Theme.yellow
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
        local col = vi_mode_colors[vi_mode.get_mode_highlight_name()]
        if not col then
          col = vi_mode.get_mode_color()
        end
        return { fg = col, bg = Theme.bg }
      end,
    },

    file_name = {
      provider = {
        name = 'file_info',
        opts = { colored_icon = true },
      },
      hl = { fg = Theme.yellow, bg = Theme.bg },
      left_sep = {
        always_visible = true,
        str = string.format('%s', ' │ '),
        hl = { fg = 'none', bg = Theme.bg },
      },
    },

    file_format = {
      provider = {
        name = 'file_type',
        opts = { filetype_icon = true, colored_icon = true },
      },
      -- hl = { fg = Theme.yellow, bg = Theme.bg },
      right_sep = {
        always_visible = true,
        str = string.format('%s', '  '),
        hl = { fg = 'none', bg = Theme.bg },
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
      hl = { fg = Theme.red, bg = Theme.bg },
    },

    diagnostics_warn = {
      provider = 'diagnostic_warnings',
      hl = { fg = Theme.yellow, bg = Theme.bg },
      right_sep = {
        always_visible = true,
        str = string.format('%s', '  '),
        hl = { fg = 'none', bg = Theme.bg },
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
      hl = { fg = Theme.fg1, bg = Theme.bg },
      left_sep = {
        always_visible = true,
        str = string.format('%s', ' │ '),
        hl = { fg = 'none', bg = Theme.bg },
      },
    },

    git_add = {
      provider = 'git_diff_added',
      hl = { fg = Theme.green, bg = Theme.bg },
      left_sep = {
        always_visible = true,
        str = string.format('%s', ' '),
        hl = { fg = 'none', bg = Theme.bg },
      },
    },
    git_change = {
      provider = 'git_diff_changed',
      hl = { fg = Theme.yellow, bg = Theme.bg },
      opt = { colored_icon = true},
    },
    git_del = {
      provider = 'git_diff_removed',
      hl = { fg = Theme.red, bg = Theme.bg },
      opt = { colored_icon = true},
    },

    tabspace = {
      provider = function()
        return string.format(' %s ', vim.opt.tabstop:get())
      end,
      hl = { fg = Theme.fg, bg = Theme.bg },
      right_sep = {
        always_visible = true,
        str = string.format('%s', ' '),
        hl = { fg = 'none', bg = Theme.bg },
      },
    },

    lsp = {
      provider = function()
        if not lsp.is_lsp_attached() then return '󱏎 LSP' end
        return string.format('%s', require('lsp-progress').progress())
      end,
      hl = function()
        if not lsp.is_lsp_attached() then
          return { fg = Theme.grey, bg = Theme.bg }
        end
        return { fg = Theme.green, bg = Theme.bg }
      end,
      right_sep = {
        always_visible = true,
        str = string.format('%s', '  '),
        hl = { fg = 'none', bg = Theme.bg },
      },
    },

    -- right
    vi_mode = {
      provider = function()
        return string.format('%s', vi_mode.get_vim_mode())
      end,
      hl = function()
        return { fg = vi_mode.get_mode_color(), bg = Theme.bg }
      end,
      right_sep = {
        always_visible = true,
        str = string.format('%s', '  '),
        hl = { fg = 'none', bg = Theme.bg },
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
      hl = { fg = Theme.fg, bg = Theme.bg },
      right_sep = {
        always_visible = false,
        str = string.format('%s', '  '),
        hl = { fg = 'none', bg = Theme.bg },
      },
    },

    search_count = {
      provider = 'search_count',
      hl = { fg = Theme.yellow, bg = Theme.bg },
      right_sep = {
        always_visible = false,
        str = string.format('%s', '  '),
        hl = { fg = 'none', bg = Theme.bg },
      },
    },

    cursor_position = {
      provider = {
        name = 'position',
        opts = { padding = true },
      },
      hl = { fg = Theme.fg, bg = Theme.bg },
      right_sep = {
        always_visible = true,
        str = string.format('%s', ' '),
        hl = { fg = 'none', bg = Theme.bg },
      },
    },

    scroll_bar = {
      provider = {
        name = 'scroll_bar',
        opts = { reverse = true },
      },
      hl = { fg = Theme.fg, bg = Theme.bg },
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
      hl = { fg = Theme.skyblue, bg = Theme.bg },
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
      c.tabspace,
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
  require'feline'.use_theme(Theme)
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
