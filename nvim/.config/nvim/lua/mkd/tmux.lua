require("tmux").setup({
  copy_sync = {
    -- enables copy sync and overwrites all register actions to
    -- sync registers *, +, unnamed, and 0 till 9 from tmux in advance
    enable = false
  },
  navigation = {enable_default_keybindings = true},
  resize = {enable_default_keybindings = true, resize_step_x = 8, resize_step_y = 8}
})
