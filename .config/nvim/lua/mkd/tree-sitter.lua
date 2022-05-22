local tree_sitter_configs = require "nvim-treesitter.configs";

tree_sitter_configs.setup {
  ensure_installed = {
    "bash", "c", "comment", "cpp", "css", "graphql", "hcl", "html", "javascript", "json", "lua",
    "markdown", "python", "regex", "rust", "toml", "tsx", "typescript", "vim", "yaml"
  },
  -- indent = {enable = true},
  highlight = {enable = true},
  incremental_selection = {
    enable = true,
    keymaps = {node_incremental = "ni", node_decremental = "nd"}
  },
  context_commentstring = {enable = true},
  autotag = {enable = true},
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
        ["ic"] = "@class.inner"

        -- Or you can define your own textobjects like this
        -- ["iF"] = {
        --   python = "(function_definition) @function",
        --   cpp = "(function_definition) @function",
        --   c = "(function_definition) @function",
        --   java = "(method_declaration) @function"
        -- }
      }
    }
  },
  textsubjects = {enable = true, keymaps = {['.'] = 'textsubjects-smart'}}
}
