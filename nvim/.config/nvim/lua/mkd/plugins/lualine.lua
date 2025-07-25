local function worktree()
  local wt = os.getenv("GIT_WORKTREE")
  if wt == nil or wt == "" then
    return ""
  end
  return ("[" .. wt .. "]")
end

--- @param trunc_width number trunctates component when screen width is less then trunc_width
--- @param trunc_len number truncates component to trunc_len number of chars
--- @param hide_width number hides component when window width is smaller then hide_width
--- @param no_ellipsis boolean whether to disable adding '...' at end after truncation
--- return function that can format the component accordingly

local function trunc(trunc_width, trunc_len, hide_width, no_ellipsis)
  return function(str)
    local win_width = vim.fn.winwidth(0)
    if hide_width and win_width < hide_width then
      return ""
    elseif trunc_width and trunc_len and win_width < trunc_width and #str > trunc_len then
      return str:sub(1, trunc_len) .. (no_ellipsis and "" or "...")
    end
    return str
  end
end

return {
  "hoob3rt/lualine.nvim",
  event = "VeryLazy",
  config = function()
    local lualine = require("lualine")

    local diagnostics = {
      "diagnostics",
      sources = { "nvim_lsp" },
      sections = { "error", "warn", "info", "hint" },
      symbols = { error = "E", warn = "W", info = "I", hint = "H" },
      colored = true,
      update_in_insert = false,
      always_visible = true,
    }

    local function diff_source()
      local gitsigns = vim.b.gitsigns_status_dict
      if gitsigns then
        return { added = gitsigns.added, modified = gitsigns.changed, removed = gitsigns.removed }
      end
    end

    local diff = {
      "diff",
      source = diff_source,
      colored = true,
      diff_color = { added = { fg = "#32A0B4" }, modified = { fg = "#E6B450" }, removed = { fg = "#B40000" } },
      symbols = { added = "+", modified = "~", removed = "-" },
    }

    lualine.setup({
      options = {
        icons_enabled = false,
        theme = "auto",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { worktree, { "branch", fmt = trunc(120, 7, 60) }, { "filename", path = 4 } },
        lualine_c = { diff, diagnostics },
        lualine_x = {
          { "encoding", fmt = trunc(100, 50, 120) },
          { "fileformat", fmt = trunc(100, 50, 120) },
          { "filetype", fmt = trunc(100, 50, 120) },
          { "filesize", fmt = trunc(100, 50, 120) },
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "filetype", "location" },
        lualine_y = {},
        lualine_z = {},
      },
    })
  end,
}
