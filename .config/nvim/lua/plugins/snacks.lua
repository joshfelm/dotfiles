local t = require('theme')

local theme = t.theme

local function config(_, opts)
  vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
  vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
  vim.api.nvim_set_hl(0, "SnacksDashboardDesc", { fg = theme.white })
  vim.api.nvim_set_hl(0, "SnacksDashboardKey", { fg = theme.red })
  vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })

  vim.api.nvim_create_user_command('Noti', 'lua Snacks.picker.notifications()' , {})

  require('snacks').setup(opts)
end

local pwd_cmd = [[
pwd | awk -v maxlen=60 -v home="$HOME" '
{
  path = $0
  gsub("^" home, "~", path)

  if (length(path) <= maxlen) {
    print "[" path "]"
    next
  }

  n = split(path, parts, "/")
  out = parts[1]  # either "" or "~"

  str = ""

  ind = length(home)
  for (i = 2; i < n; i++) {
    if (parts[i] != "") {
      out = out "/" substr(parts[i], 1, 1)
    }
    str = substr(path, ind + length(parts[i]) - 3)
    if (length(out) + length(str) <= maxlen) {
      print "[" out "/" str "]"
      next
    }
    ind = ind + length(parts[i])
  }

  out = out "/" parts[n]
  print "[" out "]"
}'
]]

return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      dashboard = {
        enabled = true,
        preset = {
          keys = {
            { icon = "󰈞 ", key = "f", desc = "Find file", action = ":FindFiles"},
            { icon = " ", key = "n", desc = "New file", action = ":ene | startinsert" },
            { icon = " ", key = "g", desc = "Find text", action = ":FindText"},
            { icon = " ", key = "o", desc = "Open file", action = ":Yazi"},
            { icon = " ", key = "l", desc = "Restore Last Session", action = ":SessionManager load_last_session"},
            { icon = " ", key = "s", desc = "Load CWD Session", action = ":SessionManager load_current_dir_session"},
            { icon = " ", key = "r", desc = "Recent files", action = ":RecentFiles"},
            { icon = " ", key = "d", desc = "Open diffview", action = ":DiffviewOpen"},
            { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy"},
            { icon = "󰿅 ", key = "q", desc = "Quit NVIM", action = ":qa"}
          },
        },
        sections = {
          { section = "header" },
          -- {
          --   section = "terminal",
          --   cmd = 'curl "http://asciiquarium.live?cols=$(tput cols)&rows=$(tput lines)"',
          --   height = 15,
          --   padding = 1,
          -- },
          {
            pane = 2,
            section = "terminal",
            cmd = "colorscript -e square",
            align = "center",
            height = 5,
            padding = 1,
          },
          {
            section = "terminal",
            cmd = pwd_cmd,
            height = 1,
            padding = 1,
          },
          { section = "keys", padding = 1 },
          { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", cwd = true, indent = 2, padding = 1 },
          { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
          {
            pane = 2,
            icon = " ",
            title = "Git Status",
            section = "terminal",
            enabled = function()
              return Snacks.git.get_root() ~= nil
            end,
            cmd = "git status --short --branch --renames",
            height = 5,
            padding = 1,
            ttl = 5 * 60,
            indent = 3,
          },
          { section = "startup" },
        },
      },
      explorer = { enabled = false },
      indent = {
        enabled = true,
        scope = {
          hl = "RainbowBlue",
        },
        animate = {
          enabled = false,
        }
      },
      input = {
        enabled = false,
        hl = "#61AFEF",
      },
      lazygit = { enabled = true },
      notifier = {
        enabled = true,
        timeout = 3000,
      },
      picker = { enabled = false },
      quickfile = { enabled = false },
      scope = { enabled = false },
      scroll = { enabled = false },
      statuscolumn = { enabled = false },
      words = { enabled = false },
      styles = {
        notification = {
          -- wo = { wrap = true } -- Wrap notifications
        }
      }
    },
    config = config,
    keys = {
      { "<leader>lg", function() Snacks.lazygit() end, desc = "Lazygit" },
    },
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          -- Setup some globals for debugging (lazy-loaded)
          _G.dd = function(...)
            Snacks.debug.inspect(...)
          end
          _G.bt = function()
            Snacks.debug.backtrace()
          end
          vim.print = _G.dd -- Override print to use snacks for `:=` command

          -- Create some toggle mappings
          Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
          Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
          Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>r")
          Snacks.toggle.diagnostics():map("<leader>ud")
          Snacks.toggle.line_number():map("<leader>ul")
          Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<leader>uc")
          Snacks.toggle.treesitter():map("<leader>uT")
          Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
          Snacks.toggle.inlay_hints():map("<leader>uh")
          Snacks.toggle.indent():map("<leader>ug")
          Snacks.toggle.dim():map("<leader>uD")
        end,
      })
    end,
  }
}
