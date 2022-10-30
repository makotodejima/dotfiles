local lspconfig = require('lspconfig')
local lspkind = require('lspkind')
local cmp_lsp = require('cmp_nvim_lsp')
local cmp = require('cmp')

-- uncomment to see logs under .cache/
-- vim.lsp.set_log_level("debug")

local capabilities = cmp_lsp.default_capabilities()

require("typescript").setup({
  server = {
    -- debug = true,
    capabilities = capabilities,
    on_attach = function(client, bufnr)
      client.server_capabilities.documentFormattingProvider = false
    end,
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

-- eslint - https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#eslint
lspconfig.eslint.setup {}

lspconfig.graphql.setup { filetypes = { "graphql", "gql" } }

vim.api.nvim_set_keymap('n', '<leader><space>', ':lua vim.lsp.buf.format()<CR>',
  { noremap = true, silent = false })
vim.api.nvim_set_keymap('n', '<leader>oi', ':TypescriptOrganizeImports<CR>',
  { noremap = true, silent = false })
vim.api.nvim_set_keymap('n', '<leader>im', ":TypescriptAddMissingImports<CR>",
  { noremap = true, silent = false })

-- Rust
lspconfig.rust_analyzer.setup({ capabilities = capabilities })

lspconfig.sumneko_lua.setup {
  -- cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    }
  }
}

-- cmp
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
    end
  },
  mapping = cmp.mapping.preset.insert({ ['<CR>'] = cmp.mapping.confirm({ select = true }) }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp', priority = 50 }, { name = 'vsnip' }, { name = 'path' },
    -- { name = 'tmux', keyword_length = 5,
    --   entry_filter = function(entry, ctx)
    --     -- print(entry.completion_item.word)
    --     -- print(#entry.completion_item.word)
    --     return #entry.completion_item.word > 8
    --   end
    -- },
    -- { name = 'nvim_lsp_signature_help' }
    -- , {name = 'buffer', keyword_length = 4}
  }),
  formatting = {
    format = lspkind.cmp_format({
      menu = { buffer = 'buf', nvim_lsp = 'lsp', path = 'path', luasnip = 'snip', tmux = 'tmux' },
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
  sources = cmp.config.sources({ { name = 'path' } }, { { name = 'cmdline', keyword_length = 3 } })
})
