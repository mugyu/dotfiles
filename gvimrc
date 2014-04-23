scriptencoding utf-8
" vim:set ts=8 sts=2 sw=2 tw=0 foldmethod=marker:
" (上記の行に関しては:help modelineを参照)
"
" Kariya Vim の $VIM/gvimrc を先読みしている前提の設定です。
"
" Last Change: 24-Apr-2014.


"---------------------------------------------------------------------------
" フォント設定:
"
"{{{
if has('win32')
  "set guifont=MS_Gothic:h10.5
  let &guifont = 'Osaka－等幅:h10.5'
endif
"}}}

"---------------------------------------------------------------------------
" ウインドウに関する設定:
"
"{{{
colorscheme molokai
"let g:molokai_original = 1
let g:rehash256 = 1
set background=dark
"}}}

"---------------------------------------------------------------------------
" 日本語入力に関する設定:
"
"{{{
if has('multi_byte_ime') || has('xim')
  " IME ON時のカーソルの色を設定
  highlight CursorIM guibg=Yellow guifg=NONE
  " 挿入モードでのIME状態を記憶させない場合、次行のコメントを解除
  inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>
endif
"}}}

"---------------------------------------------------------------------------
" メニューに関する設定:
"
"{{{
" ツールバーは非表示
set guioptions-=T
"}}}

"---------------------------------------------------------------------------
" 画面表示の設定:
"
"{{{
"ポップアップ補完メニュー色設定（通常の項目、選択されている項目、スクロールバー、スクロールバーのつまみ部分） 
highlight Pmenu       ctermfg=0 guifg=#000000 ctermbg=6 guibg=#4c745a 
highlight PmenuSel    ctermfg=0 guifg=#000000 ctermbg=3 guibg=#d4b979 
highlight PmenuSbar   ctermfg=0 guifg=#000000 ctermbg=0 guibg=#333333 
highlight PmenuThumb  ctermfg=0 guifg=#000000 ctermbg=0 guibg=Red 
highlight SpecialKeyi guifg=yellowgreen
highlight Folded      guifg=#D0FFD0 guibg=#304030 gui=none
"}}}

"---------------------------------------------------------------------------
" KEYMAP:
"
"{{{
nmap <m-space> :simalt~<CR>
"}}}

"---------------------------------------------------------------------------
" yankround.vim
"
"{{{
" keymap
"Visualモードのpで上書きされたテキストをレジスタに入れない
xmap p "_c<ESC><Plug>(yankround-p)
xmap gp "_c<ESC><Plug>(yankround-gp)
"}}}
