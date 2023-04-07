local a = require "plenary.async"
local p = require "plenary.path"

local path = os.getenv "HOME" .. "/.config/nvim/lua/mkd/null-ls/cspell.json"

M = {}

function M.add_selection()
  local selection = M.get_visual_selection()
  a.run(function()
    M.add(selection)
  end, function()
    print("'" .. selection .. "'" .. " added to the list")
  end)
end

function M.add(word)
  local _, fd = a.uv.fs_open(path, "r", 438)
  local _, stat = a.uv.fs_fstat(fd)
  local err, data = a.uv.fs_read(fd, stat.size, 0)
  assert(not err, err)
  local json = vim.json.decode(data)
  table.insert(json["words"], word)
  p.new(path):write(vim.json.encode(json), "w")
end

function M.get_visual_selection()
  local s_start = vim.fn.getpos "'<"
  local s_end = vim.fn.getpos "'>"
  local n_lines = math.abs(s_end[2] - s_start[2]) + 1
  local lines = vim.api.nvim_buf_get_lines(0, s_start[2] - 1, s_end[2], false)
  lines[1] = string.sub(lines[1], s_start[3], -1)
  if n_lines == 1 then
    lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3] - s_start[3] + 1)
  else
    lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3])
  end
  return table.concat(lines, "\n")
end

local function dump(o)
  if type(o) == "table" then
    local s = "{ "
    for k, v in pairs(o) do
      if type(k) ~= "number" then
        k = '"' .. k .. '"'
      end
      s = s .. "[" .. k .. "] = " .. dump(v) .. ","
    end
    return s .. "} "
  else
    return tostring(o)
  end
end

return M
