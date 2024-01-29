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
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({
        "*",
      }, { RRGGBBAA = true, names = false })
    end,
  },
  { "rose-pine/neovim", name = "rose-pine" },
  "hoob3rt/lualine.nvim",
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
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
  },

  -- lsp
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "pmizio/typescript-tools.nvim",
      "onsails/lspkind-nvim",
      "simrat39/rust-tools.nvim",
    },
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
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
    },

    config = function()
      vim.cmd [[  let g:db_ui_auto_execute_table_helpers = 1 ]]
    end,
  },

  -- util
  "github/copilot.vim",
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
    "johmsalas/text-case.nvim",
    opts = {},
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
  -- test
  "David-Kunz/jester",
}
