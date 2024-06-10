vim.g.mapleader = ","
vim.opt.pumheight = 12
vim.g.pumwidth = 30
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true
vim.opt.clipboard = "unnamed,unnamedplus"
vim.cmd('au ColorScheme * hi clear SignColumn')


-- Plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('vim_plugins')
require('lazy').setup('plugins')

-- Other settings
-- generic setup
require('mappings')
require('general')

require'ibl'.setup()
require'colorizer'.setup()

-- further plugin settings

require('lsp_config')
require('cmp_setup')
require('nvim_tree')
require('gitsigns_setup')
require('telescope_setup')
require('treesitter_setup')
require('alpha_setup')
require('session-manager')
require('lualine_setup')
require('nvim_cursorline')
