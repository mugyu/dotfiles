" vim:set foldmethod=marker:
"
" Vim filetype plugin
" Language: Ruby
"

" ----------------------------------------------------------------------------
" 編集に関する設定:
"
"{{{
setlocal ts=2 sw=2 number expandtab nowrap
setlocal indentkeys-=0#
setlocal dictionary=~/.vim/dict/ruby.dict
setlocal complete+=k
"}}}
"---------------------------------------------------------------------------
" vim-ruby-refactoring
"
" KEY MAP {{{
" メソッドに引数を追加する
nnoremap ,rap  :RAddParameter<cr>

" メソッドに引数を追加する(括弧なし)
nnoremap ,raP  :RAddParameterNB<cr>

" 一行で書かれた条件文(e.g. "hoge if fuga?" のようなもの)を伝統的な複数行の形式に変換する
nnoremap ,rcpc :RConvertPostConditional<cr>

" 選択部分を定数として切り出す
vnoremap ,rec  :RExtractConstant<cr>

" 選択部分を変数として切り出す
vnoremap ,relv :RExtractLocalVariable<cr>

" 選択部分をメソッドに切り出す
vnoremap ,rem  :RExtractMethod<cr>

" 選択部分を RSpec の "let(:hoge) { fuga }" の形式に切り出す
nnoremap ,rel  :RExtractLet<cr>

" 一時変数を取り除く
nnoremap ,rit  :RInlineTemp<cr>

" ローカル変数をリネームする
vnoremap ,rrlv :RRenameLocalVariable<cr>

" インスタンス変数をリネームする
vnoremap ,rriv :RRenameInstanceVariable<cr>"}}}

"---------------------------------------------------------------------------
" タイプピングの部分最適化
"
"{{{
function! SmartSemicolon()
  let s = synIDattr(synID(line("."), col("."), 0), "name")
  if s == "rubyString" || s == "rubyRegexp"
    execute "normal a \<Esc>r;"
  else
    execute "normal a\<Enter> \<BS>"
  endif
endfunction
inoremap <buffer><silent> ; <Esc>:call SmartSemicolon()<CR>a
"}}}

"---------------------------------------------------------------------------
" ctags
"
"{{{
setlocal tags+=~/ruby*.tags
"}}}
