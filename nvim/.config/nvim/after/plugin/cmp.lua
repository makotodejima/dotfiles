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
    { name = "nvim_lsp", max_item_count = 30 },
    { name = "vsnip", max_item_count = 20 },
    { name = "path", max_item_count = 20 },
    { name = "nvim_lsp_signature_help" },
    { name = "tmux", keyword_length = 2, max_item_count = 4 },
    { name = "buffer", keyword_length = 2, max_item_count = 4 },
  },
  formatting = {
    format = lspkind.cmp_format {
      menu = {
        buffer = "buf",
        nvim_lsp = "lsp",
        path = "path",
        luasnip = "snip",
        tmux = "tmux",
        cmdline = "cmdline",
        cmdline_history = "history",
      },
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

cmp.setup.cmdline({ "/", "?" }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer", max_item_count = 10 },
  },
})

cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources(
    { { name = "path" } },
    { { name = "cmdline_history", max_item_count = 5 }, { name = "cmdline", max_item_count = 10 } }
  ),
})

-- If file is huge i want to disable cmp
vim.api.nvim_create_autocmd("BufReadPre", {
  callback = function(t)
    if bufIsBig(t.buf) then
      cmp.setup.buffer {
        enabled = function()
          return false
        end,
        -- sources = {},
      }
    end
  end,
})

bufIsBig = function(bufnr)
  local max_filesize = 100 * 1024 -- 100 KB
  local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(bufnr))
  if ok and stats and stats.size > max_filesize then
    return true
  else
    return false
  end
end
