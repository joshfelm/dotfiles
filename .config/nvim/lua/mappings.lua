require('utils')

vim.api.nvim_set_hl(0, 'Flashy', {bold=true, bg="#45475b"})
vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('YankHighlight', { clear = true }),
  desc = 'Highlight selection on yank',
  pattern = '*',
  callback = function()
    vim.highlight.on_yank({ higroup = 'Flashy', timeout = 200 })
  end,
})


-- open vim diagnostic
Bufmap("n", "]e", vim.diagnostic.goto_next, {desc = 'Goto next error', silent = true, noremap = true})
Bufmap("n", "[e", vim.diagnostic.goto_prev, {desc = 'Goto previous error', silent = true, noremap = true})

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

Bufmap("n", "<leader>/", "<cmd>nohl<cr>", {desc = 'Clear highlight', silent = true, noremap = true})
Bufmap("n", "J", "mzJ`z", {desc = 'Join', silent = true, noremap = false})

-- Add a heading/subheading to current line
Bufmap("n",  "<leader>=", "yypVr=<Esc>==", {desc = 'Add heading (=)', silent = true, noremap = true})
Bufmap("n",  "<leader>-", "yypVr-<Esc>==", {desc = 'Add heading (-)', silent = true, noremap = true})

-- Make pasting easier
-- Bufmap("i",  "<c-z>", "<esc>ugi")
Bufmap("i",  "<C-s>", "<esc>:w<enter>gi", {desc = 'Save in insert', silent = true, noremap = true})

-- folds
Bufmap("n", "<space>", "za", {desc = 'Toggle fold', silent = true, noremap = true})

-- Don't let x and c to spoil the yank register
Bufmap({"n", "v"},  "x", '"_x', {desc = 'Delete char (don\'t yank)', silent = true, noremap = true})
Bufmap({"n", "v"},  "c", '"_c', {desc = 'Change char (don\t yank)', silent = true, noremap = true})

-- Map leader to copy/paste using clipboard
Bufmap({"v", "n"},  "<leader>y", [["+y]], {desc = 'Copy to clipboard', silent = true, noremap = true})
Bufmap({"v", "n"},  "<leader>p", [["+p]], {desc = 'Paste from clipboard', silent = true, noremap = true})

-- move vertically by visual line
Bufmap("n",  "j", "gj", {desc = 'Move up visually', silent = true, noremap = true})
Bufmap("n",  "k", "gk", {desc = 'Move down visually', silent = true, noremap = true})

-- Make it easier to hit command
Bufmap({"n", "v"},  ";", ":", {desc = 'command', silent = false, noremap = true})
Bufmap("i",  "jk", "<ESC>", {desc = 'Escape normal mode', silent = true, noremap = true})
Bufmap("i",  "kj", "<ESC>", {desc = 'Escape normal mode', silent = true, noremap = true})

-- SOL and EOL easier
Bufmap({"n", "x", "o", "v"},  "H", "^", {desc = 'Go to start of line', silent = true, noremap = true})
Bufmap({"n", "x", "o", "v"},  "L", "$", {desc = 'Go to end of line', silent = true, noremap = true})

-- Move lines
Bufmap("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", {desc = 'Move line down (normal)', silent = true, noremap = true})
Bufmap("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", {desc = 'Move line up (normal)', silent = true, noremap = true})
Bufmap("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi" , {desc = 'Move line down (insert)', silent = true, noremap = true})
Bufmap("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi" , {desc = 'Move line up (insert)', silent = true, noremap = true})
Bufmap("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", {desc = 'Move line up (visual)', silent = true, noremap = true})
Bufmap("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", {desc = 'Move line down (visual)', silent = true, noremap = true})

