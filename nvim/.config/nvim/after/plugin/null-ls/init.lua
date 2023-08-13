local null_ls = require "null-ls"

null_ls.setup {
  -- debug = true,
  sources = {
    -- diagnostics
    -- null_ls.builtins.diagnostics.cspell.with {
    --   method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
    --   disabled_filetypes = { "vim", "lua", "netrw" },
    --   extra_args = { "--config", vim.fn.expand "~/.config/nvim/lua/mkd/null-ls/cspell.json" },
    --   diagnostics_postprocess = function(diagnostic)
    --     diagnostic.severity = vim.diagnostic.severity.INFO
    --   end,
    -- },
  },
}
