local dap = require "dap"

dap.adapters.node2 = {
  type = "executable",
  command = "node",
  args = { os.getenv "HOME" .. "/dev/vscode-node-debug2/out/src/nodeDebug.js" },
}

dap.configurations.javascript = {
  {
    name = "Launch",
    type = "node2",
    request = "launch",
    program = "${file}",
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = "inspector",
    console = "integratedTerminal",
  },
  {
    -- For this to work you need to make sure the node process is started with the `--inspect` flag.
    name = "Attach to process",
    type = "node2",
    request = "attach",
    processId = require("dap.utils").pick_process,
  },
}

dap.configurations.typescript = {
  {
    type = "node2",
    request = "launch",
    program = "${workspaceFolder}/node_modules/jest/bin/jest.js",
    args = {
      "—verbose",
      "—runInBand",
      "—forceExit",
      "—config",
      "jest.config.json",
      "${file}",
    },
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    restart = true,
    protocol = "inspector",
    console = "integratedTerminal",
  },
}

-- vim.api.nvim_set_keymap('n', '<leader>bp', [[<cmd>lua require'dap'.toggle_breakpoint()<CR>]],
--                         {noremap = true, silent = false})
-- vim.api.nvim_set_keymap('n', '<leader>cn', [[<cmd>lua require'dap'.continue()<CR>]],
--                         {noremap = true, silent = false})
