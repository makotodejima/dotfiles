local lualine = require "lualine"

local function path()
  local sep = "/"
  local subs = {}
  for str in string.gmatch(vim.fn.expand "%", "([^" .. sep .. "]+)") do
    table.insert(subs, str)
  end

  local str = ""
  if #subs < 3 then
    for i, level in ipairs(subs) do
      local parent = str
      if i == 1 then
        str = level
      else
        str = parent .. sep .. level
      end
    end
    return str
  end

  for i, level in ipairs(subs) do
    local parent = str
    if i == 1 then
      str = string.sub(level, 0, 2)
    elseif i < #subs - 3 then
      str = parent .. sep .. string.sub(level, 0, 2)
    elseif i < #subs - 1 then
      str = parent .. sep .. string.sub(level, 0, 3)
    else
      str = parent .. sep .. level
    end
  end
  return str
end

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

local function get_file_name(file)
  return file:match "^.+/(.+)$"
end

local harpoon = require "harpoon"
local function harpoon_marks()
  local str = ""
  for i, entry in ipairs(harpoon.get_mark_config().marks) do
    str = str .. "[" .. i .. "]" .. get_file_name(entry["filename"]) .. " "
  end
  return str == "" and "-" or str
end

lualine.setup {
  options = {
    icons_enabled = false,
    theme = "auto",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = { winbar = { "qf", "netrw", "fugitive" } },
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", path },
    lualine_c = { diff, diagnostics },
    lualine_x = { "encoding", "fileformat", "filetype", "filesize" },
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
  -- winbar = { lualine_a = { { harpoon_marks, color = { fg = "white", bg = "#292c36" } } } },
  -- inactive_winbar = {
  --   lualine_a = { { "filename", "filetype", "filesize", color = { fg = "grey", bg = "none" } } },
  -- },
}
