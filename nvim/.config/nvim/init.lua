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

vim.api.nvim_create_autocmd("TextYankPost", {
  group = yank_group,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank {
      higroup = "Search",
      timeout = 40,
    }
  end,
})
