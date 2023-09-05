vim.opt.backup = false
vim.opt.cmdheight = 1
vim.opt.colorcolumn = "80"
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.guicursor = ""
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.jumpoptions = "view"
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 4
vim.opt.shiftwidth = 2
vim.opt.sidescroll = 1
vim.opt.signcolumn = "yes"
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.softtabstop = 4
vim.opt.swapfile = false
vim.opt.tabstop = 4
vim.opt.termguicolors = true
vim.opt.undodir = os.getenv "HOME" .. "/.local/share/nvim/undodir"
vim.opt.undofile = true
vim.opt.updatetime = 40
vim.opt.wrap = false

-- ripgrep for :grep
vim.opt.grepprg = "rg --smart-case --vimgrep"
vim.opt.grepformat = "%f:%l:%c:%m,%f:%l:%m"

-- netrw
vim.g.netrw_liststyle = 1
vim.g.netrw_browse_split = 2
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 40
vim.g.netrw_maxfilenamelen = 65
vim.g.netrw_localrmdir = "rm -r"

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = false
