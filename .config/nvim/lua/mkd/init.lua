require("mkd.lsp")
require("mkd.tmux")
require("mkd.tree-sitter")
require("mkd.diffview")
require("mkd.telescope")

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
