return {
  "stevearc/conform.nvim",
  event = "VeryLazy",
  config = function()
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
        markdown = { "prettier" },
        python = { "black" },
        rust = { "rustfmt" },
        sh = { "shfmt" },
        sql = { "pg_format" },
        swift = { "swiftformat" },
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
  end,
}
