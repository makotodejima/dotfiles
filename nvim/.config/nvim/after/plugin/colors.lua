function Color()
  vim.opt.background = "dark"

  vim.cmd("colorscheme " .. "gruvbit")
  -- vim.cmd("colorscheme " .. "elly")
  -- vim.cmd("colorscheme " .. "rose-pine")

  local hl = function(thing, opts)
    vim.api.nvim_set_hl(0, thing, opts)
  end

  hl("CursorLine", {
    bg = "none",
  })

  hl("Sneak", {
    fg = "#002335",
    bg = "#FFD5D1"
  })

  hl("MatchParen", {
    bold = true,
    underline = true,
  })

  hl("netrwDir", {
    fg = "#b2c6d4"
  })

end

Color()
