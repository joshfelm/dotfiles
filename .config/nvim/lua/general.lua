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

-- some general setup
vim.g.mapleader = ","
vim.opt.pumheight = 12
vim.g.pumwidth = 30
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true
vim.opt.clipboard = "unnamed" -- set to unnamedplus to always yank to clipboard

-- For folds
-- vim.opt.foldmethod="indent" -- XXX: this breaks tabs??
vim.opt.modelines=1
vim.opt.foldenable=true
vim.opt.foldlevelstart=10 --open most folds by default
vim.opt.foldnestmax=10 --max 10 nested folds
vim.opt.updatetime=200

vim.opt.syntax="on"					-- Turn on highlighting
vim.opt.number=true					-- Turn on line numbers
vim.opt.cursorline=true	-- Turn on cursorline
vim.opt.showmode=false

-- Change tab spaces and make soft
vim.opt.tabstop=4
vim.opt.shiftwidth=4
vim.opt.softtabstop=4
vim.opt.expandtab=true

-- Make searching better
vim.opt.smartcase=true
vim.opt.ignorecase=true

-- autofiletypes
vim.api.nvim_create_autocmd("FileType", {
	pattern = "c",
	callback = function()
		vim.opt_local.shiftwidth = 8
		vim.opt_local.tabstop = 8
		vim.opt_local.expandtab = false
	end
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "json",
	callback = function()
		vim.opt_local.tabstop = 2
		vim.opt_local.shiftwidth = 2
		vim.opt_local.softtabstop = 2
	end
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "lua",
	callback = function()
	  vim.opt_local.tabstop = 2
		vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
	end
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function()
	  vim.opt_local.tw = 74
	  vim.opt_local.spell = true
	end
})
