let g:my_colorscheme = "elly"
fun! ColorMyPencils()
    if exists('+termguicolors')
        let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
        let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    endif

    set background=dark
    if has('nvim')
        call luaeval('vim.cmd("colorscheme " .. _A[1])', [g:my_colorscheme])
    else
        " TODO: What the way to use g:theprimeagen_colorscheme
        colorscheme elly
    endif

    " highlight Normal guibg=none
    highlight CursorLine guibg=#001E2D
    " highlight ColorColumn ctermbg=0 guibg=grey
    " highlight SignColumn guibg=none
    " highlight CursorLineNR guifg=red
    " highlight LineNr guifg=#5A5A5A
    " highlight netrwDir guifg=#5eacd3
    " highlight qfFileName guifg=#aed75f

    " sneak highlight color
    highlight Sneak guifg=#002335 guibg=#FFD5D1
endfun
call ColorMyPencils()
