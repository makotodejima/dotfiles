return {
  "kristijanhusak/vim-dadbod-ui",
  dependencies = {
    { "tpope/vim-dadbod", lazy = true },
    -- { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
  },
  cmd = {
    "DBUI",
    "DBUIToggle",
    "DBUIAddConnection",
    "DBUIFindBuffer",
  },
  init = function()
    vim.g.dbs = {
      { name = "dev", url = "mongodb://localhost:3001/meteor" },
      { name = "spater", url = "sqlite:spater.db" },
    }
    vim.g.db_ui_use_nerd_fonts = 1
  end,
}
