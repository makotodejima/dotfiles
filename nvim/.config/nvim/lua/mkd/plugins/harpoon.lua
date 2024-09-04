return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  event = "VeryLazy",
  config = function()
    local harpoon = require "harpoon"

    -- REQUIRED
    harpoon:setup()
    -- REQUIRED

    vim.keymap.set("n", "<leader>hh", function()
      harpoon:list():add()
    end)
    vim.keymap.set("n", "<leader>hl", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end)

    vim.keymap.set("n", "˙", function()
      harpoon:list():select(1)
    end)

    vim.keymap.set("n", "∆", function()
      harpoon:list():select(2)
    end)

    vim.keymap.set("n", "˚", function()
      harpoon:list():select(3)
    end)

    vim.keymap.set("n", "¬", function()
      harpoon:list():select(4)
    end)
  end,
}
