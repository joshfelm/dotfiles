-- Set up nvim-cmp.
local cmp = require'cmp'
local lspkind = require('lspkind')
local luasnip = require('luasnip')

require("luasnip.loaders.from_vscode").lazy_load()

-- local kind_icons = {
--   Text = "",
--   Method = "󰆧",
--   Function = "󰊕",
--   Constructor = "",
--   Field = "󰇽",
--   Variable = "󰂡",
--   Class = "󰠱",
--   Interface = "",
--   Module = "",
--   Property = "󰜢",
--   Unit = "",
--   Value = "󰎠",
--   Enum = "",
--   Keyword = "󰌋",
--   Snippet = "",
--   Color = "󰏘",
--   File = "󰈙",
--   Reference = "",
--   Folder = "󰉋",
--   EnumMember = "",
--   Constant = "󰏿",
--   Struct = "",
--   Event = "",
--   Operator = "󰆕",
--   TypeParameter = "󰅲",
-- }

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      --vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      luasnip.lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  formatting = {
    --format = function(entry, vim_item)
    --  vim_item.abbr = string.sub(vim_item.abbr, 1, 45)
    --  return vim_item
    --end
    fields = {"abbr", "kind", "menu"},
    format = lspkind.cmp_format({
      mode = 'symbol',
      maxwidth = 50,
      ellipsis_char = '...',
      show_labelDetails=true,
      before = function (_, vim_item)
          return vim_item
      end
    })
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-a>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    -- ['<TAB>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    -- ['<CR>'] = cmp.mapping(function(fallback)
    --     if cmp.visible() then
    --         if luasnip.expandable() then
    --             luasnip.expand()
    --         else
    --             cmp.confirm({
    --                 select = true,
    --             })
    --         end
    --     else
    --         fallback()
    --     end
    -- end),

    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.confirm({ select = true })
      elseif luasnip.locally_jumpable(1) then
        luasnip.jump(1)
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
  {
      name = "nvim_lsp",
      max_item_count = 200,
  },
    -- { name = 'vsnip' }, -- For vsnip users.
    { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
  }, {
    { name = 'path' }, -- For filepath.
  },{
    -- { name = 'snippy' }, -- For snippy users.
    { name = 'buffer', max_item_count = 20},
  }),
  -- experimental = {
  --   ghost_text = true,
  -- },
})

