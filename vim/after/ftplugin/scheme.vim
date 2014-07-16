" vim:set foldmethod=marker:
"
"---------------------------------------------------------------------------
"  Gauche
""autocmd FileType scheme :let is_gauche=1
" Vim filetype plugin
" Language:		Gauche
" ----------------------------------------------------------------------------
" 編集に関する設定:
"
"{{{
setlocal ts=2 sw=2 number expandtab nowrap
setlocal indentkeys-=0#
setlocal complete-=i
"}}}

"---------------------------------------------------------------------------
" vim-gdev Gauche開発支援拡張
"
"{{{
":Unite gosh_infoを実行します
nmap <buffer>gi <Plug>(gosh_info_start_search)
":Unite カーソル位置のシンボルを初期値に:Unite gosh_infoを実行します
nmap <buffer>K     <Plug>(gosh_info_start_search_with_cur_keyword)
imap <buffer><C-A> <Plug>(gosh_info_start_search_with_cur_keyword)

"ginfoウィンドウのスクロールアップ・ダウン
nmap <buffer><C-K> <Plug>(gosh_info_row_up)
nmap <buffer><C-J> <Plug>(gosh_info_row_down)
imap <buffer><C-K> <Plug>(gosh_info_row_up)
imap <buffer><C-J> <Plug>(gosh_info_row_down)
"ginfoウィンドウを閉じます
nmap <buffer><C-C> <Plug>(gosh_info_close)
imap <buffer><C-C> <Plug>(gosh_info_close)

"カーソル位置のシンボルが定義されている場所にジャンプ
nmap <buffer><F12> <Plug>(gosh_goto_define)
nmap <buffer><F11> <Plug>(gosh_goto_define_split)
"}}}
