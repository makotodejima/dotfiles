local lspconfig = require "lspconfig"
local cmp_lsp = require "cmp_nvim_lsp"

-- uncomment to see logs under .cache/
-- vim.lsp.set_log_level("debug")

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
          location = os.getenv "HOME" .. "/.nvm/versions/node/v16.15.1/lib",
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
lspconfig.sumneko_lua.setup {
  -- cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
  on_attach = on_attach,
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
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = { enable = false },
    },
  },
}

-- Python
lspconfig.pyright.setup { capabilities = capabilities, on_attach = on_attach }
