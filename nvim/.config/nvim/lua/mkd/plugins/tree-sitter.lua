vim.pack.add({
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
}, {
  confirm = false,
  -- Temporary while lazy.nvim still owns startup: it sources plugin scripts
  -- from these runtime paths. Change this to true at the final cutover.
  load = false,
})

local ts = require("nvim-treesitter")
local langs = {
  "bash",
  "comment",
  "cpp",
  "css",
  "diff",
  "dockerfile",
  "git_config",
  "git_rebase",
  "gitattributes",
  "gitcommit",
  "gitignore",
  "go",
  "graphql",
  "hcl",
  "html",
  "hurl",
  "javascript",
  "jsdoc",
  "json",
  "lua",
  "make",
  "markdown",
  "python",
  "rust",
  "sql",
  "terraform",
  "todotxt",
  "toml",
  "tsx",
  "typescript",
  "vim",
  "xml",
  "yaml",
}

-- State tracking for async parser loading
local parsers_loaded = {}
local parsers_pending = {}
local parsers_pending_keys = {}
local parsers_failed = {}

local ns = vim.api.nvim_create_namespace("treesitter.async")

-- Helper to start highlighting and indentation
local function start(buf, lang)
  local ok = pcall(vim.treesitter.start, buf, lang)
  if ok then
    vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end
  return ok
end

local function get_supported_lang(filetype)
  local lang = vim.treesitter.language.get_lang(filetype) or filetype
  if not vim.tbl_contains(langs, lang) then
    return nil
  end
  return lang
end

local function queue_parser(buf, lang)
  local key = ("%s:%s"):format(buf, lang)
  if parsers_pending_keys[key] then
    return
  end

  parsers_pending_keys[key] = true
  table.insert(parsers_pending, { buf = buf, lang = lang, key = key })
end

-- Install core parsers once the editor is up (was hooked on LazyDone before
-- the vim.pack migration)
vim.api.nvim_create_autocmd("VimEnter", {
  once = true,
  callback = function()
    ts.install(langs, {
      max_jobs = 8,
    })
  end,
})

-- Decoration provider for async parser loading
vim.api.nvim_set_decoration_provider(ns, {
  on_start = vim.schedule_wrap(function()
    if #parsers_pending == 0 then
      return false
    end
    for _, data in ipairs(parsers_pending) do
      parsers_pending_keys[data.key] = nil
      if vim.api.nvim_buf_is_valid(data.buf) then
        if start(data.buf, data.lang) then
          parsers_loaded[data.lang] = true
        else
          parsers_failed[data.lang] = true
        end
      end
    end
    parsers_pending = {}
  end),
})

local group = vim.api.nvim_create_augroup("TreesitterSetup", { clear = true })

-- Auto-install parsers and enable highlighting on FileType
vim.api.nvim_create_autocmd("FileType", {
  group = group,
  desc = "Enable treesitter highlighting and indentation (non-blocking)",
  callback = function(event)
    local lang = get_supported_lang(event.match)
    local buf = event.buf

    if not lang then
      return
    end

    if parsers_failed[lang] then
      return
    end

    if parsers_loaded[lang] then
      -- Parser already loaded, start immediately (fast path)
      start(buf, lang)
    else
      -- Queue for async loading
      queue_parser(buf, lang)
    end

    -- Auto-install missing parsers (async, no-op if already installed)
    ts.install({ lang })
  end,
})

-- lazy.nvim expects every imported module to return a table of specs. This
-- plugin is now owned by vim.pack, so this module contributes none.
return {}
