local actions = require "telescope.actions"
local fb_actions = require "telescope._extensions.file_browser.actions"

require("telescope").setup {
  defaults = {
    prompt_prefix = "  ",
    mappings = { i = { ["<C-q>"] = actions.send_selected_to_qflist,["<C-a>"] = actions.send_to_qflist } },
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
      glob_pattern = { "!*lock.json", "!*.lock" },
      additional_args = { "--hidden" },
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,                   -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true,    -- override the file sorter
      case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    },
    media_files = {
      -- filetypes whitelist
      -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
      filetypes = { "png", "webp", "jpg", "jpeg", "svg" },
      -- find command (defaults to `fd`)
      find_cmd = "rg",
    },
    file_browser = {
      hidden = true,
      dir_icon = "📁",
      mappings = {
        ["i"] = {
          ["µ"] = fb_actions.move,
          ["ç"] = fb_actions.copy,
          ["∂"] = fb_actions.remove,
          ["-"] = fb_actions.goto_parent_dir,
        },
      },
    },
    advanced_git_search = {
      -- fugitive or diffview
      diff_plugin = "fugitive",
      -- customize git in previewer
      -- e.g. flags such as { "--no-pager" }, or { "-c", "delta.side-by-side=false" }
      git_flags = {},
      -- customize git diff in previewer
      -- e.g. flags such as { "--raw" }
      git_diff_flags = {},
      -- Show builtin git pickers when executing "show_custom_functions" or :AdvancedGitSearch
      show_builtin_git_pickers = false,
    }
  },
}

require("telescope").load_extension "fzf"
-- require("telescope").load_extension "neoclip"
require("telescope").load_extension "dap"
require("telescope").load_extension "git_worktree"
require("telescope").load_extension "harpoon"
require("telescope").load_extension "media_files"
require("telescope").load_extension "file_browser"
require("telescope").load_extension "advanced_git_search"
-- require('telescope').load_extension('macros')

vim.keymap.set("n", "<C-t>", ":Telescope <CR>", { noremap = true, silent = true })
vim.keymap.set(
  "n",
  "<leader>co",
  [[<cmd>lua require'telescope.builtin'.find_files({cwd='~/.dotfiles',hidden=true})<CR>]],
  { noremap = true, silent = true }
)
vim.keymap.set("n", "<C-p>", ":Telescope find_files<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-b>", ":Telescope buffers<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-c>", ":Telescope commands<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-g>", ":Telescope live_grep<CR>", { noremap = true, silent = true })
vim.keymap.set(
  "n",
  "<leader>rr",
  [[<cmd>lua require('telescope').extensions.neoclip.default()<CR>]],
  { noremap = true, silent = true }
)
vim.keymap.set(
  "v",
  "<leader>rr",
  "<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
  { noremap = true }
)

-- worktree
vim.keymap.set(
  "n",
  "<leader>gwt",
  [[<cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<CR>]],
  { noremap = true, silent = true }
)

-- note
vim.keymap.set(
  "n",
  "<leader>no",
  [[<cmd>lua require'telescope.builtin'.find_files({cwd='~/Library/Mobile Documents/27N4MQEA55~pro~writer/Documents/temp'})<CR>]],
  { noremap = true, silent = true }
)
