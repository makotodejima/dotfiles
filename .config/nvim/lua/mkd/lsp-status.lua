local M = {}

local function dump(o)
  if type(o) == 'table' then
    local s = '{ '
    for k, v in pairs(o) do
      if type(k) ~= 'number' then k = '"' .. k .. '"' end
      s = s .. '[' .. k .. '] = ' .. dump(v) .. ','
    end
    return s .. '} '
  else
    return tostring(o)
  end
end

M.lsp_client_names = function()
  -- Get all active clients in the buffer
  local clients = vim.lsp.buf_get_clients()
  local client_names = {}

  -- Return "main" client
  for _, client in pairs(clients) do
    if #clients == 1 then
      return client.name
    else
      if client.name ~= "null-ls" then return client.name end
    end
  end
end

M.lsp_status = function()
  -- https://github.com/samrath2007/kyoto.nvim/blob/main/lua/plugins/statusline.lua
  local lsp_status = vim.lsp.util.get_progress_messages()[1]
  -- print("status: ", dump( vim.lsp.util.get_progress_messages() ))
  local client_names = M.lsp_client_names()

  -- Show client if client has been loaded
  if not lsp_status then return client_names or "" end

  -- Show client status
  local status =
      ((lsp_status.percentage and (lsp_status.percentage .. "%% ")) or lsp_status.message)
  return (status and (status .. lsp_status.title) or lsp_status.title) or ""
end

return M
