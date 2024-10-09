local function config(_, _)
  -- FIX: move this to diffview
  Bufmap("n", "<leader>do", ":DiffviewOpen")
  Bufmap("n", "<leader>dc", ":DiffviewClose<CR>")
end

return {
  {
    'sindrets/diffview.nvim',
    config = config,
  },
}
