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
  -- color
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
  "hoob3rt/lualine.nvim",

  -- treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "RRethy/nvim-treesitter-textsubjects",
      "nvim-treesitter/playground",
      "nvim-treesitter/nvim-treesitter-context",
    },
  },

  -- tpopes
  "tpope/vim-abolish",
  "tpope/vim-dispatch",
  "tpope/vim-surround",
  "tpope/vim-repeat",
  "tpope/vim-vinegar",
  "tpope/vim-unimpaired",

  -- navigation
  "justinmk/vim-sneak",
  "aserowy/tmux.nvim",
  "ThePrimeagen/harpoon",

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
    config = function()
      require("fidget").setup {}
    end,
    tag = "legacy",
  },

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
      "dmitmel/cmp-cmdline-history",
      "andersevenrud/cmp-tmux",
    },
  },

  -- formatter
  "mhartington/formatter.nvim",

  -- git
  "tpope/vim-fugitive",
  "tpope/vim-rhubarb",
  "lewis6991/gitsigns.nvim",

  -- telescope
  "nvim-lua/popup.nvim",
  "nvim-lua/plenary.nvim",
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
      "nvim-telescope/telescope-media-files.nvim",
    },
  },

  -- files
  "mbbill/undotree",
  "edluffy/hologram.nvim",
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

  -- util
  "ThePrimeagen/refactoring.nvim",
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("indent_blankline").setup {
        filetype = { "python", "yaml", "toml" },
      }
    end,
  },
  {
    "hrsh7th/nvim-pasta",
    config = function()
      require("pasta").setup {
        fix_indent = false,
      }
      vim.keymap.set({ "n", "x" }, "p", require("pasta.mappings").p)
      vim.keymap.set({ "n", "x" }, "P", require("pasta.mappings").P)
      vim.keymap.set({ "n" }, "<C-p>", require("pasta.mappings").toggle_pin)
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
    end,
  },
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
    },
  },

  -- test
  "David-Kunz/jester",
}, {
  ui = {
    icons = {
      cmd = "",
      config = "",
      event = "",
      ft = "",
      init = "",
      keys = "",
      plugin = "",
      runtime = "",
      source = "",
      start = "",
      task = "",
      lazy = "",
    },
  },
})
