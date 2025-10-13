vim.api.nvim_create_user_command("Tsc", function()
  vim.cmd("compiler tsc")
  vim.cmd([[setlocal makeprg=npx\ tsc]])
  vim.cmd("make")
end, {})

vim.api.nvim_create_user_command("Eslint", function()
  -- See neovim built-in compiler file '/opt/homebrew/Cellar/neovim/0.10.2_1/share/nvim/runtime/compiler/eslint.vim
  -- vim.cmd [[setlocal makeprg=npx\ eslint\ -f\ compact\ 'src/**/*.{js,ts,jsx,tsx}']]
  vim.cmd("compiler eslint")
  vim.cmd("make")
end, {})
