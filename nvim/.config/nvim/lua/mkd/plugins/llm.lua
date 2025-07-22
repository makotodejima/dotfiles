return {
  -- {
  --   "github/copilot.vim",
  --   config = function()
  --     local patterns = { "mkd-lang", "kata-machine", "personal" }
  --     vim.api.nvim_create_autocmd({ "InsertEnter", "BufNewFile", "BufRead" }, {
  --       callback = function()
  --         local filepath = vim.fn.expand("%:p")
  --         for _, path in ipairs(patterns) do
  --           if string.find(filepath, path:gsub("%-", "%%-")) then
  --             vim.b.copilot_enabled = false
  --             return
  --           end
  --         end
  --       end,
  --     })
  --   end,
  -- },
  {
    "olimorris/codecompanion.nvim",
    cmd = { "CodeCompanion", "CodeCompanionChat" },
    config = function()
      require("codecompanion").setup({
        strategies = {
          chat = {
            adapter = {
              name = "copilot",
              model = "claude-sonnet-4",
            },
          },
          inline = {
            adapter = {
              name = "copilot",
              model = "claude-sonnet-4",
            },
          },
        },
        display = {
          chat = {
            window = {
              position = "right",
            },
          },
        },
      })
      require("mkd.llm.codecompanion-spinner"):init()
      require("mkd.llm.chat-spinner"):init()
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    keys = {
      { "<leader>cc", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" } },
      { "<leader>cca", "<cmd>CodeCompanionChat Add<cr>", mode = "v" },
    },
    keymaps = {
      send = {
        callback = function(chat)
          vim.cmd("stopinsert")
          chat:submit()
          chat:add_buf_message({ role = "llm", content = "" })
        end,
        index = 1,
        description = "Send",
      },
    },
  },
  {
    -- "coder/claudecode.nvim",
    dir = "~/dev/claudecode.nvim",
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
  {
    "supermaven-inc/supermaven-nvim",
    config = true,
    event = { "InsertEnter" },
  },
}
