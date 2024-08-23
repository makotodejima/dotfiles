local lspconfig = require "lspconfig"
local cmp_lsp = require "cmp_nvim_lsp"

-- uncomment to see logs under .cache/
-- vim.lsp.set_log_level "debug"

local opt = { noremap = true, silent = false }
vim.keymap.set("n", "gd", ":lua vim.lsp.buf.definition()<CR>", opt)
vim.keymap.set("n", "gi", ":lua vim.lsp.buf.implementation()<CR>", opt)
vim.keymap.set("n", "K", ":lua vim.lsp.buf.signature_help()<CR>", opt)
vim.keymap.set("n", "gr", ":lua vim.lsp.buf.references()<CR>", opt)
vim.keymap.set("n", "gt", ":lua vim.lsp.buf.type_definition()<CR>", opt)
vim.keymap.set("n", "<leader>rn", ":lua vim.lsp.buf.rename()<CR>", opt)
vim.keymap.set("n", "<leader>ca", ":lua vim.lsp.buf.code_action()<CR>", opt)
vim.keymap.set("n", "gh", ":lua vim.lsp.buf.hover()<CR>", opt)
vim.keymap.set("n", "<leader>e", ":lua vim.diagnostic.open_float()<CR>", opt)
vim.keymap.set("n", "[d", ":lua vim.diagnostic.goto_prev()<CR>", opt)
vim.keymap.set("n", "]d", ":lua vim.diagnostic.goto_next()<CR>", opt)

local capabilities = cmp_lsp.default_capabilities()

local function on_attach(client)
  client.server_capabilities.documentFormattingProvider = false
end

-- bash
lspconfig.bashls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

-- typo
lspconfig.typos_lsp.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  init_options = {
    diagnosticSeverity = "Hint",
  },
}

-- Typescript
lspconfig.tsserver.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  init_options = {
    preferences = {
      -- other preferences...
      importModuleSpecifierPreference = "relative",
      importModuleSpecifierEnding = "minimal",
    },
  },
}

-- GraphQL
lspconfig.graphql.setup {
  filetypes = { "graphql", "gql" },
  on_attach = on_attach,
  capabilities = capabilities,
}

-- golang
lspconfig.gopls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}

-- Rust
lspconfig.rust_analyzer.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    ["rust-analyzer"] = {
      check = {
        command = "clippy",
      },
      diagnostics = {
        enable = true,
      },
    },
  },
}

-- lua
lspconfig.lua_ls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim" },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = "Disable",
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

-- Python
lspconfig.ruff_lsp.setup {
  capabilities = capabilities,
  on_attach = function(client)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.hover = false
    -- client.server_capabilities = false
  end,
  handlers = {
    ["textDocument/publishDiagnostics"] = function() end,
  },
}

lspconfig.pyright.setup {
  capabilities = capabilities,
  on_attach = function(client)
    client.server_capabilities.documentFormattingProvider = false
    vim.keymap.set("n", "<leader>oi", ":PyrightOrganizeImports<CR>", { noremap = true, silent = false })
  end,
  on_new_config = function(new_config, root_dir)
    local pipfile_exists = require("lspconfig").util.search_ancestors(root_dir, function(path)
      local pipfile = require("lspconfig").util.path.join(path, "Pipfile")
      if require("lspconfig").util.path.is_file(pipfile) then
        return true
      else
        return false
      end
    end)

    if pipfile_exists then
      new_config.cmd = { "pipenv", "run", "pyright-langserver", "--stdio" }
    end
  end,
}

-- java
lspconfig.jdtls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

-- Other
lspconfig.eslint.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

lspconfig.cssls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

lspconfig.tailwindcss.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

lspconfig.html.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

lspconfig.terraformls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
