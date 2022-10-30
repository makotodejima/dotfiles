local null_ls = require('null-ls')

null_ls.setup({
  -- debug = true,
  sources = {
    null_ls.builtins.formatting.terraform_fmt,
    null_ls.builtins.formatting.jq,
    null_ls.builtins.formatting.prettier
        .with({ prefer_local = "node_modules/.bin", timeout = 30000 }),
    null_ls.builtins.diagnostics.cspell.with({
      method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
      disabled_filetypes = { "vim", "lua", "netrw" },
      extra_args = { "--config", vim.fn.expand("~/.config/nvim/lua/mkd/null-ls/cspell.json") },
      diagnostics_postprocess = function(diagnostic)
        diagnostic.severity = vim.diagnostic.severity.INFO
      end
    })
  }
})
