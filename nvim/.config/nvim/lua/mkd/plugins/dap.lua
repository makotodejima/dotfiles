return {
  -- {
  --   "mfussenegger/nvim-dap",
  --   dependencies = {
  --     {
  --       "rcarriga/nvim-dap-ui",
  --       config = function()
  --         require("dapui").setup {
  --           controls = {
  --             element = "repl",
  --             enabled = true,
  --             icons = {
  --               disconnect = "x",
  --               pause = "p",
  --               play = "▶",
  --               run_last = "",
  --               step_back = "",
  --               step_into = "",
  --               step_out = "",
  --               step_over = "",
  --               terminate = "X",
  --             },
  --           },
  --           element_mappings = {},
  --           expand_lines = true,
  --           floating = {
  --             border = "single",
  --             mappings = {
  --               close = { "q", "<Esc>" },
  --             },
  --           },
  --           force_buffers = true,
  --           icons = {
  --             collapsed = ">",
  --             current_frame = "->",
  --             expanded = "v",
  --           },
  --           layouts = {
  --             {
  --               elements = {
  --                 {
  --                   id = "scopes",
  --                   size = 0.25,
  --                 },
  --                 {
  --                   id = "breakpoints",
  --                   size = 0.25,
  --                 },
  --                 {
  --                   id = "stacks",
  --                   size = 0.25,
  --                 },
  --                 {
  --                   id = "watches",
  --                   size = 0.25,
  --                 },
  --               },
  --               position = "left",
  --               size = 40,
  --             },
  --             {
  --               elements = {
  --                 {
  --                   id = "repl",
  --                   size = 0.5,
  --                 },
  --                 {
  --                   id = "console",
  --                   size = 0.5,
  --                 },
  --               },
  --               position = "bottom",
  --               size = 10,
  --             },
  --           },
  --           mappings = {
  --             edit = "e",
  --             expand = { "<CR>", "<2-LeftMouse>" },
  --             open = "o",
  --             remove = "d",
  --             repl = "r",
  --             toggle = "t",
  --           },
  --           render = {
  --             indent = 1,
  --             max_value_lines = 100,
  --           },
  --         }
  --       end,
  --     },
  --   },
  --   config = function()
  --     local dap = require "dap"
  --     local dapui = require "dapui"
  --
  --     dap.listeners.after.event_initialized["dapui_config"] = function()
  --       dapui.open {}
  --     end
  --     dap.listeners.before.event_terminated["dapui_config"] = function()
  --       dapui.close {}
  --     end
  --     dap.listeners.before.event_exited["dapui_config"] = function()
  --       dapui.close {}
  --     end
  --     vim.keymap.set("n", "<leader>dui", dapui.toggle)
  --
  --     -- Set keymaps to control the debugger
  --     vim.keymap.set("n", "<leader>d", dap.continue)
  --     vim.keymap.set("n", "<leader>si", dap.step_into)
  --     vim.keymap.set("n", "<leader>so", dap.step_over)
  --     -- vim.keymap.set("n", "<F12>", require("dap").step_out)
  --     vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint)
  --     vim.keymap.set("n", "<leader>B", function()
  --       dap.set_breakpoint(vim.fn.input "Breakpoint condition: ")
  --     end)
  --   end,
  -- },
  -- {
  --   "mxsdev/nvim-dap-vscode-js",
  --   dependencies = {
  --     {
  --       "microsoft/vscode-js-debug",
  --       build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
  --     },
  --   },
  --   config = function()
  --     require("dap-vscode-js").setup {
  --       -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
  --       debugger_path = vim.fn.stdpath "data" .. "/lazy/vscode-js-debug", -- Path to vscode-js-debug installation.
  --       -- debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
  --       adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" }, -- which adapters to register in nvim-dap
  --       log_file_path = vim.fn.stdpath "cache" .. "/dap_vscode_js.log", -- Path for file logging
  --       -- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
  --       -- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
  --     }
  --
  --     local js_based_languages = { "typescript", "javascript", "typescriptreact" }
  --
  --     --[[ for _, language in ipairs(js_based_languages) do
  --       require("dap").configurations[language] = {
  --         {
  --           type = "pwa-node",
  --           request = "launch",
  --           name = "Launch file",
  --           program = "${file}",
  --           cwd = "${workspaceFolder}",
  --         },
  --         {
  --           type = "pwa-node",
  --           request = "attach",
  --           name = "Attach",
  --           processId = require("dap.utils").pick_process,
  --           cwd = "${workspaceFolder}",
  --         },
  --         {
  --           type = "pwa-chrome",
  --           request = "launch",
  --           name = 'Start Chrome with "localhost"',
  --           url = "http://localhost:3000",
  --           webRoot = "${workspaceFolder}",
  --           userDataDir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir",
  --         },
  --       }
  --     end ]]
  --
  --     require("dap.ext.vscode").load_launchjs(nil, {
  --       ["pwa-node"] = js_based_languages,
  --       ["node"] = js_based_languages,
  --       ["chrome"] = js_based_languages,
  --       ["pwa-chrome"] = js_based_languages,
  --     })
  --
  --     -- HACK: override the type of the configurations to match the ones from the vscode-js-debug
  --     -- Also set the cwd to the workspace folder (not sure why it's not working by default)
  --     local configs = require("dap").configurations
  --     for _, lang_configs in pairs(configs) do
  --       for _, config in pairs(lang_configs) do
  --         if config.type == "node" then
  --           config.type = "pwa-node" -- override the type
  --           config.cwd = config.cwd or "${workspaceFolder}"
  --           config.sourceMaps = config.sourceMaps or true
  --           config.resolveSourceMapLocations = config.resolveSourceMapLocations or { "**", "!**/node_modules/**" }
  --           config.autoAttachChildProcesses = config.autoAttachChildProcesses or true
  --           config.skipFiles = config.skipFiles or { "<node_internals>/**" }
  --         elseif config.type == "chrome" then
  --           config.type = "pwa-chrome" -- override the type
  --         end
  --       end
  --     end
  --   end,
  -- },
}
