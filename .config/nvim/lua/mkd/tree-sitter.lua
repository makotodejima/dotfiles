require "nvim-treesitter.configs".setup {
    indent = {enable = true},
    highlight = {enable = true},
    incremental_selection = {enable = true, keymaps = {node_incremental = "ii", node_decremental = "II"}},
    context_commentstring = {
      enable = true
    }
}
