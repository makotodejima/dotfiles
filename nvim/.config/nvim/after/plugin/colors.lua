function Color()
  vim.opt.background = "dark"

  local hl = function(thing, opts)
    vim.api.nvim_set_hl(0, thing, opts)
  end

  hl("Sneak", { fg = "#002335", bg = "#FFD5D1" })
  hl("MatchParen", { bold = true, underline = true })
  hl("TreesitterContext", { fg = "#ffffff", bg = "#2a2f37" })
  hl("NormalFloat", { bg = "#2a2f37" })
end

Color()
