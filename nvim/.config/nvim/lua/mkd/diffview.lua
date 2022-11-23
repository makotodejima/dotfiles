require("diffview").setup {
  use_icons = false,
  signs = {
    fold_closed = "+",
    fold_open = "-",
    done = "✓",
  },
  file_panel = {
    listing_style = "tree", -- One of 'list' or 'tree'
    tree_options = { -- Only applies when listing_style is 'tree'
      flatten_dirs = true, -- Flatten dirs that only contain one single dir
      folder_statuses = "only_folded", -- One of 'never', 'only_folded' or 'always'.
    },
  },
}
