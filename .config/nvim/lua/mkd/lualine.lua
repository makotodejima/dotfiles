local function lsp_info()
  local warnings = vim.lsp.diagnostic.get_count(0, "Warning")
  local errors = vim.lsp.diagnostic.get_count(0, "Error")
  local hints = vim.lsp.diagnostic.get_count(0, "Hint")
  return string.format("LSP: H %d W %d E %d", hints, warnings, errors)
end

local function path()
  local sep = "/"
  local subs = {}
  for str in string.gmatch(vim.fn.expand('%'), "([^" .. sep .. "]+)") do table.insert(subs, str) end

  local name = ""
  for i, level in ipairs(subs) do
    local parent = name
    if i == 1 then
      name = string.sub(level, 0, 2)
    elseif i < #subs - 1 then
      name = parent .. "/" .. string.sub(level, 0, 2)
    else
      name = parent .. "/" .. level
    end
  end
  return name
end

local components = require("mkd.lsp-status")

require'lualine'.setup {
  options = {
    icons_enabled = false,
    theme = 'auto',
    component_separators = {left = '', right =  ''},
    section_separators = {left = '', right =  ''},
    disabled_filetypes = {}
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', path},
    lualine_c = {
      {
        'diff',
        colored = true,
        diff_color = {
          added = {fg = '#32A0B4'},
          modified = {fg = '#E6B450'},
          removed = {fg = '#B40000'}
        },
        symbols = {added = '+', modified = '~', removed = '-'}
      }, lsp_info, components.lsp_status
    },
    lualine_x = {'encoding', 'fileformat', 'filetype', 'filesize'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  extensions = {}
}
