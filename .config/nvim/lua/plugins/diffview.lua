local function config(_, _)
  Bufmap("n", "<leader>dvo", ":DiffviewOpen")
  Bufmap("n", "<leader>dvc", ":DiffviewClose<CR>")
  Bufmap("n", "<leader>dvf", ":DiffviewFileHistory<CR>")
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = {"DiffviewFiles", "DiffviewFileHistory"},
  callback = function()
    vim.schedule(function()
      vim.keymap.set("n", "q", ":DiffviewClose<cr>", {buffer = true})
    end)
  end
})

return {
  {
    'sindrets/diffview.nvim',
    config = config,
  },
}
