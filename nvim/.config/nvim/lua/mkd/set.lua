vim.o.background = "dark"
vim.o.backup = false
vim.o.cmdheight = 1
vim.o.colorcolumn = "80"
vim.o.cursorline = true
vim.o.expandtab = true
vim.o.guicursor = ""
vim.o.ignorecase = true
vim.o.incsearch = true
vim.o.jumpoptions = "view"
vim.o.nu = true
vim.o.relativenumber = true
vim.o.scrolloff = 4
vim.o.shiftwidth = 2
vim.o.sidescroll = 2
vim.o.signcolumn = "yes"
vim.o.smartcase = true
vim.o.smartindent = true
vim.o.softtabstop = 4
vim.o.swapfile = false
vim.o.tabstop = 4
vim.o.termguicolors = true
vim.o.undodir = os.getenv("HOME") .. "/.local/share/nvim/undodir"
vim.o.undofile = true
vim.o.winborder = "none"
vim.o.wrap = false

-- ripgrep for :grep
vim.o.grepformat = "%f:%l:%c:%m,%f:%l:%m"
vim.o.grepprg = "rg --smart-case --vimgrep"

-- netrw
vim.g.netrw_banner = 0
vim.g.netrw_browse_split = 2
vim.g.netrw_bufsettings = "noma nomod nu rnu nobl nowrap ro"
vim.g.netrw_liststyle = 1
vim.g.netrw_localrmdir = "rm -r"
vim.g.netrw_maxfilenamelen = 70
vim.g.netrw_winsize = 40

vim.g.markdown_fenced_languages = { "html", "python", "javascript", "typescript", "bash=sh" }

-- Use an expression-based fold, driven by Tree-sitter
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
-- Start with all folds open
vim.o.foldlevelstart = 99
vim.o.foldenable = true -- ensure folding is on
