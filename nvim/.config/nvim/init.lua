require "mkd"

-- Quickfixlist
vim.cmd [[
  function! ToggleQuickFix()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
      copen
    else
      cclose
    endif
  endfunction
  nnoremap <silent> <C-q> :call ToggleQuickFix()<CR>
]]

-- When using `dd` in the quickfix list, remove the item from the quickfix list.
vim.cmd [[
  function! RemoveQFItem()
  let curqfidx = line('.') - 1
  let qfall = getqflist()
  call remove(qfall, curqfidx)
  call setqflist(qfall, 'r')
  execute curqfidx + 1 . "cfirst"
  :copen
  endfunction
  :command! RemoveQFItem :call RemoveQFItem()
  autocmd FileType qf map <buffer> dd :RemoveQFItem<cr>
]]

vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  group = "YankHighlight",
  pattern = "*",
  callback = function()
    vim.highlight.on_yank {
      higroup = "Search",
      timeout = 40,
    }
  end,
})

local function slice_string_at_whitespace(input_string)
  -- slices the input string at the first occurrence of whitespaces
  local start_pos, _ = string.find(input_string, "%s%s%s+")
  if start_pos then
    return string.sub(input_string, 1, start_pos - 1)
  else
    return input_string
  end
end

local function open_with_preview()
  if vim.bo.filetype ~= "netrw" then
    print "Open with preview from netrw only."
    return
  end

  local line = vim.fn.getline "."
  local filename = slice_string_at_whitespace(line:match "^%s*(.-)%s*$")
  local file_under_cursor = vim.b.netrw_curdir .. "/" .. filename
  local extension = file_under_cursor:match "^.+(%..+)$"
  if
    extension == ".png"
    or extension == ".jpg"
    or extension == ".psd"
    or extension == ".tiff"
    or extension == ".pdf"
  then
    os.execute('open -a Preview "' .. file_under_cursor .. '"')
  else
    P "File extension not supported."
  end
end

vim.api.nvim_create_user_command("OpenPreview", open_with_preview, {})

local function tsNodeOnBuffer()
  local current_file_path = vim.api.nvim_buf_get_name(0)

  if current_file_path == "" then
    print "No file is currently open in the buffer."
    return
  end

  local output = vim.fn.system("ts-node " .. current_file_path)
  vim.cmd "split"
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(output, "\n"))
  vim.api.nvim_set_current_buf(buf)
end

vim.api.nvim_create_user_command("TSNode", tsNodeOnBuffer, {})

vim.keymap.set("n", "<leader><space>", function()
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients { bufnr = bufnr }

  local function run_conform()
    require("conform").format { bufnr = bufnr, async = true, lsp_fallback = false }
  end

  for _, client in ipairs(clients) do
    if client.name == "eslint" then
      vim.cmd "EslintFixAll"
      print "done :EslintFixAll"
      run_conform()
      return
    elseif client.server_capabilities.documentFormattingProvider then
      vim.lsp.buf.format {
        async = true,
        bufnr = bufnr,
        callback = function()
          run_conform()
        end,
      }
      return
    end
  end

  run_conform()
end, { noremap = true, silent = true })
