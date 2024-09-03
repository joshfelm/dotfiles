local bufmap = function(mode, lhs, rhs)
    local opts = {silent = true, noremap = false}
    vim.keymap.set(mode, lhs, rhs, opts)
end

-- ranger mappings
bufmap("n", "<M-o>", ":RnvimrToggle<CR>")

-- Resize floating window by all preset layouts
-- bufmap("t", "<M-i>", "<C-\><C-n>:RnvimrResize<CR>")

-- Resize floating window by special preset layouts
-- bufmap("t", "<M-l>", "<C-\><C-n>:RnvimrResize 1,8,9,11,5<CR>")

-- Resize floating window by single preset layout
-- bufmap("t", "<M-y>", "<C-\><C-n>:RnvimrResize 6<CR>")


-- open vim diagnostic
bufmap("n", "]e", vim.diagnostic.goto_next)
bufmap("n", "[e", vim.diagnostic.goto_prev)


local function quickfix()
    vim.lsp.buf.code_action({
        filter = function(a) return a.isPreferred end,
        apply = true
    })
end

-- quick fix diagnostic
bufmap('n', '<leader>qf', quickfix)

-- lsp lines setup
-- bufmap('n', "<leader>l", require("lsp_lines").toggle)

-- zenmode
bufmap('n', "<leader>zm", require("zen-mode").toggle)

bufmap("n", "<leader>h", "<cmd>nohl<cr>")
bufmap("n", "J", "mzJ`z")

-- Add a heading/subheading to current line
bufmap("n",  "<leader>=", "yypVr=<Esc>==")
bufmap("n",  "<leader>-", "yypVr-<Esc>==")

-- Make pasting easier
bufmap("i",  "<c-z>", "<esc>ui")
bufmap("i",  "<C-s>", "<esc>:w<enter>a")

-- folds
bufmap("n", "<space>", "za")

-- Don't let x and c to spoil the yank register
bufmap("n",  "x", '"_x')
bufmap("n",  "c", '"_c')

-- Map leader to copy into clipboard
bufmap({"v", "n"},  "<leader>y", [["+y]])

-- move vertically by visual line
bufmap("n",  "j", "gj")
bufmap("n",  "k", "gk")

-- Make it easier to hit command
bufmap({"n", "v"},  ";", ":")
bufmap("i",  "jk", "<ESC>")
bufmap("i",  "kj", "<ESC>")

-- SOL and EOL easier
bufmap({"n", "x", "o", "v"},  "H", "^")
bufmap({"n", "x", "o", "v"},  "L", "$")
