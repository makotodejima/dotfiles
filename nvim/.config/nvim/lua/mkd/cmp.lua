local lspkind = require "lspkind"
local cmp = require "cmp"

vim.o.completeopt = "menu,menuone,noselect"

cmp.setup {
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
    end,
  },
  mapping = cmp.mapping.preset.insert { ["<CR>"] = cmp.mapping.confirm { select = true } },
  sources = cmp.config.sources {
    { name = "nvim_lsp", priority = 50 },
    { name = "vsnip" },
    { name = "path" },
    { name = "nvim_lsp_signature_help" },
    -- { name = 'tmux', keyword_length = 5,
    --   entry_filter = function(entry, ctx)
    --     -- print(entry.completion_item.word)
    --     -- print(#entry.completion_item.word)
    --     return #entry.completion_item.word > 8
    --   end
    -- },
    -- , {name = 'buffer', keyword_length = 4}
  },
  formatting = {
    format = lspkind.cmp_format {
      menu = { buffer = "buf", nvim_lsp = "lsp", path = "path", luasnip = "snip", tmux = "tmux" },
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
        TypeParameter = "",
      },
    },
  },
}

cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline", keyword_length = 2 } }),
})
