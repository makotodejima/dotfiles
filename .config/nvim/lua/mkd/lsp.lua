local lspconfig = require('lspconfig')
local lspkind = require('lspkind')

-- Correct colors for diagnostics
vim.cmd(
    [[ autocmd ColorScheme * :lua require('vim.lsp.diagnostic')._define_default_signs_and_highlights() ]])

local on_attach = function(client, bufnr)
  -- do something
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

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

    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>oi", ":TSLspOrganize<CR>", {silent = true})
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>fc", ":TSLspFixCurrent<CR>", {silent = true})
    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", ":TSLspRenameFile<CR>", {silent = true})
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>im", ":TSLspImportAll<CR>", {silent = true})
  end
}

lspconfig.rust_analyzer.setup({on_attach = on_attach, capabilities = capabilities})

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
