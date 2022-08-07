local lspconfig = require('lspconfig')
local lspkind = require('lspkind')
local cmp_lsp = require('cmp_nvim_lsp')

local capabilities = cmp_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- uncomment to see logs under .cache/
-- vim.lsp.set_log_level("debug")

-- TS
lspconfig.tsserver.setup {
  capabilities = capabilities,
  init_options = {
    plugins = {
      {
        name = "typescript-styled-plugin",
        location = os.getenv('HOME') .. '/.nvm/versions/node/v16.15.1/lib'
      }
    }
  }
}

require("typescript").setup()

vim.api.nvim_set_keymap('n', '<leader>oi', ':TypescriptOrganizeImports<CR>',
                        {noremap = true, silent = false})
vim.api.nvim_set_keymap('n', '<leader>im', ":TypescriptAddMissingImports<CR>",
                        {noremap = true, silent = false})

-- Rust
lspconfig.rust_analyzer.setup({capabilities = capabilities})

-- eslint
-- lspconfig.eslint.setup{}
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#eslint

lspconfig.graphql.setup {filetypes = {"graphql", "gql"}}

-- Lua
local sumneko_binary = vim.fn.exepath('lua-language-server')
local sumneko_root_path = vim.fn.fnamemodify(sumneko_binary, ':h:h:h')

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

lspconfig.sumneko_lua.setup {
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
  settings = {
    Lua = {
      runtime = {version = 'LuaJIT', path = runtime_path},
      diagnostics = {globals = {'vim'}},
      workspace = {library = vim.api.nvim_get_runtime_file("", true)},
      telemetry = {enable = false}
    }
  }
}

-- cmp
local cmp = require 'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
    end
  },
  mapping = cmp.mapping.preset.insert({['<CR>'] = cmp.mapping.confirm({select = true})}),
  sources = cmp.config.sources({
    {name = 'nvim_lsp'}, {name = 'vsnip'}, {name = 'path'}, {name = 'tmux', keyword_length = 5},
    {name = 'nvim_lsp_signature_help'}
    -- , {name = 'buffer', keyword_length = 4}
  }),
  formatting = {
    format = lspkind.cmp_format({
      menu = {buffer = 'buf', nvim_lsp = 'lsp', path = 'path', luasnip = 'snip', tmux = 'tmux'},
      symbol_map = {
        Text = "",
        Method = "",
        Function = "",
        Constructor = "",
        Field = "",
        Variable = "",
        Class = "",
        Interface = "",
        Module = "",
        Property = "",
        Unit = "",
        Value = "",
        Enum = "",
        Keyword = "",
        Snippet = "",
        Color = "",
        File = "",
        Reference = "",
        Folder = "",
        EnumMember = "",
        Constant = "",
        Struct = "",
        Event = "",
        Operator = "",
        TypeParameter = ""
      }
    })
  }
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({{name = 'path'}}, {{name = 'cmdline', keyword_length = 3}})
})

