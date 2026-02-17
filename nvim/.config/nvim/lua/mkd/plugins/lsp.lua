return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "hrsh7th/nvim-cmp",
      "onsails/lspkind-nvim",
    },
    config = function()
      -- uncomment to see logs under .cache/
      -- vim.lsp.set_log_level("debug")
      local opt = { noremap = true, silent = false }
      vim.keymap.set("n", "gd", ":lua vim.lsp.buf.definition()<CR>", opt)
      vim.keymap.set("n", "K", ":lua vim.lsp.buf.signature_help()<CR>", opt)
      vim.keymap.set("n", "grc", ":lua vim.lsp.buf.code_action({ context = { only = {'source'} } })<CR>", opt)
      vim.keymap.set("n", "gh", ":lua vim.lsp.buf.hover()<CR>", opt)
      vim.keymap.set("n", "<leader>e", ":lua vim.diagnostic.open_float()<CR>", opt)
      vim.keymap.set("n", "[d", ":lua vim.diagnostic.goto_prev()<CR>", opt)
      vim.keymap.set("n", "]d", ":lua vim.diagnostic.goto_next()<CR>", opt)

      local function on_attach(client)
        client.server_capabilities.documentFormattingProvider = false
      end

      -- Postgres
      vim.lsp.config("postgres_lsp", {
        on_attach = on_attach,
      })

      -- Typos
      vim.lsp.config("typos_lsp", {
        on_attach = on_attach,
        init_options = {
          diagnosticSeverity = "Hint",
        },
      })

      -- Typescript
      -- NOTE: ts_ls repeatedly restarts the server when `tsconfig.json` has uncommitted changes
      vim.lsp.config("ts_ls", { on_attach = on_attach })

      -- GraphQL
      vim.lsp.config("graphql", {
        on_attach = on_attach,
        filetypes = { "graphql", "gql" },
      })

      -- Go
      vim.lsp.config("gopls", {
        on_attach = on_attach,
      })

      -- Rust
      vim.lsp.config("rust_analyzer", {
        on_attach = on_attach,
        settings = {
          ["rust-analyzer"] = {
            check = { command = "clippy" },
            diagnostics = { enable = true },
          },
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

      vim.lsp.config("sourcekit", {
        on_attach = on_attach,
      })

      -- Ruff
      vim.lsp.config("ruff", {
        on_attach = on_attach,
        -- silence diagnostics from ruff (if you prefer pyright/mypy etc.)
        handlers = {
          ["textDocument/publishDiagnostics"] = function() end,
        },
      })

      vim.lsp.config("basedpyright", {
        before_init = function(params, config)
          -- Try to find pipenv venv for the project root
          local root = params.rootPath
          if root then
            local venv = vim.fn.system("cd " .. root .. " && pipenv --venv 2>/dev/null"):gsub("\n", "")
            if venv ~= "" and vim.fn.isdirectory(venv) == 1 then
              config.settings = config.settings or {}
              config.settings.python = config.settings.python or {}
              config.settings.python.pythonPath = venv .. "/bin/python"
            end
          end
        end,
        settings = {
          basedpyright = {
            analysis = {
              autoSearchPaths = true,
              diagnosticMode = "openFilesOnly",
              exclude = { "**/*.ipynb" },
            },
          },
        },
      })

      -- Pyright (use Pipenv if a Pipfile exists upwards from root_dir)
      -- vim.lsp.config("pyright", {
      --   on_attach = on_attach,
      -- })

      -- Java
      -- vim.lsp.config("jdtls", {
      --   on_attach = on_attach,
      -- })

      -- ESLint
      -- vim.lsp.config("eslint", {
      --   -- on_attach = on_attach,
      -- })

      -- CSS
      -- vim.lsp.config("cssls", {
      --   on_attach = on_attach,
      -- })

      -- Tailwind
      -- vim.lsp.config("tailwindcss", {
      --   on_attach = on_attach,
      -- })

      -- HTML
      -- vim.lsp.config("html", {
      --   on_attach = on_attach,
      -- })

      -- Terraform
      -- vim.lsp.config("terraformls", {
      --   on_attach = on_attach,
      -- })

      vim.lsp.enable({
        "basedpyright",
        "bashls",
        "cssls",
        "eslint",
        "gopls",
        "graphql",
        "html",
        "jdtls",
        "lua_ls",
        "postgres_lsp",
        "rust_analyzer",
        "sourcekit",
        "tailwindcss",
        "terraformls",
        "ts_ls",
        "typos_lsp",
        -- "pyright",
        -- "ruff",
      })
    end,
  },
}
