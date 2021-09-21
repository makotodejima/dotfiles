syntax on
filetype plugin indent on

set backspace=indent,eol,start
set cmdheight=2
set cursorline
set encoding=utf-8
set expandtab
set exrc
set guicursor=
set hidden
set hlsearch
set ignorecase
set incsearch
set nobackup
set nocompatible
set noswapfile
set nowrap
set nu
set scrolloff=6
set secure
set shiftwidth=2
set shortmess-=S
set showcmd
set sidescroll=1
set signcolumn=yes
set smartcase
set smartindent
set softtabstop=2
set termguicolors
set timeoutlen=1000 ttimeoutlen=0
set undodir=~/.config/nvim/undodir
set undofile
set updatetime=40
set wildmenu
set wildmode=list:longest,full

" let &verbose = 1

call plug#begin()
  Plug 'hoob3rt/lualine.nvim'
  Plug 'mbbill/undotree'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'tpope/vim-abolish'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-dispatch'
  Plug 'tpope/vim-surround'

  " Spell - ZT to toggle
  Plug 'kamykn/spelunker.vim'

  " Linter
  Plug 'sbdchd/neoformat'

  " LSP
  Plug 'neovim/nvim-lsp'
  Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'

  " Completion
  Plug 'hrsh7th/nvim-compe'

  " Color
  Plug 'ulwlu/elly.vim'
  " Plug 'gruvbox-community/gruvbox'

  " git
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rhubarb'
  Plug 'junegunn/gv.vim'
  Plug 'lewis6991/gitsigns.nvim'

  " telescope requirements
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  " Plug 'nvim-telescope/telescope.nvim'

  " fzf
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'stsewd/fzf-checkout.vim'

  " navigation
  Plug 'justinmk/vim-sneak'
  Plug 'tpope/vim-vinegar'
  Plug 'tpope/vim-unimpaired'
  Plug 'aserowy/tmux.nvim'

  " harpoon man
  Plug 'ThePrimeagen/harpoon'

  " lang
  Plug 'tpope/vim-markdown'
  Plug 'jparise/vim-graphql'

  " test
  Plug 'vim-test/vim-test'
call plug#end()

let mapleader = " "

" no idea - fix color in tmux
set t_Co=256

" Use new regular expression engine
set re=0

lua require("mkd")
lua require'nvim-treesitter.configs'.setup { indent = { enable = true }, highlight = { enable = true }, incremental_selection = { enable = true, keymaps = { node_incremental = 'ii', node_decremental = 'II' } } }

" Spell - default off
let g:enable_spelunker_vim = 0

" Neoformat
nnoremap <leader><space> :Neoformat<cr>

" Search
nnoremap <C-p> :Files<CR>
nnoremap <C-b> :Buffers<CR>
nnoremap <C-g> :Ag<CR>

" fzf layout
let g:fzf_layout = { 'down': '70%' }
let g:fzf_preview_window = ['up:65%', 'ctrl-/']

" fzf checkout
nnoremap <leader>gc :GBranches<CR>

" ag
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'

" ag ignore match in file name
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, '--hidden', {'options': '--delimiter : --nth 4..'}, <bang>0)


" Save and quit
nnoremap <leader>w :up
nnoremap <leader>q :q
nnoremap <leader>wq :wq

" Remove last highlight
nnoremap <Leader>cl :noh<cr>

" Quickfixlist
nnoremap ]q :cnext<CR>zz
nnoremap [q :cprev<CR>zz
nnoremap [Q :<C-u>cfirst<CR>zz
nnoremap ]Q :<C-u>clast<CR>zz

" Move line up/down
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

nnoremap Y y$
nnoremap n nzzzv
nnoremap N Nzzzv

inoremap , ,<C-g>u
inoremap . .<C-g>u

" +register
nnoremap <leader>yy "+yy
vnoremap <leader>y "+y
nnoremap <leader>p "+p
vnoremap <leader>p "+p
vnoremap <leader>jp "_dP

vnoremap <leader>s :sort<CR>

" netrw
let g:netrw_liststyle=1
let g:netrw_browse_split=2
let g:netrw_banner=0
let g:netrw_winsize=40
let g:netrw_localrmdir='rm -r'
nnoremap <leader>vs :vsplit<CR>

" Quickfixlist
function! ToggleQuickFix()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
        copen
    else
        cclose
    endif
endfunction
nnoremap <silent> <C-q> :call ToggleQuickFix()<CR>

" Most recent buffer
nnoremap <leader>b :ls<CR> :b # <CR>

" copy file path
nnoremap <leader>cp :let @+ = expand("%")<cr>

augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 30})
augroup END

" disable syntax highlighting for large files
autocmd BufWinEnter * if line2byte(line("$") + 1) > 1000000 | syntax clear | endif

" Undotree
nnoremap <leader>u :UndotreeToggle<CR>

" markdown note
let g:markdown_fenced_languages = ['html', 'python', 'javascript', 'bash=sh']
nnoremap <leader>no :e ~/Library/Mobile\ Documents/27N4MQEA55~pro~writer/Documents/vim-note.md<CR>

" Jest file pattern matching 'test.db'
let g:test#javascript#jest#file_pattern = '\v(__tests__/.*|(spec|test|test.db))\.(js|jsx|ts|tsx)$'
let test#neovim#term_position = "vert"

" vim-test
let test#strategy = "neovim"
nmap <leader>tn :TestNearest<CR>
nmap <leader>tl :TestLast<CR>
nmap <leader>tf :TestFile<CR>
nmap <leader>tv :TestVisit<CR>

" terminal normal mode
tnoremap <C-o> <C-\><C-n>

" populate args with files in quickfixlist with 'Qargs'
command! -nargs=0 -bar Qargs execute 'args ' . QuickfixFilenames()
function! QuickfixFilenames()
  let buffer_numbers = {}
  for quickfix_item in getqflist()
    let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
  endfor
  return join(values(buffer_numbers))
endfunction

" harpoon man
nnoremap <leader>hh :lua require("harpoon.mark").add_file()<CR>
nnoremap <leader>a :lua require("harpoon.ui").nav_file(1)<CR>
nnoremap <leader>s :lua require("harpoon.ui").nav_file(2)<CR>
nnoremap <leader>d :lua require("harpoon.ui").nav_file(3)<CR>
nnoremap <leader>f :lua require("harpoon.ui").nav_file(4)<CR>
nnoremap <leader>hl :lua require("harpoon.ui").toggle_quick_menu()<CR>

lua <<EOF
local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.hcl_mictchellh = {
  install_info = {
    url = "./tree-sitter-hcl", -- local path or git repo
    files = { "src/parser.c" }
  },
  filetype = "tf", -- if filetype does not agrees with parser name
  used_by = {"tf", "hcl"} -- additional filetypes that use this parser
}
EOF
