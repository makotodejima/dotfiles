function! LualineFilename()
  let name = ""
  let subs = split(expand('%'), "/")
  let i = 1
  for s in subs
    let parent = name
    if  i == len(subs)
      let name = parent . '/' . s
    elseif i == len(subs) - 1
      let name = parent . '/' . s
    else
      let name = parent . '/' . strpart(s, 0, 2)
    endif
    let i += 1
  endfor
  return name
endfunction

lua << EOF
local function lsp_info()
    local warnings = vim.lsp.diagnostic.get_count(0, "Warning")
    local errors = vim.lsp.diagnostic.get_count(0, "Error")
    local hints = vim.lsp.diagnostic.get_count(0, "Hint")
    return string.format("LSP: H %d W %d E %d", hints, warnings, errors)
end

require'lualine'.setup {
  options = {
    icons_enabled = false,
    theme = 'auto',
    component_separators = {'|', '|'},
    section_separators = {'', ''},
    disabled_filetypes = {}
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'LualineFilename'},
    lualine_c = {
      {
        'diff',
        colored = true,
        color_added = '#ADF0CD',
        color_modified = '#E6B450',
        color_removed = '#B40000',
        symbols = {added = '+', modified = '~', removed = '-'}
      },
      lsp_info
    },
    lualine_x = {'encoding', 'fileformat', 'filetype'},
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
EOF
