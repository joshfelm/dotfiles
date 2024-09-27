require('alpha.term')
local config = function()
  local path_ok, plenary_path = pcall(require, "plenary.path")
  if not path_ok then
      return
  end

  vim.api.nvim_set_hl(0, "AlphaHeader", { fg = '#fabd2f', bold=true })
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

    -- local header = {
    --     type = "terminal",
    --     command = "cat | $HOME/.config/nvim/thisisfine.sh",
    --     height = 25,
    --     width =  45,
    --     opts = {
    --         redraw = true,
    --         position = "center",
    --         window_config  = {},
    --     }
    -- }

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
[[                               __                ]],
[[  ___      __    ___   __  __ /\_\    ___ ___      ]],
[[ /  _`\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\    ]],
[[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \   ]],
[[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\  ]],
[[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/  ]],
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
        dashboard.button("e", "  New file", "<cmd>ene<CR>"),
        dashboard.button("o", "  Open file", ":Yazi<CR>"),
        dashboard.button("l", "󰑙  Restore Last Session"  , ":SessionManager load_last_session<CR>"),
        dashboard.button("c", "  Load CWD Session"  , ":SessionManager load_current_dir_session<CR>"),
        dashboard.button("u", "  Plugins"  , "<cmd>Lazy<CR>"),
        dashboard.button("r", "  Recent files"   , ":Telescope oldfiles<CR>"),
        dashboard.button("s", "  Settings" , ":e $MYVIMRC<CR>"),
        dashboard.button("f f", "󰈞  Find file", "<cmd>Telescope find_files<CR>"),
        dashboard.button("f g", "󰊄  Live grep", "<cmd>Telescope live_grep<CR>"),
        dashboard.button("q", "󰿅  Quit NVIM", "<cmd>qa<CR>"),
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
        buttons,
        { type = "padding", val = 2 },
        section_mru,
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


-- Disable folding on alpha buffer
vim.cmd([[
    autocmd FileType alpha setlocal nofoldenable
]])
