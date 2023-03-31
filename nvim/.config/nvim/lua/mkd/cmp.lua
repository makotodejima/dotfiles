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
    { name = "nvim_lsp" },
    { name = "vsnip" },
    { name = "path" },
    { name = "nvim_lsp_signature_help" },
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
  sources = cmp.config.sources {
    { name = "fuzzy_path" },
    { name = "cmdline_history", max_item_count = 5 },
    { name = "cmdline" },
    -- {
    --   name = "buffer",
    --   option = {
    --     keyword_length = 4,
    --   },
    -- },
  },
})
