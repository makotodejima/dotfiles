require("mkd.diffview")
require("mkd.efm")
require("mkd.lsp")
require("mkd.lualine")
require("mkd.null-ls")
require("mkd.telescope")
require("mkd.tmux")
require("mkd.tree-sitter")
require("mkd.dap")

require('neoclip').setup()
require('marks').setup {}
require("fidget").setup {}
require("nvim-gps").setup {disable_icons = true}

P = function(v)
  print(vim.inspect(v))
  return v
end

if pcall(require, 'plenary') then
  RELOAD = require('plenary.reload').reload_module

  R = function(name)
    RELOAD(name)
    return require(name)
  end
end
