syntax on
filetype plugin indent on

set backspace=indent,eol,start
set cmdheight=2
set cursorline
set encoding=utf-8
set expandtab
set hidden
set hlsearch
set ignorecase
set incsearch
set laststatus=2 " To show lightline
" set mouse=a
set nobackup
set nocompatible
set noswapfile
set nowrap
set nu
set number
set scrolloff=6
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
set undodir=~/.vim/undodir
set undofile
set updatetime=40
set wildmenu
set wildmode=list:longest,full

" Disable LSP feature for ALE in favour of Coc
" - this must happen before plugin loading
let g:ale_disable_lsp = 1

call plug#begin('~/.vim/plugged')
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-commentary'
  Plug 'machakann/vim-highlightedyank'
  Plug 'mbbill/undotree'
  Plug 'itchyny/lightline.vim'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'dense-analysis/ale'
  Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary' }
  Plug 'tpope/vim-dispatch'
  Plug 'tpope/vim-markdown'
  Plug 'simeji/winresizer'

  " Nav
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'justinmk/vim-sneak'
  Plug 'tpope/vim-vinegar'
  Plug 'tpope/vim-unimpaired'
  Plug 'junegunn/vim-peekaboo'

  " Color scheme
  Plug 'ulwlu/elly.vim'

  " git
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rhubarb'
  Plug 'airblade/vim-gitgutter'
  Plug 'junegunn/gv.vim'
  Plug 'stsewd/fzf-checkout.vim'

  " Rust
  Plug 'rust-lang/rust.vim'

  " JS/TS
  Plug 'pangloss/vim-javascript'
  Plug 'vim-test/vim-test'
  " Plug 'leafgarland/typescript-vim'
  Plug 'HerringtonDarkholme/yats.vim'
  Plug 'maxmellon/vim-jsx-pretty'
  Plug 'kristijanhusak/vim-js-file-import', {'do': 'npm install'}

  " GraphQL
  Plug 'jparise/vim-graphql'

  " Terraform
  Plug 'hashivim/vim-terraform'

  Plug 'soywod/himalaya', {'rtp': 'vim'}

call plug#end()

set t_Co=256
set background=dark
colorscheme elly
highlight CursorLine guibg=#0F1E23

" sneak highlight color
highlight Sneak guifg=black guibg=#FFD5D1

" Use new regular expression engine
set re=0

" Prevent losing colors in tmux
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

" ALE
let g:ale_linters_explicit = 1
let g:ale_fix_on_save = 1
let g:ale_lint_delay = 40
let g:ale_fixers = {
      \'*': ['remove_trailing_lines', 'trim_whitespace'],
      \'json': ['prettier'],
      \}

" COC
let g:coc_global_extensions = [
  \ 'coc-tsserver',
  \ 'coc-spell-checker',
  \ 'coc-rust-analyzer',
  \ ]

" Highlight yank duration
let g:highlightedyank_highlight_duration = 100

" Terraform and Packer
let g:terraform_align=1
let g:terraform_fmt_on_save=1
augroup filetype_hcl
  autocmd!
  au BufWritePre *.hcl :TerraformFmt
augroup END

" fzf layout
let g:fzf_layout = { 'down': '70%' }
let g:fzf_preview_window = ['up:65%', 'ctrl-/']

" ag
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'

" ag ignore match in file name
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, '--hidden', {'options': '--delimiter : --nth 4..'}, <bang>0)

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

" Show abbreviated relative file path
function! LightlineFilename()
  let name = ""
  let subs = split(expand('%'), "/")
  let i = 1
  for s in subs
    let parent = name
    if  i == len(subs)
      let name = parent . '/' . s
    elseif i == len(subs) - 1
      let name = parent . '/' . s
    else
      let name = parent . '/' . strpart(s, 0, 2)
    endif
    let i += 1
  endfor
  return name
endfunction

" Lightline layout
let g:lightline = {
      \ 'colorscheme': 'landscape',
      \ 'active': {
        \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'gitbranch', 'filename', 'gitgutter', 'aleStatus' ] ]
      \ },
      \ 'component_function': {
        \ 'filename': 'LightlineFilename',
        \ 'aleStatus': 'LinterStatus',
        \ 'gitgutter': 'GitStatus',
        \ 'gitbranch': 'FugitiveHead',
      \ },
      \ }


let mapleader = " "

" Save and quit
nnoremap <leader>w :up
nnoremap <leader>q :q
nnoremap <leader>wq :wq

" netrw
let g:netrw_liststyle=1
let g:netrw_browse_split=2
let g:netrw_banner=0
let g:netrw_winsize=40
nnoremap <c-n> :Vexplore<CR>

" Remove last highlight
nnoremap <Leader><space> :noh<cr>

" Undotree
nnoremap <leader>u :UndotreeToggle<CR>

" peekaboo
let g:peekaboo_window='vert bo 50new'

" ALE
nnoremap <leader>= :ALEFix<CR>
nnoremap ]a :ALENext<CR>zz
nnoremap [a :ALEPrevious<CR>zz

" Quickfixlist
nnoremap ]q :cnext<CR>zz
nnoremap [q :cprev<CR>zz
nnoremap [Q :<C-u>cfirst<CR>zz
nnoremap ]Q :<C-u>clast<CR>zz

" markdown note
let g:markdown_fenced_languages = ['html', 'python', 'javascript', 'bash=sh']
nnoremap <leader>no :e ~/Library/Mobile\ Documents/27N4MQEA55~pro~writer/Documents/vim-note.md<CR>

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

" Coc tsserver
nmap <leader>im :CocCommand tsserver.organizeImports<cr>
nmap <leader>if :CocCommand tsserver.executeAutofix<cr>

" Show documentation in preview window
nnoremap <silent> gh :call <SID>show_documentation()<CR>
function! s:show_documentation()
 if (index(['vim','help'], &filetype) >= 0)
   execute 'h '.expand('<cword>')
 else
   call CocAction('doHover')
 endif
endfunction

" Search
nnoremap <C-p> :Files<CR>
nnoremap <C-b> :Buffers<CR>
nnoremap <C-g> :Ag<CR>

" buffer resize
nnoremap <Leader>vi :resize +5<CR>
nnoremap <Leader>vd :resize -5<CR>
nnoremap <Leader>hi :vertical resize +5<CR>
nnoremap <Leader>hd :vertical resize -5<CR>

" Move line up/down
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" +register
nnoremap <leader>yy "+yy
vnoremap <leader>y "+y
nnoremap <leader>p "+p
vnoremap <leader>p "+p

vnoremap <leader>s :sort<CR>

" Fugitive
nmap <leader>gs :G<CR>
nmap <leader>gh :diffget //2<CR>
nmap <leader>gl :diffget //3<CR>
nmap <leader>gw :Gwrite <CR>

" Popup window scroll
" nnoremap <silent><nowait><expr> <C-e> coc#float#has_scroll() ? coc#float#scroll(1,2) : "\<C-e>"
" nnoremap <silent><nowait><expr> <C-y> coc#float#has_scroll() ? coc#float#scroll(0,2) : "\<C-y>"

function! ToggleQuickFix()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
        copen
    else
        cclose
    endif
endfunction

nnoremap <silent> <C-q> :call ToggleQuickFix()<CR>

" :Tsc adds compiler errors to quickfix list
command! -nargs=0 Tsc :call CocAction('runCommand', 'tsserver.watchBuild')

" copy file path
nnoremap <leader>cp :let @+ = expand("%")<cr>

" Jest file pattern matching 'test.db'
let g:test#javascript#jest#file_pattern = '\v(__tests__/.*|(spec|test|test.db))\.(js|jsx|ts|tsx)$'

" vim-test
let test#strategy = "vimterminal"
nmap <leader>tn :TestNearest<CR>
nmap <leader>tl :TestLast<CR>
nmap <leader>tf :TestFile<CR>
nmap <leader>tv :TestVisit<CR>

" window resize
let g:winresizer_start_key = '<C-z>'

nnoremap <leader>b :ls<CR> :b # <CR>

" disable syntax highlighting for large files
autocmd BufWinEnter * if line2byte(line("$") + 1) > 1000000 | syntax clear | endif

" Most recent buffer
nnoremap <leader>b :ls<CR> :b # <CR>

" horizontal scroll
nnoremap <S-P> 5zl " Scroll 5 characters to the right
nnoremap <S-H> 5zh " Scroll 5 characters to the left
