function Color()
  vim.opt.background = "dark"

  local hl = function(thing, opts)
    vim.api.nvim_set_hl(0, thing, opts)
  end

  hl("Sneak", { fg = "#002335", bg = "#FFD5D1" })
  hl("MatchParen", { bold = true, underline = true })
  hl("TreesitterContext", { fg = "#ffffff", bg = "#2a2f37" })
  hl("NormalFloat", { bg = "#2a2f37" })
  hl("diffAdded", { fg = "#32A0B4", bg = "#28383c" })
  hl("diffRemoved", { fg = "#B40000", bg = "#28383c" })
  hl("diffLine", { fg = "#a2926c" })
  hl("diffNoEOL", { fg = "#a2926c" })
end

Color()
