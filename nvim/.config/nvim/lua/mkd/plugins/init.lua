return {
  -- color
  {
    dir = "~/dev/bob",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd [[colorscheme bob]]
    end,
  },
  -- {
  --   "brenoprata10/nvim-highlight-colors",
  --   opts = {
  --     enable_tailwind = false,
  --   },
  -- },
  {
    "luckasRanarison/tailwind-tools.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      document_color = {
        enabled = true, -- can be toggled by commands
        kind = "inline", -- "inline" | "foreground" | "background"
        inline_symbol = "■", -- only used in inline mode
        debounce = 200, -- in milliseconds, only applied in insert mode
      },
    }, -- your configuration
  },
  { "rose-pine/neovim", name = "rose-pine", lazy = true },
  "rktjmp/lush.nvim",

  -- tpopes
  "tpope/vim-abolish",
  "tpope/vim-surround",
  "tpope/vim-repeat",
  "tpope/vim-vinegar",
  "tpope/vim-unimpaired",
  "tpope/vim-sleuth",

  -- navigation
  "justinmk/vim-sneak",
  "aserowy/tmux.nvim",

  -- lsp
  {
    "neovim/nvim-lspconfig",
    dependencies = { "onsails/lspkind-nvim" },
  },
  {
    "j-hui/fidget.nvim",
    opts = {
      progress = { ignore_empty_message = false },
    },
  },

  {
    "hrsh7th/nvim-pasta",
    config = function()
      vim.keymap.set({ "n", "x" }, "p", require("pasta.mapping").p)
      vim.keymap.set({ "n", "x" }, "P", require("pasta.mapping").P)
    end,
  },

  -- git
  "tpope/vim-fugitive",
  "tpope/vim-rhubarb",
  "lewis6991/gitsigns.nvim",

  -- files
  "mbbill/undotree",
  {
    "stevearc/oil.nvim",
    config = function()
      require("oil").setup {
        default_file_explorer = false,
        view_options = {
          show_hidden = true,
        },
      }
    end,
  },

  -- DB
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = { "tpope/vim-dadbod" },
    config = function()
      vim.cmd [[  let g:db_ui_auto_execute_table_helpers = 1 ]]
    end,
  },

  -- util
  {
    "lukas-reineke/indent-blankline.nvim",
    version = "2.20.8",
    config = function()
      require("indent_blankline").setup {
        filetype = { "python", "yaml", "toml" },
      }
    end,
  },
  {
    "numToStr/Comment.nvim",
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    config = function()
      require("Comment").setup {
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      }
      vim.g.skip_ts_context_commentstring_module = true
    end,
  },
  {
    "toppair/peek.nvim",
    event = { "VeryLazy" },
    build = "deno task --quiet build:fast",
    config = function()
      require("peek").setup()
      -- refer to `configuration to change defaults`
      vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
      vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
    end,
  },
  -- test
  "David-Kunz/jester",
}
