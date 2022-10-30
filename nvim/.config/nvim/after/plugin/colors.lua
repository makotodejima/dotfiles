function Color()
  vim.opt.background = "dark"

  -- vim.cmd("colorscheme " .. "gruvbit")
  vim.cmd("colorscheme " .. "elly")

  local hl = function(thing, opts)
    vim.api.nvim_set_hl(0, thing, opts)
  end

  hl("CursorLine", {
    bg = "none",
  })

  hl("ColorColumn", {
    ctermbg = 0,
    bg = "#2B79A0",
  })

  hl("Sneak", {
    fg = "#002335",
    bg = "#FFD5D1"
  })

  -- hl("Normal", {
  --   bg = "none"
  -- })

  hl("netrwDir", {
    fg = "#e6cca3"
  })

end

Color()
