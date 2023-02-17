local lspconfig = require "lspconfig"
local cmp_lsp = require "cmp_nvim_lsp"

-- uncomment to see logs under .cache/
-- vim.lsp.set_log_level "debug"

local opt = { noremap = true, silent = false }
vim.keymap.set("n", "gd", ":lua vim.lsp.buf.definition()<CR>", opt)
vim.keymap.set("n", "gi", ":lua vim.lsp.buf.implementation()<CR>", opt)
vim.keymap.set("n", "<leader>k", ":lua vim.lsp.buf.signature_help()<CR>", opt)
vim.keymap.set("n", "gr", ":lua vim.lsp.buf.references()<CR>", opt)
vim.keymap.set("n", "gt", ":lua vim.lsp.buf.type_definition()<CR>", opt)
vim.keymap.set("n", "<leader>rn", ":lua vim.lsp.buf.rename()<CR>", opt)
vim.keymap.set("n", "<leader>ca", ":lua vim.lsp.buf.code_action()<CR>", opt)
vim.keymap.set("n", "gh", ":lua vim.lsp.buf.hover()<CR>", opt)
vim.keymap.set("n", "<leader>e", ":lua vim.diagnostic.open_float()<CR>", opt)
vim.keymap.set("n", "[d", ":lua vim.diagnostic.goto_prev()<CR>", opt)
vim.keymap.set("n", "]d", ":lua vim.diagnostic.goto_next()<CR>", opt)

local capabilities = cmp_lsp.default_capabilities()

local function on_attach(client)
  client.server_capabilities.documentFormattingProvider = false
end

-- Typescript
require("typescript").setup {
  server = {
    -- debug = true,
    capabilities = capabilities,
    on_attach = on_attach,
    init_options = {
      plugins = {
        {
          name = "typescript-styled-plugin",
          location = os.getenv "HOME" .. "/.nvm/versions/node/v16.19.0/lib",
        },
      },
    },
  },
}
vim.api.nvim_set_keymap("n", "<leader>oi", ":TypescriptOrganizeImports<CR>", { noremap = true, silent = false })
vim.api.nvim_set_keymap("n", "<leader>im", ":TypescriptAddMissingImports<CR>", { noremap = true, silent = false })

-- GraphQL
lspconfig.graphql.setup {
  filetypes = { "graphql", "gql" },
  on_attach = on_attach,
  capabilities = capabilities,
}

-- Rust
local rt = require "rust-tools"
rt.setup {
  server = {
    capabilities = capabilities,
    on_attach = on_attach,
  },
}
rt.inlay_hints.enable()

-- Lua
lspconfig.lua_ls.setup {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim" },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

-- Python
local util = require "lspconfig/util"
local path = util.path

local function get_python_path(workspace)
  -- Use activated virtualenv.
  if vim.env.VIRTUAL_ENV then
    return path.join(vim.env.VIRTUAL_ENV, "bin", "python")
  end

  -- Find and use virtualenv in workspace directory.
  for _, pattern in ipairs { "*", ".*" } do
    local match = vim.fn.glob(path.join(workspace, pattern, "pyvenv.cfg"))
    if match ~= "" then
      return path.join(path.dirname(match), "bin", "python")
    end
  end

  -- Fallback to system Python.
  return exepath "python3" or exepath "python" or "python"
end

lspconfig.pyright.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  on_init = function(client)
    client.config.settings.python.pythonPath = get_python_path(client.config.root_dir)
  end,
}
