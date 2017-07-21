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

  " colorscheme
  call dein#add('tomasr/molokai')
  " text-object の縁側版
  call dein#add('tpope/vim-surround')
  " vim-surrond とかの操作をリピートできる
  call dein#add('tpope/vim-repeat')
  " テキスト整形用
  call dein#add('h1mesuke/vim-alignta')
  " レジスタの履歴を取得・再利用する<c-p>, <c-n>
  call dein#add('LeafCage/yankround.vim')
  " カレンダー
  call dein#add('vim-scripts/calendar.vim')
  " nishigori/increment-activator
  call dein#add('nishigori/increment-activator')
  " 個人用 snippets
  call dein#add('mugyu/vim-user-snippets')

  " You can specify revision/branch/tag.
"  call dein#add('Shougo/vimshell', { 'rev': '3787e5' })

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
