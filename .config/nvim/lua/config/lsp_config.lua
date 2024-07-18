local function lsp_on_attach()
  local bufopts = { noremap = true, silent = true }
  vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, bufopts)
end

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.

-- mason/mason-lspconfig/nvim-lspconfig

local nproc = string.gsub(vim.fn.system('nproc'), "\n", "")

local ensure_installed_servers = {
	"clangd@16.0.2", -- v17.0.3 indexing is too slow
	"lua_ls",
}

local server_opts = {
	["clangd"] = {
		cmd = {
			"clangd",
			"--header-insertion=never",
			"-j", nproc,
			"--completion-style=detailed",
			"--function-arg-placeholders",
			"--rename-file-limit=0",
			"--background-index",
			"--background-index-priority=normal",
		},
		filetypes = {"c", "cpp", "objc", "objcpp"},
	},

	["lua_ls"] = {
		settings = {
			Lua = {
				runtime = {
					-- Tell the language server which version of Lua you're using
					-- (most likely LuaJIT in the case of Neovim)
					version = 'LuaJIT'
				},
				-- Make the server aware of Neovim runtime files
				workspace = {
					checkThirdParty = false,
					library = {
						vim.env.VIMRUNTIME,
						vim.fn.stdpath("data") .. "/lazy/",
						-- "${3rd}/luv/library"
						-- "${3rd}/busted/library",
					},
					-- or pull in all of 'runtimepath'. NOTE: this is a lot slower
					-- library = vim.api.nvim_get_runtime_file("", true)
				},
			},
		},
	},

	["pylsp"] = {
		cmd = { "pylsp" },
		filetypes = { "python" }
	},

}

local common_capabilities = vim.tbl_deep_extend(
	"force",
	{},
	vim.lsp.protocol.make_client_capabilities(),
	require('cmp_nvim_lsp').default_capabilities() or {}
)

local server_handlers = {
	function (server_name)
		local opts = vim.tbl_deep_extend("force", {
			capabilities = vim.deepcopy(common_capabilities),
		}, server_opts[server_name] or {})
		require('lspconfig')[server_name].setup(opts)
	end,
}

local mason_opts = {
	ui = {
		border = "rounded",
		icons = {
			package_installed = "◍",
			package_pending = "◍",
			package_uninstalled = "◍",
		},
	},
	log_level = vim.log.levels.INFO,
	max_concurrent_installers = 4,
}

require('mason').setup(mason_opts)
require('mason-lspconfig').setup({
	ensure_installed = ensure_installed_servers,
	automatic_installation = true,
	handlers = server_handlers,
})

-- Diagnostics
vim.diagnostic.config({
  float = { source = "always", border = "rounded" },
  virtual_text = false,
  underline = false,
  signs = true,
})


vim.keymap.set('n', '<leader>e', function()
	-- If we find a floating window, close it.
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		if vim.api.nvim_win_get_config(win).relative ~= '' then
			vim.api.nvim_win_close(win, true)
			return
		end
	end

	vim.diagnostic.open_float(nil, { focus = false })
end, { desc = 'Toggle Diagnostics' })

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
	vim.lsp.handlers.hover, { border = "rounded" }
)
-- python
require('lspconfig')['pyright'].setup {
  capabilities = capabilities
}

-- lua
require'lspconfig'.lua_ls.setup {
  on_init = function(client)
    local path = client.workspace_folders[1].name
    if vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc') then

      return
    end

    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        -- Tell the language server which version of Lua you're using
        -- (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT'
      },
      -- Make the server aware of Neovim runtime files
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME
          -- Depending on the usage, you might want to add additional paths here.
          -- "${3rd}/luv/library"
          -- "${3rd}/busted/library",
        }
        -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
        -- library = vim.api.nvim_get_runtime_file("", true)
      }
    })
  end,
  settings = {
    Lua = {}
  },
  on_attach = lsp_on_attach
}

-- set gutter signs
local signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end


