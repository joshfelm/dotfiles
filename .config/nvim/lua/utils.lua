local M = {}

M.map = function(mode, lhs, rhs, opts)
    opts = opts or {silent = true, noremap = true}
    vim.keymap.set(mode, lhs, rhs, opts)
end

M.get_root = function()
  local path = vim.loop.fs_realpath(vim.api.nvim_buf_get_name(0)) or vim.loop.cwd()

  -- Utilize early return to avoid deep nesting
  if path == '' then return vim.loop.cwd() end

  for _, client in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
    local workspace_folders = client.config.workspace_folders or {}
    local root_dirs = vim.tbl_map(function(ws) return vim.uri_to_fname(ws.uri) end, workspace_folders)
    if client.config.root_dir then table.insert(root_dirs, client.config.root_dir) end

    for _, p in ipairs(root_dirs) do
      local r = vim.loop.fs_realpath(p)
      if r and path and path:find(r, 1, true) then
        return r -- Return immediately upon finding the first matching root
      end
    end
  end

  -- Fallback to searching for a .git directory or using cwd
  local root = vim.fs.find({ '.git' }, { path = path, upward = true })[1]
  return root and vim.fs.dirname(root) or vim.loop.cwd()
end

return M
