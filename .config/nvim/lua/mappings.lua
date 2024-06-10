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
--
-- gitgutter mappings
bufmap("n", "]h", "<CMD>GitGutterNextHunk<CR>")
bufmap("n", "[h", "<CMD>GitGutterPrevHunk<CR>")

-- make gt work
-- bufmap("n", "gt", "<CMD>BufferNext<CR>")
-- bufmap("n", "gT", "<CMD>BufferPrevious<CR>")

bufmap("n", "<C-E>", ":NvimTreeToggle<cr>")
bufmap("n", "<leader>n", ":NvimTreeFocus<CR>")

-- open vim diagnostic
bufmap("n", "<leader>e", vim.diagnostic.open_float)
bufmap("n", "]e", vim.diagnostic.goto_next)
bufmap("n", "[e", vim.diagnostic.goto_prev)

-- quick fix diagnostic
local local_opts = { noremap=true, silent=true }

local function quickfix()
    vim.lsp.buf.code_action({
        filter = function(a) return a.isPreferred end,
        apply = true
    })
end

vim.keymap.set('n', '<leader>qf', quickfix, local_opts)


-- telescope
bufmap("n", "<leader>tt", "<cmd>Telescope<cr>")
bufmap("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
bufmap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")
bufmap("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
bufmap("n", "<leader>fh", "<cmd>Telescope help_tags<cr>")
bufmap("n", "<C-S-P>", "<cmd>Telescope<cr>")

bufmap("n", "<C-l>", "<cmd>nohl<cr>")
bufmap("n", "J", "mzJ`z")
bufmap("n", "K", "gt")
-- bufmap("n", "<C-J>", "gt")
bufmap("n", "<C-K>", "gT")

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

-- move vertically by visual line
bufmap("n",  "j", "gj")
bufmap("n",  "k", "gk")

-- Make it easier to hit command
bufmap("n",  ";", ":")
bufmap("n",  ";", ":")
bufmap("i",  "jk", "<ESC>")
bufmap("i",  "kj", "<ESC>")

-- SOL and EOL easier
bufmap("n",  "H", "^")
bufmap("n",  "L", "$")
bufmap("n",  "H", "^")
bufmap("n",  "L", "$")
