vim.pack.add({
  "https://github.com/neovim/nvim-lspconfig",
}, {
  confirm = false,
  -- Temporary while lazy.nvim still owns startup: it sources plugin scripts
  -- from these runtime paths. Change this to true at the final cutover.
  load = false,
})

-- uncomment to see logs under .cache/
-- vim.lsp.set_log_level("debug")
local opt = { noremap = true, silent = false }
vim.keymap.set("n", "gd", ":lua vim.lsp.buf.definition()<CR>", opt)
vim.keymap.set("n", "K", ":lua vim.lsp.buf.signature_help()<CR>", opt)
vim.keymap.set("n", "grc", ":lua vim.lsp.buf.code_action({ context = { only = {'source'} } })<CR>", opt)
vim.keymap.set("n", "gh", ":lua vim.lsp.buf.hover()<CR>", opt)
vim.keymap.set("n", "<leader>e", ":lua vim.diagnostic.open_float()<CR>", opt)
vim.keymap.set("n", "[d", ":lua vim.diagnostic.jump({ count = -1 })<CR>", opt)
vim.keymap.set("n", "]d", ":lua vim.diagnostic.jump({ count = 1 })<CR>", opt)

local function on_attach(client)
  client.server_capabilities.documentFormattingProvider = false
end

-- Typos
vim.lsp.config("typos_lsp", {
  on_attach = on_attach,
  init_options = {
    diagnosticSeverity = "Hint",
  },
})

-- Lua
vim.lsp.config("lua_ls", {
  on_attach = on_attach,
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      diagnostics = { globals = { "vim" } },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = "Disable",
      },
      telemetry = { enable = false },
    },
  },
})

vim.lsp.enable({
  "astro",
  "bashls",
  "cssls",
  "eslint",
  "gopls",
  "html",
  "lua_ls",
  "postgres_lsp",
  "rust_analyzer",
  "sourcekit",
  -- "tailwindcss",
  "terraformls",
  "tsgo",
  "typos_lsp",
  "ty",
})

-- lazy.nvim expects every imported module to return a table of specs. This
-- plugin is now owned by vim.pack, so this module contributes none.
return {}
