local function config(_, opts)
  require('nvim-cursorline').setup {
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
end

return {
  {
    'yamatsum/nvim-cursorline',
    config=config
  },
}
