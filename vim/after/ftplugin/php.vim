" vim:set foldmethod=marker:
"
" Vim filetype plugin
" Language: PHP
"
" ----------------------------------------------------------------------------
" vim for PHP 標準設定
"
" 設定値に意味は無い。定義されると有効になる。
"
"{{{
let php_sql_query = 1            " 文字列中のSQLをハイライトする
let php_htmlInStrings = 1        " 文字列中のHTMLをハイライトする
"let php_baselib = 1              " 文字列中のBaselibをハイライトする
"let php_asp_tags = 1             " ASPスタイルの省略タグを有効にする
let php_parent_error_close = 1   " 閉じ括弧や閉じタグが無い場合のハイライト
let php_parent_error_open = 1
"let php_oldStyle = 1             " 古いカラースタイル
"let php_noShortTags = 1          " 省略PHPタグのハイライトをしない
"}}}
"
" ここからは設定値に意味がある
"
"{{{
"let php_folding = 1              " クラスと関数の折りたたみ
let php_folding = 2              " クラスと関数の{}で折りたたみ
setlocal foldcolumn=5            " ついでにfoldの設定もしておく
setlocal foldlevel=1

"let php_sync_method = -1          " シンクロナイズ方法(検索)
"let php_alt_assignByReference = 1 " `= &` のカラー設定
"let php_special_functions = 1
"let php_alt_comparisons = 1
"}}}
" ----------------------------------------------------------------------------
" Snippetに関する設定:
"
"{{{
NeoSnippetSource ~/.vim/bundle/vim-user-snippets/php.standard_function.snippets
"}}}
