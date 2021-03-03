syntax on

set backspace=indent,eol,start
set clipboard=unnamed
set cmdheight=2
set cursorline
set encoding=utf-8
set expandtab
set hidden
set hlsearch
set ignorecase
set incsearch
set laststatus=2 " To show lightline
set nobackup
set nocompatible
set noswapfile
set nowrap
set nu
set number
set scrolloff=6
set shiftwidth=2
set signcolumn=yes
set smartcase
set smartindent
set softtabstop=2
set termguicolors
set timeoutlen=1000 ttimeoutlen=0
set undodir=~/.vim/undodir
set undofile
set updatetime=50
set wildmenu
set wildmode=list:longest,full

" Disable LSP feature for ALE in favour of Coc 
" - this must happen before plugin loading
let g:ale_disable_lsp = 1

call plug#begin('~/.vim/plugged')
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'tpope/vim-vinegar'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-fugitive'
  Plug 'airblade/vim-gitgutter'
  Plug 'junegunn/gv.vim'
  Plug 'stsewd/fzf-checkout.vim'
  Plug 'justinmk/vim-sneak'
  Plug 'machakann/vim-highlightedyank'
  Plug 'itchyny/lightline.vim'
  Plug 'dense-analysis/ale'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'pangloss/vim-javascript'
  Plug 'leafgarland/typescript-vim'
  Plug 'maxmellon/vim-jsx-pretty' 
  Plug 'mbbill/undotree'
  Plug 'kristijanhusak/vim-js-file-import', {'do': 'npm install'}
  Plug 'ulwlu/elly.vim'
call plug#end()

set t_Co=256
set background=dark
colorscheme elly
highlight CursorLine guibg=#18282D 
highlight CursorLineNr guibg=#18282D 

" ALE linters
let g:ale_linters = {
      \'javascript': ['prettier', 'eslint'], 
      \'typescript': ['tslint'],
      \'typescriptreact': ['tslint'],
      \'json': ['prettier'],
      \}

" ALE fixers
let g:ale_fixers = {
      \'javascript': ['prettier', 'eslint'], 
      \'typescript': ['tslint'],
      \'typescriptreact': ['tslint'],
      \'json': ['prettier'],
      \}

" ALE auto fix
let g:ale_fix_on_save = 1
let g:ale_lint_delay = 40

" Coc config
let g:coc_global_extensions = [
  \ 'coc-tsserver',
  \ 'coc-spell-checker',
  \ ]

" Highlight yank duration
let g:highlightedyank_highlight_duration = 100

" ag
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'

" ag ignore matches in file name
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)

" GitGutter statusline
function! GitStatus()
  let [a,m,r] = GitGutterGetHunkSummary()
  return printf('+%d ~%d -%d', a, m, r)
endfunction

" ALE linter status
function! LinterStatus() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? 'OK' : printf(
        \   '%dW %dE',
        \   all_non_errors,
        \   all_errors
        \)
endfunction

" Show file path relative to project root
function! LightlineFilename()
  let root = fnamemodify(get(b:, 'git_dir'), ':h')
  let path = expand('%:p')
  if path[:len(root)-1] ==# root
    return path[len(root)+1:]
  endif
  return expand('%')
endfunction

" Lightline layout
let g:lightline = {
      \ 'colorscheme': 'landscape',
      \ 'active': {
        \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'gitbranch', 'gitgutter', 'aleStatus'] ]
      \ },
      \ 'component_function': { 
        \ 'filename': 'LightlineFilename',
        \ 'aleStatus': 'LinterStatus',
        \ 'gitbranch': 'FugitiveHead',
        \ 'gitgutter': 'GitStatus'
      \ },
      \ }

let mapleader = " "

" Save and quit
nmap <leader>w :w<cr>
nmap <leader>q :q<cr>

" Undotree
nnoremap <leader>u :UndotreeToggle<CR>

" Lint file
nnoremap <leader>= :ALEFix<CR>

" Navigate Coc completion list with Tab key
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"

" Coc gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gt <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Coc codeActions
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Coc trigger autocomplete
inoremap <silent><expr> <C-k> coc#refresh()

" Import order
nmap <leader>im :CocCommand tsserver.organizeImports<cr>

" K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
 if (index(['vim','help'], &filetype) >= 0)
   execute 'h '.expand('<cword>')
 else
   call CocAction('doHover')
 endif
endfunction

" netrw
let g:netrw_liststyle = 1
let g:netrw_browse_split=2
let g:netrw_banner=0
let g:netrw_winsize=25
nnoremap <c-n> :Vexplore<CR>

" Remove last highlight
nnoremap <Leader><space> :noh<cr>

" Search
nnoremap <C-p> :Files<CR>
nnoremap <C-b> :Buffers<CR>
nnoremap <C-g> :Ag<CR>

" buffer resize
nnoremap <Leader>+ :resize +5<CR>
nnoremap <Leader>- :resize -5<CR>
nnoremap <Leader>< :vertical resize +5<CR>
nnoremap <Leader>> :vertical resize -5<CR>

" Move line up/down
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
