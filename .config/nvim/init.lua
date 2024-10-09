-- Fix sign column for gruvbox
vim.cmd('au ColorScheme * hi clear SignColumn')
vim.cmd('au ColorScheme * hi GruvboxRedSign guibg=None')
vim.cmd('au ColorScheme * hi GruvboxYellowSign guibg=None')
vim.cmd('au ColorScheme * hi GruvboxAquaSign guibg=None')
vim.cmd('au ColorScheme * hi GruvboxOrangeSign guibg=None')
vim.cmd('au ColorScheme * hi GruvboxPurpleSign guibg=None')
vim.cmd('au ColorScheme * hi GruvboxGreenSign guibg=None')

-- Plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- do general before plugins
require('general')

-- require('lazy').setup({{import = 'plugins'},
--     concurrency = #vim.loop.cpu_info(),
--     checker = {
--         enabled = true,
--         concurrency = #vim.loop.cpu_info(),
--         notify = false,
--     },
--     change_detection = { notify = false },
--     rocks = { enabled = false },
-- })

require('lazy').setup({import = 'plugins'})

vim.cmd([[colorscheme gruvbox]])

-- Other settings
require('mappings')
require('workflows')

-- further plugin settings
require'colorizer'.setup()

