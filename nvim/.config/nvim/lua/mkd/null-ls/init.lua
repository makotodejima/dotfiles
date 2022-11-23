local null_ls = require "null-ls"

local opt = { noremap = true, silent = false }
vim.keymap.set("n", "<leader><space>", ":lua vim.lsp.buf.format()<CR>", opt)
vim.keymap.set("v", "<leader>ss", ":lua require 'mkd.null-ls.cspell_util'.add_selection()<CR>", opt)

null_ls.setup {
  -- debug = true,
  sources = {
    -- null_ls.builtins.diagnostics.pylint,
    null_ls.builtins.formatting.terraform_fmt,
    null_ls.builtins.formatting.jq,
    null_ls.builtins.diagnostics.eslint_d,
    null_ls.builtins.formatting.eslint_d,
    null_ls.builtins.formatting.rustfmt,
    null_ls.builtins.formatting.pg_format,
    null_ls.builtins.formatting.stylua.with {
      extra_args = { "--config-path", vim.fn.expand "~/.config/nvim/lua/mkd/null-ls/stylua.toml" },
    },
    null_ls.builtins.formatting.prettier.with { prefer_local = "node_modules/.bin", timeout = 30000 },
    null_ls.builtins.diagnostics.cspell.with {
      method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
      disabled_filetypes = { "vim", "lua", "netrw" },
      extra_args = { "--config", vim.fn.expand "~/.config/nvim/lua/mkd/null-ls/cspell.json" },
      diagnostics_postprocess = function(diagnostic)
        diagnostic.severity = vim.diagnostic.severity.INFO
      end,
    },
  },
}
