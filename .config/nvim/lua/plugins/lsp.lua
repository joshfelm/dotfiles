require('utils')

local function config(_, _)
  -- Set up lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  -- python
  require('lspconfig')['pyright'].setup {
    capabilities = capabilities
  }

  -- bash
  require('lspconfig')['bashls'].setup {}

  -- rust
  require('lspconfig')['rust_analyzer'].setup {}

  -- js
  require('lspconfig')['quick_lint_js'].setup {}

  -- markdown
  require('lspconfig')['marksman'].setup {}

  -- bitbake
  -- require('lspconfig')['bitbake'].setup {}

  -- vim.api.nvim_create_autocmd({ "BufEnter" }, {
  --   pattern = { "*.bb", "*.bbappend", "*.bbclass", "*.inc", "conf/*.conf" },
  --   callback = function()
  --     vim.lsp.start({
  --       name = "bitbake",
  --       cmd = { "bitbake-language-server" }
  --     })
  --   end,
  -- })

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

    ["rust_analyzer"] = {
      diagnostics = { enable = "false" },
    },

    ["marksman"] = {
      name = "marksman",
    },

    ["quick_lint_js"] = {
      name = "quick_lint",
    },

    ["bash-language-server"] = {
      cmd = {'bash-language-server', 'start'},
    },

    ["bitbake-language-server"] = {
      name = "bitbake",
      cmd = {"language-server-bitbake", "--stdio"}
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
    PATH = "prepend",
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
    float = { source = true, border = "rounded" },
    virtual_text = false,
    underline = true,
    signs = false,
  })

  vim.keymap.set('n', '<leader>e', function()
    vim.diagnostic.open_float(nil, { focus = false })
  end, { desc = 'Toggle Diagnostics' })

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
    vim.lsp.handlers.hover, { border = "rounded" }
  )

  vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function()
      Bufmap("n", "gd", "<cmd>Telescope lsp_definitions<CR>", {desc = 'LSP go to definition', silent = true, noremap = true})
      Bufmap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", {desc = 'LSP go to declaration', silent = true, noremap = true})
      Bufmap("n", "gr", "<cmd>Telescope lsp_references<CR>", {desc = 'LSP open references', silent = true, noremap = true})
      Bufmap("n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>" , {desc = 'LSP open hover', silent = true, noremap = true})
    end
  })
end

return {
  {
    "neovim/nvim-lspconfig",
    -- cmd = "Mason",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "hrsh7th/nvim-cmp",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config=config
	},
  {'onsails/lspkind.nvim'}, -- lsp icons
}
