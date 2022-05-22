" let g:my_colorscheme = "elly"
" let g:my_colorscheme = "gotham"
" let g:my_colorscheme = "kanagawa"
" let g:my_colorscheme = "melange"
let g:my_colorscheme = "gruvbit"

fun! Color()
    " if exists('+termguicolors')
    "     let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    "     let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    " endif

    set background=dark
    if has('nvim')
        call luaeval('vim.cmd("colorscheme " .. _A[1])', [g:my_colorscheme])
    else
        colorscheme elly
    endif

    highlight CursorLine guibg=none
    " highlight LineNr guifg=#243C43
    " highlight qfFileName guifg=#74879C
    highlight Sneak guifg=#002335 guibg=#FFD5D1
    highlight MatchParen gui=bold,underline guibg=none guifg=none
    highlight SpelunkerSpellBad gui=underline guifg=#DA1700
    " highlight GitSignsAdd guifg=#32A0B4
    " highlight GitSignsChange guifg=#E6B450
    " highlight GitSignsDelete guifg=#B40000
endfun

call Color()
