set completeopt=menuone,noinsert,noselect
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

nnoremap gd :lua vim.lsp.buf.definition()<CR>
nnoremap gi :lua vim.lsp.buf.implementation()<CR>
nnoremap <leader>k :lua vim.lsp.buf.signature_help()<CR>
nnoremap gr :lua vim.lsp.buf.references()<CR>
nnoremap gt :lua vim.lsp.buf.type_definition()<CR>
nnoremap <leader>rn :lua vim.lsp.buf.rename()<CR>
nnoremap <leader>ca :lua vim.lsp.buf.code_action()<CR>
nnoremap gh :lua vim.lsp.buf.hover()<CR>
nnoremap <leader>e :lua vim.lsp.diagnostic.show_line_diagnostics()<CR>
nnoremap [d :lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap ]d :lua vim.lsp.diagnostic.goto_next()<CR>
" nnoremap :lua vim.lsp.buf.formatting()<CR>
