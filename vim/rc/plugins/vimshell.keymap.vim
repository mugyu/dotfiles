"http://nauthiz.hatenablog.com/entry/20101107/1289140518
" ,is: シェルを起動
nnoremap <silent> ,is :VimShell<CR>
" ,irb: irbを非同期で起動
nnoremap <silent> ,irb :VimShellInteractive irb<CR>
" ,pry: pryを非同期で起動
nnoremap <silent> ,pry :VimShellInteractive pry<CR>
" ,gosh goshを非同期で起動
nnoremap <silent> ,gosh :VimShellInteractive gosh<CR>
" ,sqlite sqlite3を非同期で起動
nnoremap <silent> ,sql :VimShellInteractive sqlite3<CR>
" ,ss: 非同期で開いたインタプリタに現在の行を評価させる
vmap <silent> ,ss :VimShellSendString<CR>
" 選択中に,ss: 非同期で開いたインタプリタに選択行を評価させる
nnoremap <silent> ,ss <S-v>:VimShellSendString<CR>
