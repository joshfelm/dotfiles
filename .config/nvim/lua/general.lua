-- flash on yank
vim.api.nvim_set_hl(0, 'Flashy', {bold=true, bg="#45475b"})
vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('YankHighlight', { clear = true }),
  desc = 'Highlight selection on yank',
  pattern = '*',
  callback = function()
    vim.highlight.on_yank({ higroup = 'Flashy', timeout = 200 })
  end,
})

-- make barbar actually close buffers
-- vim.api.nvim_create_autocmd('BufLeave', {
--   callback = function(tbl)
--     if(((vim.fn.len(vim.fn.getbufinfo({'buflisted':1}))) > 1)) then
--       vim.cmd.BufferClose(tbl)
--     end
--   end,
--   group = vim.api.nvim_create_augroup('barbar_close_buf', {})
-- })

-- function ExitBuffer()
--     if len(vim.cmd.getbufinfo({'buflisted':1})) > 1 then
--         bdelete
--     else
--         quit
--     endif
-- end

function vim.getVisualSelection()
  vim.cmd('noau normal! "vy"')
  local text = vim.fn.getreg('v')
  vim.fn.setreg('v', {})

  text = string.gsub(text, "\n", "")
  if #text > 0 then
      return text
  else
      return ''
  end
end

-- For folds
vim.opt.foldmethod=indent
vim.opt.modelines=1
vim.opt.foldenable=true
vim.opt.foldlevelstart=10 --open most folds by default
vim.opt.foldnestmax=10 --max 10 nested folds
vim.opt.updatetime=200

-- vim.opt.backspace=indent,eol,start			 --Make backspace work
vim.opt.syntax="on"					-- Turn on highlighting
vim.opt.number=true					-- Turn on line numbers
vim.opt.relativenumber=true
vim.opt.showmode=false

-- Change tab spaces and make soft
vim.opt.tabstop=4
-- autocmd Filetype css setlocal tabstop=2
vim.opt.shiftwidth=4
vim.opt.expandtab=true

-- Make searching better
vim.opt.smartcase=true
vim.opt.ignorecase=true

