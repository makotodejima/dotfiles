local lspconfig = require('lspconfig')
local cmp_lsp = require('cmp_nvim_lsp')

-- uncomment to see logs under .cache/
-- vim.lsp.set_log_level("debug")

local capabilities = cmp_lsp.default_capabilities()

local function on_attach(client) client.server_capabilities.documentFormattingProvider = false end

-- Typescript
require("typescript").setup({
  server = {
    -- debug = true,
    capabilities = capabilities,
    on_attach = on_attach,
    init_options = {
      plugins = {
        {
          name = "typescript-styled-plugin",
          location = os.getenv('HOME') .. '/.nvm/versions/node/v16.15.1/lib'
        }
      }
    }
  }
})
vim.api.nvim_set_keymap('n', '<leader>oi', ':TypescriptOrganizeImports<CR>',
                        {noremap = true, silent = false})
vim.api.nvim_set_keymap('n', '<leader>im', ":TypescriptAddMissingImports<CR>",
                        {noremap = true, silent = false})

-- eslint - https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#eslint
lspconfig.eslint.setup {capabilities = capabilities, on_attach = on_attach}
vim.api.nvim_set_keymap('n', '<leader><space>', ':lua vim.lsp.buf.format()<CR>',
                        {noremap = true, silent = false})

-- GraphQL
lspconfig.graphql.setup {filetypes = {"graphql", "gql"}, on_attach = on_attach}

-- Rust
lspconfig.rust_analyzer.setup({capabilities = capabilities, on_attach = on_attach})

-- Lua
lspconfig.sumneko_lua.setup {
  -- cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
  on_attach = on_attach,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT'
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'}
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true)
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {enable = false}
    }
  }
}

-- Python
lspconfig.pyright.setup {capabilities = capabilities, on_attach}
