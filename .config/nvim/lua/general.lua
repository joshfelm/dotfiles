-- flash on yank
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
vim.opt.pumheight = 40
vim.g.pumwidth = 30
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.clipboard = "unnamed" -- set to unnamedplus to always yank to clipboard
vim.opt.fillchars:append { diff = "╱" } -- set diffview to have the greyed out stuff

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
vim.o.conceallevel = 2 -- set conceal level for obsidian plugin

-- Make searching better
vim.opt.smartcase=true
vim.opt.ignorecase=true

-- set gutter signs
local signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- vim.opt.statuscolumn = "%=%{v:lnum?v:lnum:v:lnum} %s"
