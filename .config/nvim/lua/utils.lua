function Bufmap(mode, lhs, rhs)
    local opts = {silent = true, noremap = false}
    vim.keymap.set(mode, lhs, rhs, opts)
end
