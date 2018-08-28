scriptencoding utf-8
" vim:set ts=8 sts=2 sw=2 tw=0 foldmethod=marker:
" (上記の行に関しては:help modelineを参照)
"
" Kariya Vim の $VIM/gvimrc を先読みしている前提の設定です。
"
" Last Change: 24-Aug-2018.

"---------------------------------------------------------------------------
" for kaoriya/vim
"
"{{{
if has('kaoriya')
  let g:gvimrc_first_finish = 0
  source $vim/vimrc
endif
"}}}

"---------------------------------------------------------------------------
" フォント設定:
"
"{{{
" for Windows
"{{{
if has('win32')
  "set guifont=MS_Gothic:h10.5
  set guifont=Osaka－等幅:h10.5
  "set renderoptions=type:directx,renmode:4
  set renderoptions=type:directx
  " 行間隔の設定
  set linespace=1
  " 一部のUCS文字の幅を自動計測して決める
  if has('kaoriya')
    set ambiwidth=auto
  endif
endif
"}}}

" for mac
"{{{
if has('mac')
  set guifont=Osaka－等幅:h14
endif
"}}}

" for unix
"{{{
if has('xfontset')
  " UNIX用 (xfontsetを使用)
  set guifontset=a14,r14,k14
endif
"}}}
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
"}}}

"---------------------------------------------------------------------------
" 日本語入力に関する設定:
"
"{{{
if has('multi_byte_ime') || has('xim')
  " IME ON時のカーソルの色を設定
  highlight CursorIM guibg=Yellow guifg=NONE
  " 挿入モードでのIME状態を記憶させない場合、次行のコメントを解除
  inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>
endif
"}}}

"---------------------------------------------------------------------------
" マウスに関する設定:
"
"{{{
" 解説:
" mousefocusは幾つか問題(一例:ウィンドウを分割しているラインにカーソルがあっ
" ている時の挙動)があるのでデフォルトでは設定しない。Windowsではmousehide
" が、マウスカーソルをVimのタイトルバーに置き日本語を入力するとチラチラする
" という問題を引き起す。
"
" どのモードでもマウスを使えるようにする
set mouse=a
" マウスの移動でフォーカスを自動的に切替えない (mousefocus:切替る)
set nomousefocus
" 入力時にマウスポインタを隠す (nomousehide:隠さない)
set mousehide
" ビジュアル選択(D&D他)を自動的にクリップボードへ (:help guioptions_a)
"set guioptions+=a
" Make shift-insert work like in Xterm
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>
"}}}

"---------------------------------------------------------------------------
" メニューに関する設定:
"
"{{{
" ツールバーは非表示
set guioptions-=T
" メニューファイルが存在しない場合は予め'guioptions'を調整しておく
if 1 && !filereadable($VIMRUNTIME . '/menu.vim') && has('gui_running')
  set guioptions+=M
endif
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
    "set printfont=MS_Gothic:h12:cSHIFTJIS
  endif
endif
"}}}

"---------------------------------------------------------------------------
" 画面表示の設定:
"
"{{{
" カラースキーム (Windows用gvim使用時はgvimrcを編集すること)
colorscheme molokai
"let g:molokai_original = 1
let g:rehash256 = 1
set background=dark

" ポップアップ補完メニュー色設定（通常の項目、選択されている項目、スクロールバー、スクロールバーのつまみ部分） 
highlight Pmenu       ctermfg=0 guifg=#000000 ctermbg=6 guibg=#4c745a 
highlight PmenuSel    ctermfg=0 guifg=#000000 ctermbg=3 guibg=#d4b979 
highlight PmenuSbar   ctermfg=0 guifg=#000000 ctermbg=0 guibg=#333333 
highlight PmenuThumb  ctermfg=0 guifg=#000000 ctermbg=0 guibg=Red 

" カーソルの色を設定
highlight Cursor guibg=Green guifg=Black gui=none

" その他の色指定
highlight SpecialKey  guifg=Brown gui=none
highlight Folded      guifg=#D0FFD0 guibg=#304030 gui=none
"}}}

"---------------------------------------------------------------------------
" KEYMAP:
"
"{{{
nmap <m-space> :simalt~<CR>
"}}}

"---------------------------------------------------------------------------
" yankround.vim
"
"{{{
" keymap
"Visualモードのpで上書きされたテキストをレジスタに入れない
xmap p "_c<ESC><Plug>(yankround-p)
xmap P "_c<ESC><Plug>(yankround-P)
xmap gp "_c<ESC><Plug>(yankround-gp)
xmap gP "_c<ESC><Plug>(yankround-gP)
"}}}
