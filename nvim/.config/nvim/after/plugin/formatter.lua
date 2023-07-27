local util = require "formatter.util"

-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
require("formatter").setup {
  -- logging = true,
  log_level = vim.log.levels.WARN,
  filetype = {
    -- Formatter configurations for filetype "lua" go here
    -- and will be executed in order
    -- lua = {
    --   -- "formatter.filetypes.lua" defines default configurations for the
    --   -- "lua" filetype
    --   require("formatter.filetypes.lua").stylua,
    -- },
    --
    typescript = {
      require("formatter.filetypes.typescript").eslint_d,
      require("formatter.filetypes.typescript").prettier,
    },

    typescriptreact = {
      require("formatter.filetypes.typescriptreact").eslint_d,
      require("formatter.filetypes.typescriptreact").prettier,
    },

    graphql = {
      require("formatter.filetypes.graphql").prettier,
    },

    json = {
      require("formatter.filetypes.json").prettier,
    },

    -- Use the special "*" filetype for defining formatter configurations on
    -- any filetype
    -- ["*"] = {
    --   -- "formatter.filetypes.any" defines default configurations for any
    --   -- filetype
    --   require("formatter.filetypes.any").remove_trailing_whitespace,
    -- },
  },
}
