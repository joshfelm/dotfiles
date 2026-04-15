local utils = require('utils')

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
utils.map("n", "]e", vim.diagnostic.goto_next, {desc = 'Goto next error', silent = true, noremap = true})
utils.map("n", "[e", vim.diagnostic.goto_prev, {desc = 'Goto previous error', silent = true, noremap = true})

local function quickfix()
    vim.lsp.buf.code_action({
        filter = function(a) return a.isPreferred end,
        apply = true
    })
end

-- quick fix diagnostic
utils.map('n', '<leader>qf', quickfix)

-- lsp lines setup
-- utils.map('n', "<leader>l", require("lsp_lines").toggle)

utils.map("n", "<leader>/", "<cmd>nohl<cr>", {desc = 'Clear highlight', silent = true, noremap = true})
utils.map("n", "J", "mzJ`z:delmarks z<cr>", {desc = 'Join (without moving cursor)', silent = true, noremap = false})

-- Add a heading/subheading to current line
utils.map("n",  "<leader>=", "yypVr=<Esc>==", {desc = 'Add heading (=)', silent = true, noremap = true})
utils.map("n",  "<leader>-", "yypVr-<Esc>==", {desc = 'Add heading (-)', silent = true, noremap = true})

-- Make pasting easier
-- utils.map("i",  "<c-z>", "<esc>ugi")
utils.map("i",  "<C-s>", "<esc>:w<enter>gi", {desc = 'Save in insert', silent = true, noremap = true})

-- folds
utils.map("n", "<space>", "za", {desc = 'Toggle fold', silent = true, noremap = true})

-- Don't let x and c to spoil the yank register
utils.map({"n", "v"},  "x", '"_x', {desc = 'Delete char (don\'t yank)', silent = true, noremap = true})
utils.map({"n", "v"},  "c", '"_c', {desc = 'Change char (don\'t yank)', silent = true, noremap = true})

-- Map leader to copy/paste using clipboard
utils.map({"v", "n"},  "<leader>y", [["+y]], {desc = 'Copy to clipboard', silent = true, noremap = true})
utils.map({"v", "n"},  "<leader>p", [["+p]], {desc = 'Paste from clipboard', silent = true, noremap = true})

-- move vertically by visual line
utils.map("n",  "j", "gj", {desc = 'Move up visually', silent = true, noremap = true})
utils.map("n",  "k", "gk", {desc = 'Move down visually', silent = true, noremap = true})

-- Make it easier to hit command
utils.map({"n", "v"},  ";", ":", {desc = 'command', silent = false, noremap = true})
utils.map("i",  "jk", "<ESC>", {desc = 'Escape normal mode', silent = true, noremap = true})
utils.map("i",  "kj", "<ESC>", {desc = 'Escape normal mode', silent = true, noremap = true})

-- SOL and EOL easier
utils.map({"n", "x", "o", "v"},  "H", "^", {desc = 'Go to start of line', silent = true, noremap = true})
utils.map({"n", "x", "o", "v"},  "L", "$", {desc = 'Go to end of line', silent = true, noremap = true})

-- Move lines
utils.map("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", {desc = 'Move line down (normal)', silent = true, noremap = true})
utils.map("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", {desc = 'Move line up (normal)', silent = true, noremap = true})
utils.map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi" , {desc = 'Move line down (insert)', silent = true, noremap = true})
utils.map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi" , {desc = 'Move line up (insert)', silent = true, noremap = true})
utils.map("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", {desc = 'Move line up (visual)', silent = true, noremap = true})
utils.map("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", {desc = 'Move line down (visual)', silent = true, noremap = true})

-- duplicate line and add comment
utils.map("n", "ycc", "yygccp", { desc = "Duplicate line, comment first", remap = true })

-- add semicolon to end of line
utils.map("n", ",;", "mzA;<esc>`z:delmarks z<cr>", {desc = "Add semicolon to end of line", silent = true, noremap = true});

-- toggle relative line (handled in snacks)
-- utils.map("n", "<leader>r", ':let [&nu, &rnu] = [1, !&rnu]<cr>', { desc = "Toggle relative line numbers", silent = true, noremap = true })

-- map mouse wheel
utils.map("n", "<Up>", "<C-Y>", {desc = "Mouse wheel up", silent = true, noremap = true})
utils.map("n", "<Down>", "<C-E>", {desc = "Mouse wheel down", silent = true, noremap = true})
utils.map("i", "<Up>", "<C-O><C-Y>", {desc = "Mouse wheel up", silent = true, noremap = true})
utils.map("i", "<Down>", "<C-O><C-E>", {desc = "Mouse wheel down", silent = true, noremap = true})
