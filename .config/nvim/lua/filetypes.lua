-- autofiletypes

vim.api.nvim_create_autocmd("FileType", {
	pattern = "dts",
	callback = function()
		vim.opt_local.shiftwidth = 4
		vim.opt_local.tabstop = 4
		vim.opt_local.expandtab = false
	end
})

local autocmd = vim.api.nvim_create_autocmd
local function augroup(name)
    return vim.api.nvim_create_augroup("MyConfig" .. name, { clear = true })
end

local map = vim.keymap.set

-- enable treesitter highlight
vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    pcall(vim.treesitter.start, args.buf)
  end,
})

-- set tabstop to be 2 for scripting languages
autocmd("FileType", {
  group = augroup("Scripting"),
	pattern = { "json", "sh", "javascript", "lua", "css", "vue", "yaml", "html", "zsh", "svelte" },
	callback = function()
		vim.opt_local.tabstop = 2
		vim.opt_local.shiftwidth = 2
		vim.opt_local.softtabstop = 2
	end
})

-- handle markdown specific
autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		vim.opt_local.tabstop = 2
		vim.opt_local.shiftwidth = 2
		vim.opt_local.softtabstop = 2
	  vim.opt_local.tw = 74
	  vim.opt_local.spell = true
		vim.opt_local.formatoptions:append("r") -- `<CR>` in insert mode
		vim.opt_local.formatoptions:append("o") -- `o` in normal mode
		-- vim.opt_local.comments = {
		-- 	"b:- [ ]", -- tasks
		-- 	"b:- [x]",
		-- 	"b:*", -- unordered list
		-- 	"b:-",
		-- 	"b:+",
		-- }
	end
})

-- Close some filetypes with <q>
autocmd("FileType", {
    group = augroup("CloseWithQ"),
    pattern = {
        "checkhealth",
        "dap-float",
        "gitsigns-blame",
        "help",
        "qf",
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.schedule(function()
            map("n", "q", function()
                vim.cmd("close")
                pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
            end, {
                buffer = event.buf,
                silent = true,
                desc = "Quit buffer",
            })
        end)
    end,
})

-- Enable spellcheck and line wrapping in select file types
autocmd("FileType", {
    group = augroup("SpellWrap"),
    pattern = { "text", "gitcommit", "markdown" },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end,
})

-- disable statusline in dashboard
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = {"alpha", "snacks_dashboard"},
--   callback = function()
--     local old_laststatus = vim.opt.laststatus
--
--     vim.api.nvim_create_autocmd("BufUnload", {
--       buffer = 0,
--       callback = function()
--         vim.opt.laststatus = old_laststatus
--       end,
--     })
--
--     vim.opt.laststatus = 0
--   end,
-- })
