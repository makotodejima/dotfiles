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
    "git_rebase",
    "gitcommit",
    "gitignore",
    "graphql",
    "hcl",
    "html",
    "http",
    "javascript",
    "json",
    "jq",
    "lua",
    "markdown",
    "proto",
    "python",
    "query",
    "regex",
    "rust",
    "scss",
    "sql",
    "terraform",
    "todotxt",
    "toml",
    "tsx",
    "typescript",
    "vim",
    "yaml",
  },
  -- indent = {enable = true},
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  incremental_selection = {
    enable = true,
    keymaps = { node_incremental = "ni", node_decremental = "nd" },
  },
  context_commentstring = { enable = true, enable_autocmd = false },
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