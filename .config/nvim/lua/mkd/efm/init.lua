local lspconfig = require('lspconfig')
local on_attach = require('mkd.on-attach')

-- eslint
local eslint = {
  lintCommand = 'eslint_d -f visualstudio --stdin --stdin-filename ${INPUT}',
  lintStdin = true,
  lintIgnoreExitCode = true,
  lintFormats = {"%f(%l,%c): %tarning %m", "%f(%l,%c): %rror %m"},
  formatCommand = 'eslint_d --fix-to-stdout --stdin --stdin-filename ${INPUT}',
  formatStdin = true
}

local prettier = {
  formatCommand = 'prettier --find-config-path --stdin-filepath ${INPUT}',
  formatStdin = true
}

local efm_config = os.getenv('HOME') .. '/.config/nvim/lua/mkd/efm/config.yaml'
local efm_log_dir = '/tmp/'
local efm_root_markers = {'package.json', '.git/', '.zshrc'}
local efm_languages = {
  css = {prettier},
  graphql = {prettier},
  html = {prettier},
  javascript = {eslint},
  javascriptreact = {eslint},
  json = {prettier},
  markdown = {prettier},
  typescript = {eslint},
  typescriptreact = {eslint},
  yaml = {prettier}
}

-- lspconfig.efm.setup({
--   cmd = {"efm-langserver", "-c", efm_config, "-logfile", efm_log_dir .. "efm.log"},
--   filetypes = {
--     'javascript', 'javascriptreact', 'typescript', 'typescriptreact', "json", "graphql", "html",
--     "yaml", "markdown"
--   },
--   on_attach = on_attach,
--   root_dir = lspconfig.util.root_pattern(unpack(efm_root_markers)),
--   init_options = {documentFormatting = true},
--   settings = {rootMarkers = efm_root_markers, languages = efm_languages}
-- })
