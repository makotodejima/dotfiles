-- `:G difftool <commit>..HEAD` diff in quickfix list
-- `:Gvdiffsplit main:%` compares the current file with the main branch
-- `:GcLog %` commits touching the current file
--
-- `:Gitsigns change_base origin/main all`
-- `:Gitsigns setqflist all` or `:G difftool origin/main`

return {
  "tpope/vim-fugitive",
  {
    "tpope/vim-rhubarb",
    cmd = { "GBrowse" },
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "+" },
          change = { text = "~" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
        },
        max_file_length = 20000,
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map("n", "]c", function()
            if vim.wo.diff then
              return "]c"
            end
            vim.schedule(function()
              gs.next_hunk()
            end)
            return "<Ignore>"
          end, { expr = true })

          map("n", "[c", function()
            if vim.wo.diff then
              return "[c"
            end
            vim.schedule(function()
              gs.prev_hunk()
            end)
            return "<Ignore>"
          end, { expr = true })

          -- Actions
          map({ "n", "v" }, "<leader>hs", gs.stage_hunk)
          map({ "n", "v" }, "<leader>hr", gs.reset_hunk)
          map("n", "<leader>hS", gs.stage_buffer)
          map("n", "<leader>hu", gs.undo_stage_hunk)
          map("n", "<leader>hR", gs.reset_buffer)
          map("n", "<leader>hp", gs.preview_hunk)
          map("n", "<leader>hb", function()
            gs.blame_line({ full = true })
          end)
          map("n", "<leader>tb", gs.toggle_current_line_blame)
          map("n", "<leader>hd", gs.diffthis)
          map("n", "<leader>hD", function()
            gs.diffthis("~")
          end)
          map("n", "<leader>td", gs.toggle_deleted)
        end,
      })

      vim.keymap.set("n", "<leader>gs", ":G<CR>", { noremap = true, silent = false })
      vim.keymap.set("n", "<leader>gh", ":diffget //2", { noremap = true, silent = false })
      vim.keymap.set("n", "<leader>gl", ":diffget //3", { noremap = true, silent = false })
      vim.keymap.set("n", "<leader>gw", ":Gwrite<CR>", { noremap = true, silent = false })
    end,
  },
}
