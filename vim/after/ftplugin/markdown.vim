" vim:set foldmethod=marker:
"
" Vim filetype plugin
" Language: Markdown
"
" ----------------------------------------------------------------------------
" 編集に関する設定:
"
"{{{
setlocal ts=2 sw=2 expandtab nowrap
setlocal indentkeys-=0#
"}}}

"---------------------------------------------------------------------------
" markdown 内のコードの色付け
" http://mattn.kaoriya.net/software/vim/20140523124903.htm
"
"{{{
let g:markdown_fenced_languages = [
\ 'ruby',
\ 'erb=eruby',
\ 'javascript',
\ 'json=javascript',
\ 'css',
\ 'php',
\ 'vim',
\]
"}}}

