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

local function open_with_preview()
  -- Check if the current buffer is netrw
  if vim.bo.filetype == "netrw" then
    local line = vim.fn.getline "."
    local filename = line:match "^[^%s]+"
    local file_under_cursor = vim.fn.expand "%:p" .. filename
    os.execute('open -a Preview "' .. file_under_cursor .. '"')
  else
    local file_under_cursor = vim.fn.expand "<cfile>"
    os.execute('open -a Preview "' .. file_under_cursor .. '"')
  end
end

vim.api.nvim_create_user_command("OpenPreview", open_with_preview, {})
