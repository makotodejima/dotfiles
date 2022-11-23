require "mkd.cmp"
require "mkd.diffview"
require "mkd.lsp"
require "mkd.lualine"
require "mkd.null-ls"
require "mkd.null-ls.cspell_util"
require "mkd.telescope"
require "mkd.tmux"
require "mkd.tree-sitter"
require "mkd.dap"
require "mkd.git"
require "mkd.compiler"

require("neoclip").setup()
require("marks").setup {}
require("fidget").setup {}
require("colorizer").setup()
require("Comment").setup {
  pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
}
require("todo-comments").setup { signs = false, highlight = { keyword = "bg" } }
require("yanky").setup { highlight = { on_put = true, on_yank = true, timer = 10 } }

require("nvim-tree").setup {
  hijack_netrw = false,
  sort_by = "name",
  view = {
    adaptive_size = false,
    centralize_selection = false,
    width = 50,
    mappings = {
      custom_only = false,
      list = {
        -- user mappings go here
      },
    },
  },
  renderer = {
    highlight_git = false,
    icons = {
      webdev_colors = false,
      git_placement = "before",
      padding = " ",
      symlink_arrow = " ➛ ",
      show = { file = false, folder = false, folder_arrow = false, git = false },
      glyphs = { default = "", symlink = "@", bookmark = "B" },
    },
    symlink_destination = true,
  },
  hijack_directories = { enable = true, auto_open = true },
}

vim.api.nvim_set_keymap(
  "n",
  "<leader>rp",
  ":lua require('refactoring').debug.printf({below = false})<CR>",
  { noremap = true }
)
vim.keymap.set("v", "<leader>rv", ":lua require('refactoring').debug.print_var({})<CR>", { noremap = true })
vim.keymap.set("n", "<leader>rc", ":lua require('refactoring').debug.cleanup({})<CR>", { noremap = true })

vim.keymap.set("n", "p", "<Plug>(YankyPutAfter)", {})
vim.keymap.set("n", "P", "<Plug>(YankyPutBefore)", {})
vim.keymap.set("x", "p", "<Plug>(YankyPutAfter)", {})
vim.keymap.set("x", "P", "<Plug>(YankyPutBefore)", {})
vim.keymap.set("n", "<c-n>", "<Plug>(YankyCycleForward)", {})
-- vim.api.nvim_set_keymap("n", "<c-p>", "<Plug>(YankyCycleBackward)", {})
