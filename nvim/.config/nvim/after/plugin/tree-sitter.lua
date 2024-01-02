local tree_sitter_configs = require "nvim-treesitter.configs"

tree_sitter_configs.setup {
  ensure_installed = {
    "bash",
    "c",
    "comment",
    "cpp",
    "css",
    "csv",
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
    "javascript",
    "jq",
    "jsdoc",
    "json",
    "lua",
    "make",
    "markdown",
    "markdown_inline",
    "proto",
    "python",
    "query",
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
  textsubjects = { enable = true, keymaps = { ["."] = "textsubjects-smart" } },
  textobjects = {
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",

        -- Or you can define your own textobjects like this
        -- ["iF"] = {
        --   python = "(function_definition) @function",
        --   cpp = "(function_definition) @function",
        --   c = "(function_definition) @function",
        --   java = "(method_declaration) @function"
        -- }
      },
    },
  },
}
