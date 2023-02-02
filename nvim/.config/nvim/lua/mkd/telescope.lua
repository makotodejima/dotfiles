local actions = require "telescope.actions"

require("telescope").setup {
  defaults = {
    prompt_prefix = "  ",
    mappings = { i = { ["<C-q>"] = actions.send_selected_to_qflist, ["<C-a>"] = actions.send_to_qflist } },
    layout_strategy = "vertical",
    layout_config = { vertical = { width = 0.9, height = 0.96, preview_height = 0.65 } },
    file_ignore_patterns = { "^.git/", "node_modules", "undodir" },
    vimgrep_arguments = {
      "rg",
      "--fixed-strings",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
    },
  },
  pickers = {
    find_files = {
      hidden = true,
    },
    buffers = {
      ignore_current_buffer = true,
      sort_mru = true,
      mappings = { i = { ["<c-d>"] = "delete_buffer" } },
    },
    live_grep = {
      glob_pattern = "!*lock.json",
    },
  },
}

require("telescope").load_extension "fzf"
require("telescope").load_extension "neoclip"
require("telescope").load_extension "dap"
require("telescope").load_extension "git_worktree"
require("telescope").load_extension "harpoon"

vim.api.nvim_set_keymap("n", "<C-t>", ":Telescope <CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap(
  "n",
  "<leader>co",
  [[<cmd>lua require'telescope.builtin'.find_files({cwd='~/.dotfiles',hidden=true})<CR>]],
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap("n", "<C-p>", ":Telescope git_files<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-b>", ":Telescope buffers<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>fg", ":Telescope live_grep<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap(
  "n",
  "<leader>rr",
  [[<cmd>lua require('telescope').extensions.neoclip.default()<CR>]],
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>gwt",
  [[<cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<CR>]],
  { noremap = true, silent = true }
)

-- note
vim.api.nvim_set_keymap(
  "n",
  "<leader>no",
  [[<cmd>lua require'telescope.builtin'.find_files({cwd='~/Library/Mobile Documents/27N4MQEA55~pro~writer/Documents/temp'})<CR>]],
  { noremap = true, silent = true }
)
