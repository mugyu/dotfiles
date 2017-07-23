scriptencoding utf-8
" vim:set ts=8 sts=2 sw=2 tw=0 foldmethod=marker:
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('~/.cache/dein/')
  call dein#begin('~/.cache/dein/')

  " Let dein manage dein
  " Required:
  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here:
  let g:rc_dir    = expand('~/.vim/rc/')
  let s:toml      = g:rc_dir . 'dein.toml'
  let s:toml_lazy = g:rc_dir . 'dein_lazy.toml'
  call dein#load_toml(s:toml,      { 'lazy': 0 })
  call dein#load_toml(s:toml_lazy, { 'lazy': 1 })

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif
