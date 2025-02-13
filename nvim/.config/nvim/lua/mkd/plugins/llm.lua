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
    cmd = { "AI", "AIEdit", "AIChat", "AIE", "AIC" },
  },
}
