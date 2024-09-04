vim.opt.background = "dark"
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
vim.opt.wrap = false

-- ripgrep for :grep
vim.opt.grepformat = "%f:%l:%c:%m,%f:%l:%m"
vim.opt.grepprg = "rg --smart-case --vimgrep"

-- netrw
vim.g.netrw_banner = 0
vim.g.netrw_browse_split = 2
vim.g.netrw_bufsettings = "noma nomod nu rnu nobl nowrap ro"
vim.g.netrw_liststyle = 1
vim.g.netrw_localrmdir = "rm -r"
vim.g.netrw_maxfilenamelen = 70
vim.g.netrw_winsize = 40

vim.g.markdown_fenced_languages = { "html", "python", "javascript", "bash=sh" }
