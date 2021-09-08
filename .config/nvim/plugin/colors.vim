let g:my_colorscheme = "elly"

fun! Color()
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

    highlight CursorLine guibg=#001E2D
    highlight LineNr guifg=#243C43
    highlight qfFileName guifg=#74879C
    highlight Sneak guifg=#002335 guibg=#FFD5D1
    highlight MatchParen gui=bold,underline guibg=none guifg=none
endfun

call Color()
