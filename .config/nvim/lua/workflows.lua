--------------
-- obsidian --
--------------
--
-- >>> oo # from shell, navigate to vault (optional)
--
-- # NEW NOTE
-- >>> on "Note Name" # call my "obsidian new note" shell script (~/bin/on)
-- >>>
-- >>> ))) <leader>on # inside vim now, format note as template
-- >>> ))) # add tag, e.g. fact / blog / video / etc..
-- >>> ))) # add hubs, e.g. [[python]], [[machine-learning]], etc...
-- >>> ))) <leader>of # format title
--
-- # END OF DAY/WEEK REVIEW
-- >>> or # review notes in inbox
-- >>>
-- >>> ))) <leader>ok # inside vim now, move to zettelkasten
-- >>> ))) <leader>odd # or delete
-- >>>
-- >>> og # organize saved notes from zettelkasten into notes/[tag] folders
-- >>> ou # sync local with Notion
--
-- convert to todo template
vim.keymap.set("n", "<leader>ot", ":ObsidianTemplate todo<cr> :lua vim.cmd([[1,/^\\S/s/^\\n\\{1,}//]])<cr>", {desc = 'Obsidian: todo template', silent = true, noremap = true})
-- navigate to vault
vim.keymap.set("n", "<leader>oo", ":cd /home/jfelmeden/notes<cr>", {desc = 'Navigate to notes vault', silent = true, noremap = true})

-- open todays log
vim.api.nvim_create_user_command("NewMarkdown", function()
    local date = os.date("%d-%m-%Y") -- Format: YYYY-MM-DD
    local filename = "/home/jfelmeden/notes/logs/" .. date .. ".md"
    vim.cmd("edit " .. filename) -- Open the file in a new buffer
end, {})
vim.keymap.set("n", "<leader>ol", ":NewMarkdown<cr> :ObsidianTemplate note<cr>", {desc = 'Obsidian: note template', silent = true, noremap = true})
--
-- convert note to template and remove leading white space
vim.keymap.set("n", "<leader>on", ":ObsidianTemplate note<cr> :lua vim.cmd([[1,/^\\S/s/^\\n\\{1,}//]])<cr>", {desc = 'Obsidian: convert to note and remove whitespace', silent = true, noremap = true})
-- strip date from note title and replace dashes with spaces
-- must have cursor on title
vim.keymap.set("n", "<leader>of", ":s/\\(# \\)[^_]*_/\\1/ | s/-/ /g<cr>", {desc = 'Obsidian: format title', silent = true, noremap = true})
--
-- search for files in full vault
vim.keymap.set("n", "<leader>os", ":Telescope find_files search_dirs={\"/home/jfelmeden/notes\"}<cr>", {desc = 'Search for files in full vault', silent = true, noremap = true})
vim.keymap.set("n", "<leader>oz", ":Telescope live_grep search_dirs={\"/home/jfelmeden/notes\"}<cr>", {desc = 'Grep in full vault', silent = true, noremap = true})
--
-- search for files in notes (ignore zettelkasten)
-- vim.keymap.set("n", "<leader>ois", ":Telescope find_files search_dirs={\"/Users/alex/library/Mobile\\ Documents/iCloud~md~obsidian/Documents/ZazenCodes/notes\"}<cr>")
-- vim.keymap.set("n", "<leader>oiz", ":Telescope live_grep search_dirs={\"/Users/alex/library/Mobile\\ Documents/iCloud~md~obsidian/Documents/ZazenCodes/notes\"}<cr>")
--
-- for review workflow
-- move file in current buffer to zettelkasten folder
vim.keymap.set("n", "<leader>ok", ":!mv '%:p' /home/jfelmeden/notes/zettelkasten<cr>:bd<cr>", {desc = 'Obsidian: move file to zettelkasten', silent = true, noremap = true})
-- delete file in current buffer
vim.keymap.set("n", "<leader>odd", ":!rm '%:p'<cr>:bd<cr>", {desc = 'Obsidian: Delete file', silent = true, noremap = true})
