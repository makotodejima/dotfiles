return {
  {
    dir = "~/dev/bob",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme bob]])
    end,
  },
  -- {
  --   "m4xshen/hardtime.nvim",
  --   event = { "BufReadPre", "BufNewFile" },
  --   dependencies = { "MunifTanjim/nui.nvim" },
  --   opts = { max_count = 10 },
  -- },
  -- {
  --   dir = "~/dev/mrkdwn.nvim",
  --   opts = {},
  --   ft = { "markdown", "codecompanion" },
  -- },
  {
    "brenoprata10/nvim-highlight-colors",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      enable_tailwind = false,
    },
  },
  {
    "tpope/vim-surround",
    event = { "BufReadPre", "BufNewFile" },
  },
  -- "tpope/vim-repeat",
  "tpope/vim-vinegar",
  -- { "tpope/vim-unimpaired", event = "VeryLazy" },
  -- "tpope/vim-sleuth",

  -- navigation
  {
    "aserowy/tmux.nvim",
    event = "VeryLazy",
    config = function()
      require("tmux").setup({
        copy_sync = {
          -- enables copy sync and overwrites all register actions to
          -- sync registers *, +, unnamed, and 0 till 9 from tmux in advance
          enable = false,
        },
        navigation = { enable_default_keybindings = true },
        resize = { enable_default_keybindings = true, resize_step_x = 4, resize_step_y = 4 },
      })
    end,
  },

  -- files
  {
    "mbbill/undotree",
    cmd = { "UndotreeToggle" },
    keys = {
      { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Undotree" },
    },
  },
  {
    "stevearc/oil.nvim",
    cmd = { "Oil" },
    config = function()
      require("oil").setup({
        default_file_explorer = false,
        view_options = {
          show_hidden = true,
        },
      })
    end,
  },

  -- util
  {
    "gbprod/yanky.nvim",
    event = "VeryLazy",
    config = function()
      require("yanky").setup({
        ring = {
          storage = "shada",
        },
        highlight = {
          on_put = true,
          on_yank = false,
          timer = 55,
        },
      })

      vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
      vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
      vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
      vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")
      vim.keymap.set("n", "<c-n>", "<Plug>(YankyPreviousEntry)")
      -- vim.keymap.set("n", "<c-n>", "<Plug>(YankyNextEntry)")
    end,
  },
  --
  -- {
  --   "lukas-reineke/indent-blankline.nvim",
  --   version = "2.20.8",
  --   ft = { "python", "yaml", "toml" },
  --   config = function()
  --     require("indent_blankline").setup({
  --       filetype = { "python", "yaml", "toml" },
  --     })
  --   end,
  -- },
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    config = function()
      require("Comment").setup({
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      })
      vim.g.skip_ts_context_commentstring_module = true
    end,
  },
  {
    "toppair/peek.nvim",
    cmd = { "PeekOpen" },
    build = "deno task --quiet build:fast",
    config = function()
      require("peek").setup()
      -- refer to `configuration to change defaults`
      vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
      vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
    end,
  },
  { "j-hui/fidget.nvim", event = "VeryLazy", opts = {} },
  {
    "folke/snacks.nvim",
    event = "VeryLazy",
    opts = {
      image = { enabled = true, doc = { enabled = false } },
      bigfile = { enabled = true },
    },
  },
}
