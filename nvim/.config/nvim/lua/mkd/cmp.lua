local lspkind = require('lspkind')
local cmp = require('cmp')

local opt = {noremap = true, silent = false}
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
vim.keymap.set("n", "[d", ":lua vim.diagnostic.goto_next()<CR>", opt)

vim.o.completeopt = "menu,menuone,noselect"

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
    end
  },
  mapping = cmp.mapping.preset.insert({['<CR>'] = cmp.mapping.confirm({select = true})}),
  sources = cmp.config.sources({
    {name = 'nvim_lsp', priority = 50}, {name = 'vsnip'}, {name = 'path'},
    {name = 'nvim_lsp_signature_help'}
    -- { name = 'tmux', keyword_length = 5,
    --   entry_filter = function(entry, ctx)
    --     -- print(entry.completion_item.word)
    --     -- print(#entry.completion_item.word)
    --     return #entry.completion_item.word > 8
    --   end
    -- },
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
