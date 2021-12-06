local lspconfig = require('lspconfig')

-- eslint
local eslint = {
  lintCommand = 'eslint_d -f visualstudio --stdin --stdin-filename ${INPUT}',
  lintStdin = true,
  lintIgnoreExitCode = true,
  lintFormats = {"%f(%l,%c): %tarning %m", "%f(%l,%c): %rror %m"}
}

local prettier = {
  formatCommand = 'prettier --find-config-path --stdin-filepath ${INPUT}',
  formatStdin = true
}

local efm_config = os.getenv('HOME') .. '/.config/nvim/lua/mkd/efm/config.yaml'
local efm_log_dir = '/tmp/'
local efm_root_markers = {'package.json', '.git/', '.zshrc'}
local efm_languages = {
  yaml = {prettier},
  json = {prettier},
  markdown = {prettier},
  javascript = {eslint, prettier},
  javascriptreact = {eslint, prettier},
  typescript = {eslint, prettier},
  typescriptreact = {eslint, prettier},
  css = {prettier},
  scss = {prettier},
  sass = {prettier},
  less = {prettier},
  graphql = {prettier},
  html = {prettier}
}

lspconfig.efm.setup({
  cmd = {"efm-langserver", "-c", efm_config, "-logfile", efm_log_dir .. "efm.log"},
  filetype = {'javascript', 'javascriptreact', 'typescript', 'typescriptreact'},
  on_attach = on_attach,
  root_dir = lspconfig.util.root_pattern(unpack(efm_root_markers)),
  init_options = {documentFormatting = false},
  settings = {rootMarkers = efm_root_markers, languages = efm_languages}
})
