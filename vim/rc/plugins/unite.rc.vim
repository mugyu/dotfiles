" 起動時にinsertモード
let g:unite_enable_start_insert=1
" 縦分割でWindowをオープン
"let g:unite_enable_split_vertically=1
" Windowの幅
"let g:unite_winwidth=40
" ホームディレクトリ展開
call unite#custom#profile('files', 'substitute_patterns', {
      \ 'pattern' : '^\~',
      \ 'subst' : substitute(
      \     unite#util#substitute_path_separator($HOME),
      \           ' ', '\\\\ ', 'g'),
      \ 'priority' : -100,
      \ })
call unite#custom#profile('files', 'substitute_patterns', {
      \ 'pattern' : '\.\{2,}\ze[^/]',
      \ 'subst' : "\\=repeat('../', len(submatch(0))-1)",
      \ 'priority' : 10000,
      \ })
" レジスタの履歴
let g:unite_source_history_yank_enable = 1

