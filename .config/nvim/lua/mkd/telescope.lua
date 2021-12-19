local actions = require("telescope.actions")

require("telescope").setup({
  defaults = {
    prompt_prefix = "  ",
    mappings = {i = {["<C-q>"] = actions.send_selected_to_qflist}},
    layout_strategy = "vertical",
    layout_config = {vertical = {width = 0.9, height = 0.96, preview_height = 0.6}},
    file_ignore_patterns = {"node_modules", "undodir"}
  },
  pickers = {
    buffers = {
      ignore_current_buffer = true,
      sort_lastused = true,
      mappings = {i = {["<c-d>"] = "delete_buffer"}}
    }
  }
})

require('telescope').load_extension('fzf')

