return {
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
}
