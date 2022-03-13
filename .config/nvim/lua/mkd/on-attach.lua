return function(client, bufnr)
  -- So that the only client with format capabilities is efm
  if client.name ~= 'efm' then client.resolved_capabilities.document_formatting = false end

  if client.resolved_capabilities.document_formatting then

    vim.api.nvim_buf_set_keymap(bufnr, "n", "gll", ":lua vim.lsp.buf.formatting()<CR>",
                                {silent = false})
    -- vim.cmd [[
    --   augroup Format
    --     au! * <buffer>
    --     au BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 1000)
    --   augroup END
    -- ]]
  end
end
