local lazy = {}

---Create a table the triggers a given handler every time it's accessed or
---called, until the handler returns a table. Once the handler has returned a
---table, any subsequent accessing of the wrapper will instead access the table
---returned from the handler.
---@param t any
---@param handler fun(t: any): table?
---@return LazyModule
function lazy.wrap(t, handler)
  local export

  local ret = {
    __get = function()
      if export == nil then
        ---@cast handler function
        export = handler(t)
      end

      return export
    end,
    __loaded = function()
      return export ~= nil
    end,
  }

  return setmetatable(ret, {
    __index = function(_, key)
      if export == nil then ret.__get() end
      ---@cast export table
      return export[key]
    end,
    __newindex = function(_, key, value)
      if export == nil then ret.__get() end
      export[key] = value
    end,
    __call = function(_, ...)
      if export == nil then ret.__get() end
      ---@cast export table
      return export(...)
    end,
  })
end

local symbol_map = lazy.wrap({}, function()
    return {
      error = vim.fn.sign_getdefined("DiagnosticSignError")[1].text,
      warning = vim.fn.sign_getdefined("DiagnosticSignWarn")[1].text,
      info = vim.fn.sign_getdefined("DiagnosticSignInfo")[1].text,
      hint = vim.fn.sign_getdefined("DiagnosticSignHint")[1].text,
    }
  end)

require('bufferline').setup({
  options = {
    view = "default",
    numbers = "none",
    buffer_close_icon = '󰅖',
    modified_icon = '●',
    close_icon = '',
    left_trunc_marker = '',
    right_trunc_marker = '',
    max_name_length = 18,
    max_prefix_length = 15, -- prefix used when a buffer is deduplicated
    tab_size = 18,
    diagnostics = "nvim_lsp",
    ---@diagnostic disable-next-line: unused-local
    -- diagnostics_indicator = function(total_count, level, diagnostics_dict)
    --   local s = ""
    --   for kind, count in pairs(diagnostics_dict) do
    --     s = string.format("%s %s%d", s, symbol_map[kind], count)
    --   end
    --   return s
    -- end,
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      local icon = level:match("error") and " " or " "
      return " " .. icon .. count
    end,
    show_buffer_close_icons = true,
    show_close_icon = true,
    show_tab_indicators = true,
    persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
    -- can also be a table containing 2 custom separators
    -- [focused and unfocused]. eg: { '|', '|' }
    -- separator_style = { "▏", "▕" },
    -- separator_style = { "│", "│" },
    separator_style = "thin",
    -- separator_style = "thin",        --  "slant" | "thick" | "thin" | { 'any', 'any' },
    enforce_regular_tabs = false,
    always_show_bufferline = true,
    -- sort_by = 'extension' | 'relative_directory' | 'directory' | function(buffer_a, buffer_b)
    --   -- add custom logic
    --   return buffer_a.modified > buffer_b.modified
    -- end
    hover = {
      enabled = false,
      delay = 10,
      reveal = {'close'}
    },
    offsets = {
      {
        filetype = "NvimTree",
        text = "Files",
        text_align = "center",
      },
      {
        filetype = "DiffviewFiles",
        text = "Source Control",
        text_align = "center",
      },
    },
  },
})
