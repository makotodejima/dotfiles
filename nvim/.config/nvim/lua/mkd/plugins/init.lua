local pack_group = vim.api.nvim_create_augroup("MkdPackHooks", { clear = true })

vim.api.nvim_create_autocmd("PackChanged", {
  group = pack_group,
  callback = function(event)
    local name = event.data.spec.name
    local kind = event.data.kind

    if name ~= "peek.nvim" or (kind ~= "install" and kind ~= "update") then
      return
    end

    local result = vim
      .system({ "deno", "task", "--quiet", "build:fast" }, {
        cwd = event.data.path,
        text = true,
      })
      :wait()

    if result.code ~= 0 then
      vim.notify(
        "Failed to build peek.nvim:\n" .. (result.stderr or result.stdout or "Unknown error"),
        vim.log.levels.ERROR
      )
    end
  end,
})

-- Keep the local checkout live while developing the colorscheme. Using this as
-- a vim.pack source would clone it into Neovim's package directory instead.
vim.opt.rtp:prepend(vim.fn.expand("~/dev/bob"))

vim.pack.add({
  "https://github.com/barrettruth/diffs.nvim",
  "https://github.com/github/copilot.vim",
  "https://github.com/MunifTanjim/nui.nvim",
  "https://github.com/tpope/vim-surround",
  "https://github.com/tpope/vim-vinegar",
  "https://github.com/tpope/vim-unimpaired",
  "https://github.com/aserowy/tmux.nvim",
  "https://github.com/stevearc/oil.nvim",
  "https://github.com/gbprod/yanky.nvim",
  "https://github.com/numToStr/Comment.nvim",
}, {
  confirm = false,
  -- Temporary while lazy.nvim still owns startup: it sources plugin scripts
  -- from these runtime paths. Change this to true at the final cutover.
  load = false,
})

vim.cmd.colorscheme("bob")

vim.g.copilot_filetypes = {
  gitcommit = true,
}

require("tmux").setup({
  copy_sync = {
    -- enables copy sync and overwrites all register actions to sync registers
    -- *, +, unnamed, and 0 till 9 from tmux in advance
    enable = false,
  },
  navigation = { enable_default_keybindings = true },
  resize = { enable_default_keybindings = true, resize_step_x = 4, resize_step_y = 4 },
})

require("oil").setup({
  default_file_explorer = false,
  view_options = {
    show_hidden = true,
  },
})

require("yanky").setup({
  ring = {
    storage = "shada",
  },
  highlight = {
    on_put = true,
    on_yank = false,
    timer = 55,
  },
})

vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")
vim.keymap.set("n", "<c-n>", "<Plug>(YankyPreviousEntry)")

-- lazy.nvim expects every imported module to return a table of specs. The
-- plugins above are now owned by vim.pack, so this module contributes none.
return {}
