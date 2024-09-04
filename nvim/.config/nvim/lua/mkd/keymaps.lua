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

vim.keymap.set("n", "<leader>cp", ":let @+ = expand('%')<CR>")

vim.keymap.set("t", "<C-o>", [[<C-\><C-n>]])

vim.keymap.set("n", "<leader>f", ":lua vim.lsp.buf.format()<CR>")

-- consider rempap for :Gclog :%Gclog

vim.keymap.set("n", "[t", function()
  require("treesitter-context").go_to_context(vim.v.count1)
end, { silent = false })
