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
"setlocal dictionary=~/.vim/dict/ruby.dict
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
" Refe Key map
"
"{{{
nnoremap <buffer> <silent> K :Refe <cword><CR>
nnoremap <buffer> <silent> <C-K> :Refe<CR>
"}}}
"---------------------------------------------------------------------------
" Vim上でRubyを動かしたい。
" http://d.hatena.ne.jp/tanakaBox/20070827/1188149288
" rubyscript を ビジュアルモードで囲って ctrl+enter
"
"{{{
"nnoremap <buffer> <C-CR> :call <SID>Eval('n')<CR>
"inoremap <buffer> <C-CR> <ESC>:call <SID>Eval('i')<CR>
"vnoremap <buffer> <C-CR> :call <SID>EvalVisual()<CR>
"
"function! s:Eval(mode)
"  let s:saved_reg = @"
"  if a:mode == 'v'
"    silent normal `<v`>y
"  else
"    silent normal yy
"  endif
"  execute "ruby p((" . @" . "))"
"  let @" = s:saved_reg
"endfunc
"
"function! s:EvalVisual() range
"  call <SID>Eval('v')
"endfunc
"}}}
"---------------------------------------------------------------------------
" シンタックスエラーをQuickFixで一覧表示
" http://blog.blueblack.net/item_150
"     :make -c %
"     :cw #エラーがある場合のみQuickFixを表示
"
"{{{
compiler ruby
" Ruby構文チェック
setlocal makeprg=ruby\ -c\ %
setlocal errorformat=%m\ in\ %f\ on\ line\ %l
"make したら自動的に :cw
augroup quickfixopen
  autocmd!
  autocmd QuickfixCmdPost make cw
augroup END

if filereadable(expand('~/.tags_ruby'))
  setlocal tags+=~/.tags_ruby
endif
"}}}
"---------------------------------------------------------------------------
" ctags
"
"{{{
setlocal tags+=~/ruby*.tags
"}}}
