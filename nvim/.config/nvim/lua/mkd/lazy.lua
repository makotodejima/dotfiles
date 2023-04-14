local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    "rose-pine/neovim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd [[colorscheme rose-pine]]
    end,
  },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({
        "*",
      }, { RRGGBBAA = true, css = true })
    end,
  },
  {
    "goolord/alpha-nvim",
    config = function()
      local startify = require "alpha.themes.startify"
      startify.nvim_web_devicons.enabled = false
      require("alpha").setup(startify.config)
    end,
  },
  {
    "hoob3rt/lualine.nvim",
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "RRethy/nvim-treesitter-textsubjects",
      "nvim-treesitter/playground",
    },
  },

  -- tpopes
  "tpope/vim-abolish",
  "tpope/vim-dispatch",
  "tpope/vim-surround",
  "tpope/vim-repeat",
  "tpope/vim-vinegar",
  "tpope/vim-unimpaired",

  -- lsp
  {
    "neovim/nvim-lsp",
    dependencies = {
      "jose-elias-alvarez/typescript.nvim",
      "onsails/lspkind-nvim",
      "simrat39/rust-tools.nvim",
    },
  },
  {
    "j-hui/fidget.nvim",
    config = function()
      require("fidget").setup {}
    end,
  },

  "jose-elias-alvarez/null-ls.nvim",
  "tzachar/fuzzy.nvim",

  -- cmp
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/vim-vsnip",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "andersevenrud/cmp-tmux",
      "tzachar/cmp-fuzzy-path",
      "dmitmel/cmp-cmdline-history",
    },
  },

  -- git
  "tpope/vim-fugitive",
  "tpope/vim-rhubarb",
  "junegunn/gv.vim",
  "lewis6991/gitsigns.nvim",
  "ThePrimeagen/git-worktree.nvim",

  "nvim-lua/popup.nvim",
  "nvim-lua/plenary.nvim",
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
      "nvim-telescope/telescope-dap.nvim",
      "nvim-telescope/telescope-media-files.nvim",
    },
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  },

  -- util
  "mbbill/undotree",
  "chentoast/marks.nvim",
  {
    "gbprod/yanky.nvim",
    opts = {
      highlight = { on_put = true, on_yank = true, timer = 50 },
    },
  },
  {
    "folke/todo-comments.nvim",
    opts = {
      signs = false,
      highlight = { keyword = "fg" },
    },
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
    end,
  },

  -- registers
  "AckslD/nvim-neoclip.lua",
  "tami5/sqlite.lua",

  -- navigation
  "justinmk/vim-sneak",
  "aserowy/tmux.nvim",

  -- prime
  "ThePrimeagen/harpoon",
  "ThePrimeagen/refactoring.nvim",

  -- test
  "David-Kunz/jester",
  "mfussenegger/nvim-dap",

  "edluffy/hologram.nvim",
}, {
  ui = {
    icons = {
      cmd = "⌘",
      config = "🛠",
      event = "📅",
      ft = "📂",
      init = "⚙",
      keys = "🗝",
      plugin = "🔌",
      runtime = "💻",
      source = "📄",
      start = "🚀",
      task = "📌",
      lazy = "💤",
    },
  },
})
