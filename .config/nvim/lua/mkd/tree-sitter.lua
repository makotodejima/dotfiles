require"nvim-treesitter.configs".setup {
  indent = {enable = true},
  highlight = {enable = true},
  incremental_selection = {
    enable = true,
    keymaps = {node_incremental = "ii", node_decremental = "II"}
  },
  context_commentstring = {enable = true},
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
  }
}
