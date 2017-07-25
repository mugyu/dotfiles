" Edit file by tabedit.
"let g:vimfiler_edit_action = 'tabopen'

" Enable file operation commands.
"let g:vimfiler_safe_mode_by_default = 0

" Use trashbox.
" Windows only and require latest vimproc.
let g:unite_kind_file_use_trashbox = 1

" vimデフォルトのエクスプローラをvimfilerで置き換える
let g:vimfiler_as_default_explorer = 1
" カレントディレクトリを自動で変更する
let g:vimfiler_enable_auto_cd = 1
" 現在開いているバッファのディレクトリを開く
nnoremap <silent> ,f :<C-u>VimFilerBufferDir -quit<CR>
" 現在開いているバッファをIDE風に開く
nnoremap <silent> <Leader>fi :<C-u>VimFilerBufferDir -split -simple -winwidth=35 -no-quit<CR>

