syntax on
filetype plugin indent on

" let &verbose = 1

set backspace=indent,eol,start
set cmdheight=1
set cursorline
set encoding=utf-8
set expandtab
set exrc
set guicursor=
set hidden
set hlsearch
set ignorecase
set incsearch
set mouse=a
set nobackup
set nocompatible
set noswapfile
set nowrap
set nu rnu
set scrolloff=4
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

call plug#begin()
  " theme
  Plug 'rebelot/kanagawa.nvim'
  Plug 'habamax/vim-gruvbit'
  Plug 'fenetikm/falcon'
  Plug 'norcalli/nvim-colorizer.lua'
  Plug 'kvrohit/rasmus.nvim'
  Plug 'rose-pine/neovim'
  Plug 'kdheepak/monochrome.nvim'
  Plug 'Yazeed1s/oh-lucy.nvim'
  Plug 'olivercederborg/poimandres.nvim'
  Plug 'goolord/alpha-nvim'

  " statusline/winbar
  Plug 'hoob3rt/lualine.nvim'

  " treesitter
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'nvim-treesitter/playground'
  Plug 'nvim-treesitter/nvim-treesitter-textobjects'
  Plug 'RRethy/nvim-treesitter-textsubjects'

  " tpope
  Plug 'tpope/vim-abolish'
  Plug 'tpope/vim-dispatch'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-vinegar'
  Plug 'tpope/vim-unimpaired'

  " LSP
  Plug 'neovim/nvim-lsp'
  Plug 'jose-elias-alvarez/typescript.nvim'
  Plug 'onsails/lspkind-nvim'
  Plug 'j-hui/fidget.nvim'
  Plug 'jose-elias-alvarez/null-ls.nvim'
  Plug 'simrat39/rust-tools.nvim'

  " cmp
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
  Plug 'hrsh7th/vim-vsnip'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-cmdline'
  Plug 'andersevenrud/cmp-tmux'
  Plug 'github/copilot.vim'

  " git
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rhubarb' 
  Plug 'junegunn/gv.vim'
  Plug 'lewis6991/gitsigns.nvim'
  Plug 'sindrets/diffview.nvim'
  Plug 'ThePrimeagen/git-worktree.nvim'

  " telescope
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
  Plug 'nvim-telescope/telescope-dap.nvim'

  " utils
  Plug 'mbbill/undotree'
  Plug 'JoosepAlviste/nvim-ts-context-commentstring'
  Plug 'chentoast/marks.nvim'
  Plug 'gbprod/yanky.nvim'
  Plug 'folke/todo-comments.nvim'
  Plug 'numToStr/Comment.nvim'

  " registers
  Plug 'AckslD/nvim-neoclip.lua'
  Plug 'tami5/sqlite.lua'

  " navigation
  Plug 'justinmk/vim-sneak'
  Plug 'aserowy/tmux.nvim'

  " harpoon man
  Plug 'ThePrimeagen/harpoon'
  Plug 'ThePrimeagen/refactoring.nvim'

  " test
  Plug 'David-Kunz/jester'
  Plug 'mfussenegger/nvim-dap'
call plug#end()

let mapleader = " "

" Use new regular expression engine
" set re=0

lua require("mkd")

" Save and quit
nnoremap <leader>w :up
nnoremap <leader>q :q
nnoremap <leader>wq :wq

" Remove last highlight
nnoremap <Leader>l :noh<cr>

" Quickfixlist
nnoremap ]q :cnext<CR>zz
nnoremap [q :cprev<CR>zz
nnoremap [Q :<C-u>cfirst<CR>zz
nnoremap ]Q :<C-u>clast<CR>zz

" Move line up/down
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Select same lines after >ed
vnoremap >> >gv
vnoremap << <gv

nnoremap Y y$

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
let g:netrw_maxfilenamelen=65
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
  autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 10})
augroup END

" disable syntax highlighting for large files
autocmd BufWinEnter * if line2byte(line("$") + 1) > 1000000 | syntax clear | endif

" Undotree
nnoremap <leader>u :UndotreeToggle<CR>

" markdown note
let g:markdown_fenced_languages = ['html', 'python', 'javascript', 'bash=sh']

" Jest file pattern matching 'test.db'
let g:test#javascript#jest#file_pattern = '\v(__tests__/.*|(spec|test|test.db))\.(js|jsx|ts|tsx)$'
let test#neovim#term_position = "vert"

" vim-test
" let test#strategy = "neovim"
nmap <leader>tn :lua require"jester".run({path_to_jest='./node_modules/jest/bin/jest.js'})<CR>
nmap <leader>tf :lua require"jester".run_file({path_to_jest='./node_modules/jest/bin/jest.js'})<CR>

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
nnoremap <leader>hl :lua require("harpoon.ui").toggle_quick_menu()<CR>

" Use ripgrep for :grep
if executable("rg")
  set grepprg=rg\ --smart-case\ --vimgrep
  set grepformat=%f:%l:%c:%m,%f:%l:%m
endif
