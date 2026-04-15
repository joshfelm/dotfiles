return {
  {
    'yamatsum/nvim-cursorline',
    config = true,
    event = "VeryLazy",
    opts = {
      cursorline = {
        enable = false,
        timeout = 1000,
        number = false,
      },
      cursorword = {
        enable = true,
        timeout = 1000,
        min_length = 3,
        hl = { underline = true },
      }
    }
  },
}
