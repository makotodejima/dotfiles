return {
  "github/copilot.vim",
  config = function()
    local patterns = { "mkd-lang", "kata-machine", "personal" }
    vim.api.nvim_create_autocmd({ "InsertEnter", "BufNewFile", "BufRead" }, {
      callback = function()
        local filepath = vim.fn.expand "%:p"
        for _, path in ipairs(patterns) do
          if string.find(filepath, path:gsub("%-", "%%-")) then
            vim.b.copilot_enabled = false
            return
          end
        end
      end,
    })
  end,
  {
    "madox2/vim-ai",
    cmd = { "AI", "AIEdit", "AIChat", "AIE", "AIC", "CM" },
    config = function()
      local function git_commit_message()
        local diff = vim.fn.system "git --no-pager diff --staged"
        local prompt = "generate a concise commit message (all lower case) from the diff below:\n\n<diff>"
          .. diff
          .. "</diff>"

        local config = {
          engine = "chat",
          options = {
            model = "gpt-4o",
            -- initial_prompt = ">>> system\nyou are a code assistant",
            temperature = 1,
          },
        }

        vim.call("vim_ai#AIRun", false, config, prompt)
      end

      vim.api.nvim_create_user_command("CM", git_commit_message, {})
    end,
  },
}
