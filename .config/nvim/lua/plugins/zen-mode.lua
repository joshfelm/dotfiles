return {
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
      },
      keys = {
        { "<leader>zm", mode = { "n" }, function() require("zen-mode").toggle() end, desc = "Toggle zen mode" },
      }
    }
  },
}
