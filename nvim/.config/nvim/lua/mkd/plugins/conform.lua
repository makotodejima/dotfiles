return {
  "stevearc/conform.nvim",
  config = function()
    local util = require "conform.util"
    require("conform").setup {
      log_level = vim.log.levels.DEBUG,
      formatters_by_ft = {
        sh = { "shfmt" },
        zsh = { "shfmt" },
        lua = { "stylua" },
        javascript = { "eslint_d", "prettier" },
        typescript = { "eslint_d", "prettier" },
        typescriptreact = { "eslint_d", "prettier" },
        rust = { "rustfmt" },
        python = { "black" },
        terraform = { "terraform_fmt" },
        html = { "prettier" },
        yaml = { "prettier" },
        graphql = { "prettier" },
        json = { "prettier" },
        css = { "eslint_d", "prettier" },
        markdown = { "prettier" },
      },
      formatters = {
        shfmt = {
          prepend_args = { "--indent", 2 },
        },
        rustfmt = {
          prepend_args = { "--config", "tab_spaces=2" },
        },
        stylua = {
          prepend_args = { "--config-path", vim.fn.expand "~/.config/nvim/lua/mkd/stylua.toml" },
        },
      },
    }
  end,
}
