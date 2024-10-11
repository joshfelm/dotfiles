require('utils')

-- open vim diagnostic
Bufmap("n", "]e", vim.diagnostic.goto_next)
Bufmap("n", "[e", vim.diagnostic.goto_prev)

local function quickfix()
    vim.lsp.buf.code_action({
        filter = function(a) return a.isPreferred end,
        apply = true
    })
end

-- quick fix diagnostic
Bufmap('n', '<leader>qf', quickfix)

-- lsp lines setup
-- Bufmap('n', "<leader>l", require("lsp_lines").toggle)

Bufmap("n", "<leader>h", "<cmd>nohl<cr>")
Bufmap("n", "J", "mzJ`z")

-- Add a heading/subheading to current line
Bufmap("n",  "<leader>=", "yypVr=<Esc>==")
Bufmap("n",  "<leader>-", "yypVr-<Esc>==")

-- Make pasting easier
Bufmap("i",  "<c-z>", "<esc>ui")
Bufmap("i",  "<C-s>", "<esc>:w<enter>a")

-- folds
Bufmap("n", "<space>", "za")

-- Don't let x and c to spoil the yank register
Bufmap("n",  "x", '"_x')
Bufmap("n",  "c", '"_c')

-- Map leader to copy into clipboard
Bufmap({"v", "n"},  "<leader>y", [["+y]])

-- move vertically by visual line
Bufmap("n",  "j", "gj")
Bufmap("n",  "k", "gk")

-- Make it easier to hit command
Bufmap({"n", "v"},  ";", ":")
Bufmap("i",  "jk", "<ESC>")
Bufmap("i",  "kj", "<ESC>")

-- SOL and EOL easier
Bufmap({"n", "x", "o", "v"},  "H", "^")
Bufmap({"n", "x", "o", "v"},  "L", "$")
