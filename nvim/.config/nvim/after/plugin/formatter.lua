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

    sh = {
      require("formatter.filetypes.sh").shfmt,
    },

    typescript = {
      require("formatter.filetypes.typescript").eslint_d,
      require("formatter.filetypes.typescript").prettier,
    },

    typescriptreact = {
      require("formatter.filetypes.typescriptreact").eslint_d,
      require("formatter.filetypes.typescriptreact").prettier,
    },

    rust = {
      require("formatter.filetypes.rust").rustfmt,
    },

    terraform = {
      require("formatter.filetypes.terraform").terraformfmt,
    },

    yaml = {
      require("formatter.filetypes.yaml").prettier,
    },

    graphql = {
      require("formatter.filetypes.graphql").prettier,
    },

    json = {
      require("formatter.filetypes.json").prettier,
    },

    html = {
      require("formatter.filetypes.html").prettier,
    },

    css = {
      require("formatter.filetypes.css").eslint_d,
      require("formatter.filetypes.css").prettier,
    },

    markdown = {
      require("formatter.filetypes.markdown").prettier,
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
