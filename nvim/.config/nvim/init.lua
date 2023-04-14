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

-- populate args with files in quickfixlist with 'Qargs'
-- vim.cmd [[
-- command! -nargs=0 -bar Qargs execute 'args ' . QuickfixFilenames()
-- function! QuickfixFilenames()
--   let buffer_numbers = {}
--   for quickfix_item in getqflist()
--     let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
--   endfor
--   return join(values(buffer_numbers))
-- endfunction
-- ]]

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
