local utils = require('utils')

local function config(_, _)
  utils.Bufmap("n", "<leader>do", ":DiffviewOpen ", {desc = 'Close diff view', silent = false, noremap = true})
  utils.Bufmap("n", "<leader>dc", ":DiffviewClose<CR>", {desc = 'Close diff view', silent = false, noremap = true})
  utils.Bufmap("n", "<leader>df", ":DiffviewFileHistory<CR>", {desc = 'Open diff view file history', silent = true, noremap = true})
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = {"DiffviewFiles", "DiffviewFileHistory"},
  callback = function()
    vim.schedule(function()
      vim.keymap.set("n", "q", ":DiffviewClose<cr>", {buffer = true})
      vim.keymap.set("n", "r", ":DiffviewRefresh<cr>", {buffer = true})
    end)
  end
})

return {
  {
    'sindrets/diffview.nvim',
    config = config,
  },
}
