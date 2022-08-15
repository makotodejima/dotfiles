local null_ls = require('null-ls')

null_ls.setup({
  debug = true,
  sources = {
    null_ls.builtins.formatting.terraform_fmt,
    -- null_ls.builtins.formatting.prettierd,
    -- null_ls.builtins.formatting.eslint_d,
    -- null_ls.builtins.diagnostics.eslint_d
    --     .with({prefer_local = "node_modules/.bin", timeout = 30000}),
    -- null_ls.builtins.diagnostics.cspell,
    null_ls.builtins.diagnostics.cspell.with({
      method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
      disabled_filetypes = {"vim", "lua"},
      extra_args = {"--config", vim.fn.expand("~/.config/nvim/lua/mkd/null-ls/cspell.json")},
      diagnostics_postprocess = function(diagnostic)
        diagnostic.severity = vim.diagnostic.severity.INFO
      end
    })

  }
})

-- local prettier_eslint = {
--   method = null_ls.methods.FORMATTING,
--   filetypes = {"typescript"},
--   generator = null_ls.generator({
--     command = "prettier-eslint",
--     args = {"--stdin", "--stdin-filepath", "$FILENAME"},
--     to_stdin = true,
--     from_stderr = true
--     -- choose an output format (raw, json, or line)
--     -- format = "json",
--   })
-- }

-- null_ls.register(prettier_eslint)
