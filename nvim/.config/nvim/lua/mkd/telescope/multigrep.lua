local M = {}

local conf = require("telescope.config").values
local finders = require "telescope.finders"
local make_entry = require "telescope.make_entry"
local pickers = require "telescope.pickers"

local flatten = vim.tbl_flatten

local multigrep = function(opts)
  opts = opts or {}
  opts.cwd = opts.cwd and vim.fn.expand(opts.cwd) or vim.loop.cwd()
  opts.shortcuts = opts.shortcuts
    or {
      ["l"] = "*.lua",
      ["v"] = "*.vim",
      ["n"] = "*.{vim,lua}",
      ["c"] = "*.c",
      ["r"] = "*.rs",
      ["g"] = "*.{go,graphql}",
      ["t"] = "*.{ts,tsx}",
      ["j"] = "*.{js,jsx}",
      ["p"] = "*.py",
      ["-t"] = "!**/*test*",
    }
  opts.pattern = opts.pattern or "%s"

  local custom_grep = finders.new_async_job {
    command_generator = function(prompt)
      if not prompt or prompt == "" then
        return nil
      end

      local prompt_split = vim.split(prompt, "  ", { limit = 2 })

      local args = { "rg" }
      if prompt_split[1] then
        if prompt_split[1] == "F" then
          table.insert(args, "-F")
        else
          table.insert(args, "-e")
          table.insert(args, prompt_split[1])
        end
      end

      if prompt_split[2] then
        local pattern
        if opts.shortcuts[prompt_split[2]] then
          table.insert(args, "-g")
          pattern = opts.shortcuts[prompt_split[2]]
        else
          pattern = prompt_split[2]
        end

        table.insert(args, string.format(opts.pattern, pattern))
      end

      table.insert(args, "--glob")
      table.insert(args, "!*lock.json")
      table.insert(args, "--glob")
      table.insert(args, "!*.lock")
      table.insert(args, "--glob")
      table.insert(args, "!*lock.yaml")

      return flatten {
        args,
        {
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--hidden",
        },
      }
    end,
    entry_maker = make_entry.gen_from_vimgrep(opts),
    cwd = opts.cwd,
  }

  pickers
    .new(opts, {
      debounce = 100,
      prompt_title = "F for literal. Shortcuts: <double-space> <t,j,p,c,r,g,v,l,n,-t(-test)>",
      finder = custom_grep,
      previewer = conf.grep_previewer(opts),
      sorter = require("telescope.sorters").empty(),
    })
    :find()
end

M.run = function()
  multigrep {}
end

return M
