" keymap
nmap p <Plug>(yankround-p)
xmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap gp <Plug>(yankround-gp)
xmap gp <Plug>(yankround-gp)
nmap gP <Plug>(yankround-gP)
nmap <C-p> <Plug>(yankround-prev)
nmap <C-n> <Plug>(yankround-next)

" yankound history with unite.vim
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=yankound yankround<CR>

" highlight
let g:yankround_use_region_hl=1

" cache directory
let g:yankround_dir="~/.cache/yankround"
