return {
  {
    "github/copilot.vim",
    config = function()
      local patterns = { "mkd-lang", "kata-machine", "personal" }
      vim.api.nvim_create_autocmd({ "InsertEnter", "BufNewFile", "BufRead" }, {
        callback = function()
          local filepath = vim.fn.expand("%:p")
          for _, path in ipairs(patterns) do
            if string.find(filepath, path:gsub("%-", "%%-")) then
              vim.b.copilot_enabled = false
              return
            end
          end
        end,
      })
    end,
  },
  {
    "coder/claudecode.nvim",
    cmd = { "ClaudeCode", "ClaudeCodeSend" },
    opts = {
      terminal = {
        provider = "native",
        split_width_percentage = 0.5,
        auto_close = true,
      },
    },
    keys = {
      { "<leader>a", nil, desc = "AI/Claude Code" },
      { "<leader>ac", "<cmd>ClaudeCodeFocus<cr>", desc = "Toggle Claude" },
      { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
      -- { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
      { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
      { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },

      {
        "<leader>as",
        "<cmd>ClaudeCodeTreeAdd<cr>",
        desc = "Add file",
        ft = { "NvimTree", "neo-tree", "oil", "netrw" },
      },
      -- Diff management
      { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
      { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
    },
  },
}
