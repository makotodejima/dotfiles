vim.o.completeopt = "menu,menuone,noselect"

vim.pack.add({
  "https://github.com/hrsh7th/nvim-cmp",
  "https://github.com/hrsh7th/cmp-nvim-lsp",
  "https://github.com/hrsh7th/cmp-nvim-lsp-signature-help",
  "https://github.com/hrsh7th/cmp-path",
  "https://github.com/hrsh7th/cmp-buffer",
  "https://github.com/hrsh7th/cmp-cmdline",
  "https://github.com/dmitmel/cmp-cmdline-history",
  "https://github.com/onsails/lspkind-nvim",
}, {
  confirm = false,
  -- Temporary while lazy.nvim still owns startup: it sources plugin scripts
  -- from these runtime paths. Change this to true at the final cutover.
  load = false,
})

local lspkind = require("lspkind")
local cmp = require("cmp")
cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp", priority = 1000, max_item_count = 30 },
    { name = "path", max_item_count = 20 },
    { name = "nvim_lsp_signature_help" },
    { name = "buffer", keyword_length = 2, max_item_count = 4 },
  }),
  formatting = {
    format = lspkind.cmp_format({
      menu = {
        buffer = "buf",
        nvim_lsp = "lsp",
        path = "path",
        cmdline = "cmdline",
        cmdline_history = "history",
      },
    }),
  },
})

cmp.setup.cmdline({ "/", "?" }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer", max_item_count = 10 },
  },
})

cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({ { name = "path" } }, {
    { name = "cmdline_history", keyword_length = 2, max_item_count = 12 },
    { name = "cmdline", max_item_count = 10 },
  }),
})

-- lazy.nvim expects every imported module to return a table of specs. This
-- plugin is now owned by vim.pack, so this module contributes none.
return {}
