vim.pack.add({
  "https://github.com/stevearc/conform.nvim",
}, {
  confirm = false,
  -- Temporary while lazy.nvim still owns startup: it sources plugin scripts
  -- from these runtime paths. Change this to true at the final cutover.
  load = false,
})

require("conform").setup({
  -- log_level = vim.log.levels.DEBUG,
  formatters_by_ft = {
    css = { "prettier" },
    go = { "gofumpt" },
    graphql = { "prettier" },
    html = { "prettier" },
    javascript = { "prettier" },
    json = { "prettier" },
    lua = { "stylua" },
    markdown = { "deno_fmt" },
    python = { "black" },
    rust = { "rustfmt" },
    sh = { "shfmt" },
    sql = { "pg_format" },
    swift = { "swift" },
    terraform = { "terraform_fmt" },
    typescript = { "prettier" },
    typescriptreact = { "prettier" },
    yaml = { "prettier" },
    zsh = { "shfmt" },
  },
  formatters = {
    shfmt = {
      prepend_args = { "--indent", 2 },
    },
    rustfmt = {
      prepend_args = { "--config", "tab_spaces=2" },
    },
    stylua = {
      prepend_args = { "--config-path", vim.fn.expand("~/.config/nvim/lua/mkd/stylua.toml") },
    },
  },
})

-- lazy.nvim expects every imported module to return a table of specs. This
-- plugin is now owned by vim.pack, so this module contributes none.
return {}
