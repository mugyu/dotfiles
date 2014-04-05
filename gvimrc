" vim:set ts=8 sts=2 sw=2 tw=0 foldmethod=marker:
" (上記の行に関しては:help modelineを参照)
"
" An example for a Japanese version gvimrc file.
" 日本語版のデフォルトGUI設定ファイル(gvimrc)
"
" Last Change: 01-Apr-2014.
" Maintainer:  MURAOKA Taro <koron@tka.att.ne.jp>
"
" 解説:
"{{{
" このファイルにはVimの起動時に必ず設定される、GUI関連の設定が書かれていま
" す。編集時の挙動に関する設定はvimrcに書かかれています。
"
" 個人用設定は_gvimrcというファイルを作成しそこで行ないます。_gvimrcはこの
" ファイルの後に読込まれるため、ここに書かれた内容を上書きして設定することが
" 出来ます。_gvimrcは$HOMEまたは$VIMに置いておく必要があります。$HOMEは$VIM
" よりも優先され、$HOMEでみつかった場合$VIMは読込まれません。
"
" 管理者向けに本設定ファイルを直接書き換えずに済ませることを目的として、サイ
" トローカルな設定を別ファイルで行なえるように配慮してあります。Vim起動時に
" サイトローカルな設定ファイル($VIM/gvimrc_local.vim)が存在するならば、本設
" 定ファイルの主要部分が読み込まれる前に自動的に読み込みます。
"
" 読み込み後、変数g:gvimrc_local_finishが非0の値に設定されていた場合には本設
" 定ファイルに書かれた内容は一切実行されません。デフォルト動作を全て差し替え
" たい場合に利用して下さい。
"
" 参考:
"   :help gvimrc
"   :echo $HOME
"   :echo $VIM
"   :version
"}}}

"---------------------------------------------------------------------------
" サイトローカルな設定($VIM/gvimrc_local.vim)があれば読み込む。読み込んだ後
" に変数g:gvimrc_local_finishに非0な値が設定されていた場合には、それ以上の設
" 定ファイルの読込を中止する。
"{{{
if 1 && filereadable($VIM . '/gvimrc_local.vim')
  source $VIM/gvimrc_local.vim
  if exists('g:gvimrc_local_finish') && g:gvimrc_local_finish != 0
    finish
  endif
endif
"}}}

"---------------------------------------------------------------------------
" ユーザ優先設定($HOME/.gvimrc_first.vim)があれば読み込む。読み込んだ後に変
" 数g:gvimrc_first_finishに非0な値が設定されていた場合には、それ以上の設定
" ファイルの読込を中止する。
"{{{
if 0 && exists('$HOME') && filereadable($HOME . '/.gvimrc_first.vim')
  unlet! g:gvimrc_first_finish
  source $HOME/.gvimrc_first.vim
  if exists('g:gvimrc_first_finish') && g:gvimrc_first_finish != 0
    finish
  endif
endif
"}}}

"---------------------------------------------------------------------------
" (試験中)
" Vimをモードレスな普通のエディタに変身させてしまうCreamを手軽に利用するため
" の設定。vimrc参照。
"{{{
if 1 && exists('g:cream_enabled') && g:cream_enabled != 0
  if filereadable($VIM.'/cream/_gvimrc')
    source $VIM/cream/_gvimrc
  endif
  finish
endif
"}}}

"---------------------------------------------------------------------------
" Bram氏の提供する設定例をインクルード (別ファイル:vimrc_example.vim)。これ
" 以前にg:no_gvimrc_exampleに非0な値を設定しておけばインクルードしない。
"{{{
if 1 && (!exists('g:no_gvimrc_example') || g:no_gvimrc_example == 0)
  source $VIMRUNTIME/gvimrc_example.vim
endif
"}}}

"---------------------------------------------------------------------------
" フォント設定:
"
"{{{
scriptencoding utf-8
if has('win32')
  " Windows用
  "set guifont=MS_Gothic:h10.5
  "
  " 逆にUTF-8でフォント名を指定しないといけないようだ
  "let &guifont = iconv('Osaka－等幅:h10.5', &encoding, 'cp932')
  let &guifont = 'Osaka－等幅:h10.5'

  "set guifont=Ricty:h14
  " 行間隔の設定
  set linespace=2
  if has('kaoriya')
    set ambiwidth=auto
  endif
elseif has('mac')
  set guifont=Osaka－等幅:h14
elseif has('xfontset')
  " UNIX用 (xfontsetを使用)
  set guifontset=a14,r14,k14
endif
"}}}

"---------------------------------------------------------------------------
" ウインドウに関する設定:
"
"{{{
" ウインドウの幅
set columns=80
" ウインドウの高さ
set lines=25
" コマンドラインの高さ(GUI使用時)
set cmdheight=2
" 画面を黒地に白にする (次行の先頭の " を削除すれば有効になる)
"colorscheme torte " (GUI使用時)
colorscheme molokai " (GUI使用時)
"let g:molokai_original = 1
let g:rehash256 = 1
set background=dark
"}}}

"---------------------------------------------------------------------------
" 日本語入力に関する設定:
"
"{{{
if has('multi_byte_ime') || has('xim')
  " IME ON時のカーソルの色を設定(設定例:紫)
  " highlight CursorIM guibg=Purple guifg=NONE
  highlight CursorIM guibg=Yellow guifg=NONE
  " 挿入モード・検索モードでのデフォルトのIME状態設定
  set iminsert=0 imsearch=0
  if has('xim') && has('GUI_GTK')
    " XIMの入力開始キーを設定:
    " 下記の s-space はShift+Spaceの意味でkinput2+canna用設定
    "set imactivatekey=s-space
  endif
  " 挿入モードでのIME状態を記憶させない場合、次行のコメントを解除
  inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>
endif
"}}}

"---------------------------------------------------------------------------
" マウスに関する設定:
"
" 解説:
" mousefocusは幾つか問題(一例:ウィンドウを分割しているラインにカーソルがあっ
" ている時の挙動)があるのでデフォルトでは設定しない。Windowsではmousehide
" が、マウスカーソルをVimのタイトルバーに置き日本語を入力するとチラチラする
" という問題を引き起す。
"
"{{{
" どのモードでもマウスを使えるようにする
set mouse=a
" マウスの移動でフォーカスを自動的に切替えない (mousefocus:切替る)
set nomousefocus
" 入力時にマウスポインタを隠す (nomousehide:隠さない)
set mousehide
" ビジュアル選択(D&D他)を自動的にクリップボードへ (:help guioptions_a)
" set guioptions+=a
" 上記はクリップボード履歴ソフトの履歴が増えまくるのでヤメ。
set guioptions-=a
"}}}

"---------------------------------------------------------------------------
" メニューに関する設定:
"
" 解説:
" "M"オプションが指定されたときはメニュー("m")・ツールバー("T")供に登録され
" ないので、自動的にそれらの領域を削除するようにした。よって、デフォルトのそ
" れらを無視してユーザが独自の一式を登録した場合には、それらが表示されないと
" いう問題が生じ得る。しかしあまりにレアなケースであると考えられるので無視す
" る。
"
"{{{
if &guioptions =~# 'M'
  let &guioptions = substitute(&guioptions, '[mT]', '', 'g')
endif
set guioptions-=T
"}}}

"---------------------------------------------------------------------------
" その他、見栄えに関する設定:
"
"{{{
" 検索文字列をハイライトしない(_vimrcではなく_gvimrcで設定する必要がある)
"set nohlsearch
"}}}

"---------------------------------------------------------------------------
" 印刷に関する設定:
"
"{{{
" 注釈:
" 印刷はGUIでなくてもできるのでvimrcで設定したほうが良いかもしれない。この辺
" りはWindowsではかなり曖昧。一般的に印刷には明朝、と言われることがあるらし
" いのでデフォルトフォントは明朝にしておく。ゴシックを使いたい場合はコメント
" アウトしてあるprintfontを参考に。
"
" 参考:
"   :hardcopy
"   :help 'printfont'
"   :help printing
"
" 印刷用フォント
if has('printer')
  if has('win32')
    set printfont=MS_Mincho:h12:cSHIFTJIS
  endif
endif
"}}}

"---------------------------------------------------------------------------
" 画面表示の設定:
"
"{{{
"ポップアップ補完メニュー色設定（通常の項目、選択されている項目、スクロールバー、スクロールバーのつまみ部分） 
highlight Pmenu       ctermfg=0 guifg=#000000 ctermbg=6 guibg=#4c745a 
highlight PmenuSel    ctermfg=0 guifg=#000000 ctermbg=3 guibg=#d4b979 
highlight PmenuSbar   ctermfg=0 guifg=#000000 ctermbg=0 guibg=#333333 
highlight PmenuThumb  ctermfg=0 guifg=#000000 ctermbg=0 guibg=Red 
highlight SpecialKeyi guifg=yellowgreen
highlight Folded      guifg=#D0FFD0 guibg=#304030 gui=none
"}}}

"---------------------------------------------------------------------------
" KEYMAP:
"
"{{{
nmap <m-space> :simalt~<CR>
"}}}

" Copyright (C) 2003 KaoriYa/MURAOKA Taro
