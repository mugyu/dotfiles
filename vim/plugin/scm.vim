set nocompatible
scriptencoding utf-8
" vim:set ts=8 sts=2 sw=2 tw=0 foldmethod=marker:
"=============================================================================
"
" SCM(git, svn) の関連
"
"=============================================================================

"---------------------------------------------------------------------------
" git: 直前コミットとのdiff
"
"{{{
function! s:gitdiff()
  vnew
  :%!git show HEAD:#
  setlocal readonly nomodifiable nomodified nonumber buftype=nofile
  diffthis
  wincmd p
  diffthis
  foldopen
endfunction
nmap <silent> ,gd :call <SID>gitdiff()<CR>
"}}}

"---------------------------------------------------------------------------
" svn: 直前コミットとのdiff
"
"{{{
function! s:svndiff()
  vnew
  :%!svn cat #
  setlocal readonly nomodifiable nomodified nonumber buftype=nofile
  diffthis
  wincmd p
  diffthis
endfunction
nmap <silent> ,sd :call <SID>svndiff()<CR>
"}}}

"---------------------------------------------------------------------------
" svn: blame を表示
"
"{{{
function! s:svnblame()
  aboveleft 18vnew
  :%!svn blame -v #
  setlocal readonly nomodifiable nomodified buftype=nofile winwidth=1
  setlocal nowrap nonumber
  setlocal scrollbind
  wincmd l
  setlocal scrollbind
  syncbind
endfunction
nmap <silent> ,sb :call <SID>svnblame()<CR>
"}}}
