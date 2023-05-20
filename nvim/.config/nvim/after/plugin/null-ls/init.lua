local null_ls = require "null-ls"

null_ls.setup {
  debug = true,
  sources = {
    -- diagnostics
    null_ls.builtins.diagnostics.eslint_d,
    null_ls.builtins.diagnostics.cspell.with {
      method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
      disabled_filetypes = { "vim", "lua", "netrw" },
      extra_args = { "--config", vim.fn.expand "~/.config/nvim/lua/mkd/null-ls/cspell.json" },
      diagnostics_postprocess = function(diagnostic)
        diagnostic.severity = vim.diagnostic.severity.INFO
      end,
    },
    -- formatting
    null_ls.builtins.formatting.jq,
    null_ls.builtins.formatting.terraform_fmt,
    null_ls.builtins.formatting.eslint_d.with {
      timeout = 30000,
    },
    null_ls.builtins.formatting.rustfmt,
    null_ls.builtins.formatting.pg_format,
    null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.stylua.with {
      extra_args = { "--config-path", vim.fn.expand "~/.config/nvim/lua/mkd/null-ls/stylua.toml" },
    },
    null_ls.builtins.formatting.prettier.with { prefer_local = "node_modules/.bin", timeout = 30000 },
  },
}