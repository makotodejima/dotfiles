vim.o.completeopt = "menu,menuone,noselect"

return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-cmdline",
    "dmitmel/cmp-cmdline-history",
    "andersevenrud/cmp-tmux",
    {
      "L3MON4D3/LuaSnip",
      dependencies = { "saadparwaiz1/cmp_luasnip" },
      config = function()
        require("luasnip.loaders.from_lua").load { paths = { vim.fn.expand "~/.config/nvim/lua/mkd/snippets" } }
      end,
    },
    "luckasRanarison/tailwind-tools.nvim",
  },

  config = function()
    local lspkind = require "lspkind"
    local cmp = require "cmp"
    cmp.setup {
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert {
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<CR>"] = cmp.mapping.confirm { select = true },
      },
      sources = cmp.config.sources {
        { name = "nvim_lsp", priority = 1000, max_item_count = 30 },
        { name = "luasnip", max_item_count = 10 },
        { name = "path", max_item_count = 20 },
        { name = "nvim_lsp_signature_help" },
        { name = "tmux", keyword_length = 2, max_item_count = 4 },
        { name = "buffer", keyword_length = 2, max_item_count = 4 },
      },
      formatting = {
        format = lspkind.cmp_format {
          before = require("tailwind-tools.cmp").lspkind_format,
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
      sources = cmp.config.sources({ { name = "path" } }, {
        { name = "cmdline_history", keyword_length = 2, max_item_count = 12 },
        { name = "cmdline", max_item_count = 10 },
      }),
    })

    -- If file is huge disable cmp
    local bufIsBig = function(bufnr)
      local max_filesize = 100 * 1024 -- 100 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(bufnr))
      if ok and stats and stats.size > max_filesize then
        return true
      else
        return false
      end
    end

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
  end,
}
