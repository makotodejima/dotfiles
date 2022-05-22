local function path()
  local sep = "/"
  local subs = {}
  for str in string.gmatch(vim.fn.expand('%'), "([^" .. sep .. "]+)") do table.insert(subs, str) end

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
    elseif i < #subs - 1 then
      str = parent .. sep .. string.sub(level, 0, 2)
    else
      str = parent .. sep .. level
    end
  end
  return str
end

local components = require("mkd.lsp-status")

local diagnostics = {
  'diagnostics',
  sources = {'nvim_lsp'},
  sections = {'error', 'warn', 'info', 'hint'},
  symbols = {error = 'E', warn = 'W', info = 'I', hint = 'H'},
  colored = true,
  update_in_insert = false,
  always_visible = false
}

local diff = {
  'diff',
  colored = true,
  diff_color = {added = {fg = '#32A0B4'}, modified = {fg = '#E6B450'}, removed = {fg = '#B40000'}},
  symbols = {added = '+', modified = '~', removed = '-'}
}

local lualine = require('lualine')
local gps = require('nvim-gps')

lualine.setup {
  options = {
    icons_enabled = false,
    theme = 'auto',
    component_separators = {left = '', right = ''},
    section_separators = {left = '', right = ''},
    disabled_filetypes = {}
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', path},
    lualine_c = {diff, diagnostics, {gps.get_location, cond = gps.is_available}},
    lualine_x = {'encoding', 'fileformat', 'filetype', 'filesize'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'filetype', 'location'},
    lualine_y = {},
    lualine_z = {}
  },
  extensions = {}
}
