return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  dependencies = {
    "nvim-treesitter/playground",
    "nvim-treesitter/nvim-treesitter-context",
    {
      "https://github.com/apple/pkl-neovim",
      lazy = true,
      event = "BufReadPre *.pkl",
    },
  },
  config = function()
    local tree_sitter_configs = require "nvim-treesitter.configs"
    tree_sitter_configs.setup {
      ensure_installed = {
        "bash",
        "c",
        "comment",
        "cpp",
        "css",
        "diff",
        "dockerfile",
        "dot",
        "git_config",
        "git_rebase",
        "gitattributes",
        "gitcommit",
        "gitignore",
        "go",
        "graphql",
        "hcl",
        "hlsl",
        "html",
        "http",
        "java",
        "javascript",
        "jq",
        "jsdoc",
        "json",
        "lua",
        "make",
        "markdown",
        "markdown_inline",
        "pkl",
        "python",
        "regex",
        "requirements",
        "rust",
        "scss",
        "sql",
        "terraform",
        "todotxt",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
      },
      -- indent = {enable = true},
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
        disable = function(lang, buf)
          local count = vim.api.nvim_buf_line_count(buf)
          return count > 50000
        end,
      },
      incremental_selection = {
        enable = true,
        keymaps = { node_incremental = "ni", node_decremental = "nd" },
      },
    }
    require("treesitter-context").setup {
      enable = true,
      max_lines = 12,
    }
    vim.keymap.set("n", "[s", function()
      require("treesitter-context").go_to_context(vim.v.count1)
    end)
  end,
}
