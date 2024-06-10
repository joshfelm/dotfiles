local previewers = require("telescope.previewers")
local sorters = require("telescope.sorters")
local actions = require("telescope.actions")

require("telescope").setup({
  defaults = {
    vimgrep_arguments = {
      "rg",
      "-L",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
    },
    prompt_prefix = "   ",
    selection_caret = "> ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "ascending",
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.55,
        results_width = 0.8,
      },
      vertical = {
        mirror = false,
      },
      width = 0.8,
      height = 0.65,
      preview_cutoff = 120,
    },
    file_sorter = sorters.get_fuzzy_file,
    file_ignore_patterns = {
      "node_modules",
      ".git",
    },
    generic_sorter = sorters.get_generic_fuzzy_sorter,
    path_display = { "truncate" },
    winblend = 0,
    border = {},
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    color_devicons = true,
    set_env = {
      ["COLORTERM"] = "truecolor",
    },
    file_previewer = previewers.vim_buffer_cat.new,
    grep_previewer = previewers.vim_buffer_vimgrep.new,
    qflist_previewer = previewers.vim_buffer_qflist.new,
    buffer_previewer_maker = previewers.buffer_previewer_maker,
    mappings = {
      n = {
        ["q"] = actions.close,
      },
    },
    cache_picker = {
      num_pickers = 50,
    },
    extensions = {
      undo = {
        side_by_side = true,
        use_delta = false,
      },
    },
  },
})

local tb = require('telescope.builtin')
vim.api.nvim_set_keymap('n', '<leader>fw', [[<cmd>lua require('telescope.builtin').grep_string()<cr>]], { silent = true, noremap = true })
vim.keymap.set('v', '<leader>fw', function()
  local text = vim.getVisualSelection()
  tb.grep_string({ search = text })
end, { silent = true, noremap = true })


vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function()
    local bufmap = function(mode, lhs, rhs)
        local opts = {buffer = true, silent = true, noremap = false}
        vim.keymap.set(mode, lhs, rhs, opts)
    end

    bufmap("n", "gd", "<cmd>Telescope lsp_definitions<CR>")
    bufmap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
    bufmap("n", "gr", "<cmd>Telescope lsp_references<CR>")
    bufmap("n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>" )
  end
})

