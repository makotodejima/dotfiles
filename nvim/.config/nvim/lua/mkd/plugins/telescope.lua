return {
  "nvim-telescope/telescope.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-lua/popup.nvim",
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
  },
  config = function()
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
          glob_pattern = { "!*lock.json", "!*.lock" },
          additional_args = { "--hidden" },
        },
      },
      extensions = {
        fzf = {
          fuzzy = true, -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true, -- override the file sorter
          case_mode = "smart_case", -- or "ignore_case" or "respect_case"
        },
      },
    }

    require("telescope").load_extension "fzf"
    require("telescope").load_extension "harpoon"

    vim.keymap.set("n", "<C-t>", ":Telescope <CR>", { noremap = true, silent = true })
    vim.keymap.set(
      "n",
      "<leader>co",
      [[<cmd>lua require'telescope.builtin'.find_files({cwd='~/.dotfiles',hidden=true})<CR>]],
      { noremap = true, silent = true }
    )
    vim.keymap.set("n", "<C-p>", ":Telescope find_files<CR>", { noremap = true, silent = true })
    vim.keymap.set("n", "<C-b>", ":Telescope buffers<CR>", { noremap = true, silent = true })
    vim.keymap.set("n", "<C-c>", ":Telescope commands<CR>", { noremap = true, silent = true })
    vim.keymap.set("n", "<C-_>", ":Telescope current_buffer_fuzzy_find<CR>", { noremap = true, silent = true })
    vim.keymap.set("n", "<C-g>", require("mkd.telescope.multigrep").run, { noremap = true, silent = true })

    -- note
    vim.keymap.set(
      "n",
      "<leader>no",
      [[<cmd>lua require'telescope.builtin'.find_files({cwd=os.getenv("IA_TEMP_PATH")})<CR>]],
      { noremap = true, silent = true }
    )
  end,
}
