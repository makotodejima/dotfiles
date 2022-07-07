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
require("nvim-gps").setup {disable_icons = true} -- context in status bar
require("yanky").setup({
 highlight = {
    on_put = true,
    on_yank = true,
    timer = 20,
  },
})

vim.api.nvim_set_keymap("n", "<leader>rp", ":lua require('refactoring').debug.printf({below = false})<CR>", {noremap = true})
vim.api.nvim_set_keymap("v", "<leader>rv", ":lua require('refactoring').debug.print_var({})<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>rc", ":lua require('refactoring').debug.cleanup({})<CR>", { noremap = true })

vim.keymap.set("n", "p", "<Plug>(YankyPutAfter)", {})
vim.keymap.set("n", "P", "<Plug>(YankyPutBefore)", {})
vim.keymap.set("x", "p", "<Plug>(YankyPutAfter)", {})
vim.keymap.set("x", "P", "<Plug>(YankyPutBefore)", {})
-- vim.keymap.set("n", "gp", "<Plug>(YankyGPutAfter)", {})
-- vim.keymap.set("n", "gP", "<Plug>(YankyGPutBefore)", {})
-- vim.keymap.set("x", "gp", "<Plug>(YankyGPutAfter)", {})
-- vim.keymap.set("x", "gP", "<Plug>(YankyGPutBefore)", {})
vim.api.nvim_set_keymap("n", "<c-n>", "<Plug>(YankyCycleForward)", {})
-- vim.api.nvim_set_keymap("n", "<c-p>", "<Plug>(YankyCycleBackward)", {})

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
