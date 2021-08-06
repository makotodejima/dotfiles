
" lua << EOF
" local actions = require('telescope.actions')
" require('telescope').setup{
"   defaults = {
"     -- layout_strategy = "vertical",
"     -- width = 0.94,
"     preview_cutoff = 120,
"     results_height = 12,
"     results_width = 0.8,
"     mappings = {
"       i = {
"         ["<C-a>"] = actions.send_selected_to_qflist,
"       },
"     }
"   }
"
" }
"
" EOF

" Find files using Telescope command-line sugar.
" nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
" nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
" nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
" nnoremap <leader>fr <cmd>lua require('telescope.builtin').lsp_references()<cr>
" nnoremap <leader>fh <cmd>lua require('telescope.builtin').quickfix()<cr>
" nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
