vim.g.mapleader = " "

-- Save and quit
vim.keymap.set("n", "<leader>w", ":up")
vim.keymap.set("n", "<leader>q", ":q")
vim.keymap.set("n", "<leader>wq", ":wq")

-- Remove last highlight
vim.keymap.set("n", "<leader>l", "<cmd>noh<cr>")

-- Quickfixlist
vim.keymap.set("n", "]q", ":cnext<CR>zz")
vim.keymap.set("n", "[q", ":cprev<CR>zz")
vim.keymap.set("n", "[Q", ":<C-u>cfirst<CR>zz")
vim.keymap.set("n", "]Q", ":<C-u>clast<CR>zz")

-- Move line up/down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Select same lines after >ed
vim.keymap.set("v", ">>", ">gv")
vim.keymap.set("v", "<<", "<gv")

vim.keymap.set("n", "Y", "y$")

vim.keymap.set("i", ",", ",<C-g>u")
vim.keymap.set("i", ".", ".<C-g>u")

vim.keymap.set("n", "<leader>yy", [["+yy]])
vim.keymap.set("n", "<leader>Y", [["+y$]])
vim.keymap.set("v", "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>p", [["+p]])
vim.keymap.set("v", "<leader>p", [["+p]])
vim.keymap.set("v", "<leader>jp", [["_dP]])

vim.keymap.set("v", "<leader>s", ":sort<CR>")

vim.keymap.set("n", "<leader>vs", ":vsplit<CR>")

vim.keymap.set("n", "<leader>b", ":ls<CR> :b # <CR>")

vim.keymap.set("n", "<leader>cp", ":let @+ = expand('%')<CR>")

-- undotree
vim.keymap.set("n", "<leader>u", ":UndotreeToggle<CR>")

vim.g.markdown_fenced_languages = { "html", "python", "javascript", "bash=sh" }

-- How do i do this?
-- " Jest file pattern matching 'test.db'
-- let g:test#javascript#jest#file_pattern = '\v(__tests__/.*|(spec|test|test.db))\.(js|jsx|ts|tsx)$'
-- let test#neovim#term_position = "vert"

vim.keymap.set("n", "<leader>tn", [[:lua require"jester".run({path_to_jest='./node_modules/jest/bin/jest.js'})<CR>]])
vim.keymap.set(
  "n",
  "<leader>tf",
  [[:lua require"jester".run_file({path_to_jest='./node_modules/jest/bin/jest.js'})<CR>]]
)

vim.keymap.set("t", "<C-o>", [[<C-\><C-n>]])

-- harpoon man
vim.keymap.set("n", "<leader>hh", [[:lua require("harpoon.mark").add_file()<CR>]])
vim.keymap.set("n", "<leader>a", [[:lua require("harpoon.ui").nav_file(1)<CR>]])
vim.keymap.set("n", "<leader>s", [[:lua require("harpoon.ui").nav_file(2)<CR>]])
vim.keymap.set("n", "<leader>d", [[:lua require("harpoon.ui").nav_file(3)<CR>]])
vim.keymap.set("n", "<leader>hl", [[:lua require("harpoon.ui").toggle_quick_menu()<CR>]])

-- refactoring.nvim
vim.api.nvim_set_keymap(
  "n",
  "<leader>rp",
  ":lua require('refactoring').debug.printf({below = false})<CR>",
  { noremap = true }
)
vim.keymap.set("v", "<leader>rp", ":lua require('refactoring').debug.print_var({})<CR>", { noremap = true })
vim.keymap.set("n", "<leader>rc", ":lua require('refactoring').debug.cleanup({})<CR>", { noremap = true })

-- yanky
vim.keymap.set("n", "p", "<Plug>(YankyPutAfter)", {})
vim.keymap.set("n", "P", "<Plug>(YankyPutBefore)", {})
vim.keymap.set("x", "p", "<Plug>(YankyPutAfter)", {})
vim.keymap.set("x", "P", "<Plug>(YankyPutBefore)", {})
vim.keymap.set("n", "<c-n>", "<Plug>(YankyCycleForward)", {})

-- vim.keymap.set("n", "<leader><space>", ":lua vim.lsp.buf.format()<CR>")
vim.keymap.set("n", "<leader><space>", ":Format<CR>")
vim.keymap.set("v", "<leader>ss", ":lua require 'mkd.null-ls.cspell_util'.add_selection()<CR>")

-- can do copy/move files
vim.keymap.set("n", "<leader>ff", ":Telescope file_browser<CR>")

-- git advanced search
vim.keymap.set("n", "<leader>ga", ":AdvancedGitSearch<CR>")

-- consider rempap for :Gclog :%Gclog
