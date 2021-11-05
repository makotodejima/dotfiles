local lspconfig = require('lspconfig')
local lspkind = require('lspkind')

local on_attach = function(client, bufnr)
  -- do something
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- TS
lspconfig.tsserver.setup {
  on_attach = function(client, bufnr)
    -- ts_utils
    local ts_utils = require("nvim-lsp-ts-utils")
    ts_utils.setup {
      enable_import_on_completion = true
      -- update_imports_on_move = true,
      -- require_confirmation_on_move = true,
    }
    -- required to fix code action ranges
    ts_utils.setup_client(client)

    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>oi", ":TSLspOrganize<CR>", {silent = false})
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>fc", ":TSLspFixCurrent<CR>", {silent = false})
    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", ":TSLspRenameFile<CR>", {silent = true})
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>im", ":TSLspImportAll<CR>", {silent = false})
  end
}

-- Rust
lspconfig.rust_analyzer.setup({on_attach = on_attach, capabilities = capabilities})

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
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path
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

-- cmp
local cmp = require 'cmp'
cmp.setup({
  snippet = {expand = function(args) vim.fn["vsnip#anonymous"](args.body) end},
  mapping = {['<CR>'] = cmp.mapping.confirm({select = true})},
  -- sorting = {
  --   priority_weight = 3.,
  -- },
  sources = {
    {name = 'nvim_lsp'}, {name = 'vsnip'}, {name = 'path'}, {name = 'buffer', keyword_length = 5}
  },
  formatting = {
    format = lspkind.cmp_format({
      menu = {buffer = 'buf', nvim_lsp = 'lsp', path = 'path', luasnip = 'snip'},
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
