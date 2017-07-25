" Unite.vim keymap
"
" 常用セット
nnoremap <silent> ,uu :<C-u>Unite buffer_tab neomru/file<CR>
" バッファ一覧
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
" ファイル一覧
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -start-insert -buffer-name=files file<CR>
" レジスタ一覧
nnoremap <silent> ,uR :<C-u>Unite -buffer-name=register register history/yank<CR>
" 最近使用したファイル一覧
nnoremap <silent> ,um :<C-u>Unite neomru/file<CR>
" ジャンプ
nnoremap <silent> ,uj :<C-u>Unite jump<CR>
" タブ一覧
nnoremap <silent> ,ul :<C-u>Unite tab<CR>
" 全部乗せ
nnoremap <silent> ,ua :<C-u>UniteWithCurrentDir -buffer-name=files buffer neomru/file bookmark file_rec<CR>
" バッファ内検索
nnoremap <silent> ,u/ :<C-u>Unite -buffer-name=search -start-insert line/fast -no-quit<CR>
"nnoremap <silent> g/  :<C-u>Unite -buffer-name=search -start-insert line -no-quit<CR>
" history/yank
nmap <silent> ,uy :<C-u>Unite history/yank register<CR>
xnoremap <silent> ,uy d:<C-u>Unite -buffer-name=register history/yank register<CR>
