scriptencoding utf-8
source $HOME/.vim/rc/dein.vim
filetype off
" vim:set ts=8 sts=2 sw=2 tw=0 foldmethod=marker expandtab:
" (上記の行に関しては:help modelineを参照)
"
" Kariya Vim の $VIM/vimrc を先読みしている前提の設定です。
"
" Last Change: 30-May-2019.
"

"---------------------------------------------------------------------------
" 日本語対応のための設定:
"
"{{{
set encoding=utf-8
"set encoding=japan

" for kaoriya/vim
if !has('kaoriya') || (exists('g:vimrc_first_finish') && g:vimrc_first_finish != 0)
"{{{
  " 各エンコードを示す文字列のデフォルト値。s:CheckIconvCapabilityを()呼ぶことで
  " 実環境に合わせた値に修正される。
  let s:enc_cp932 = 'cp932'
  let s:enc_eucjp = 'euc-jp'
  let s:enc_jisx = 'iso-2022-jp'
  let s:enc_utf8 = 'utf-8'
  " 利用しているiconvライブラリの性能を調べる。
  " 比較的新しいJISX0213をサポートしているか検査する。euc-jisx0213が定義してい
  " る範囲の文字をcp932からeuc-jisx0213へ変換できるかどうかで判断する。
  function! s:CheckIconvCapability()
    if !has('iconv') | return | endif
    if iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
      let s:enc_eucjp = 'euc-jisx0213,euc-jp'
      let s:enc_jisx = 'iso-2022-jp-3'
    else
      let s:enc_eucjp = 'euc-jp'
      let s:enc_jisx = 'iso-2022-jp'
    endif
  endfunction
  " 'fileencodings'を決定する。
  " 利用しているiconvライブラリの性能及び、現在利用している'encoding'の値に応じ
  " て、日本語で利用するのに最適な'fileencodings'を設定する。
  function! s:DetermineFileencodings()
    if !has('iconv') | return | endif
    let value = 'ucs-bom,ucs-2le,ucs-2'
    if &encoding ==? 'utf-8'
      " UTF-8環境向けにfileencodingsを設定する
      let value = s:enc_jisx. ','.s:enc_cp932. ','.s:enc_eucjp. ',ucs-bom'
    elseif &encoding ==? 'cp932'
      " CP932環境向けにfileencodingsを設定する
      let value = value. ','.s:enc_jisx. ','.s:enc_utf8. ','.s:enc_eucjp
    elseif &encoding ==? 'euc-jp' || &encoding ==? 'euc-jisx0213'
      " EUC-JP環境向けにfileencodingsを設定する
      let value = value. ','.s:enc_jisx. ','.s:enc_utf8. ','.s:enc_cp932
    else
      " TODO: 必要ならばその他のエンコード向けの設定をココに追加する
    endif
    if has('guess_encode')
      let value = 'guess,'.value
    endif
    let &fileencodings = value
  endfunction
  " パスに日本語を含む際にencを変更した場合の処置.
  let s:last_enc = &enc
  function! s:OnEncodingChanged()
    " runtimepath(rtp)を変換する.
    if s:last_enc !=# &enc
      if has('iconv')
        let &rtp = iconv(&rtp, s:last_enc, &enc)
      endif
      let s:last_enc = &enc
    endif
  endfunction

  augroup EncodeJapan
  autocmd!
  autocmd EncodingChanged * call <SID>OnEncodingChanged()
  augroup END

  call s:CheckIconvCapability()
  call s:DetermineFileencodings()

  " メッセージを日本語にする (Windowsでは自動的に判断・設定されている)
  if !(has('win32') || has('mac')) && has('multi_lang')
    if !exists('$LANG') || $LANG.'X' ==# 'X'
      if !exists('$LC_CTYPE') || $LC_CTYPE.'X' ==# 'X'
        language ctype ja_JP.eucJP
      endif
      if !exists('$LC_MESSAGES') || $LC_MESSAGES.'X' ==# 'X'
        language messages ja_JP.eucJP
      endif
    endif
  endif
  " MacOS Xメニューの日本語化 (メニュー表示前に行なう必要がある)
  if has('mac')
    set langmenu=japanese
  endif
  " 非GUI日本語コンソールを使っている場合の設定
  if !has('gui_running') && &encoding != 'cp932' && &term == 'win32'
    set termencoding=cp932
  endif
  "}}}
endif
"}}}

"---------------------------------------------------------------------------
" $VIMRUNTIME/defaults.vim
"
"{{{
if !has('kaoriya') || (exists('g:vimrc_first_finish') && g:vimrc_first_finish != 0)
 " Get the defaults that most users want.
 source $VIMRUNTIME/defaults.vim
endif
"}}}

"---------------------------------------------------------------------------
" 検索の挙動に関する設定:
"
"{{{
" 検索時に大文字小文字を無視 (noignorecase:無視しない)
set ignorecase
" 大文字小文字の両方が含まれている場合は大文字小文字を区別
set smartcase
" インクリメンタルサーチを行う
set incsearch
" grep の設定を 'findstr /n' から jvgrep へ変更(win32の defult は findstr)
if executable('jvgrep')
  set grepprg=jvgrep\ -8
endif
" 検索パターンをハイライト
if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif
"}}}

"---------------------------------------------------------------------------
" 補完に関する設定
"
"{{{
set completeopt=menuone,preview
"}}}

"---------------------------------------------------------------------------
" 編集に関する設定:
"
"{{{
" タブの画面上での幅
set tabstop=4
" 自動的にインデントする (noautoindent:インデントしない)
" shiftwidth=4 cindentやautoindent時に挿入されるタブの幅
" (tabstop と揃えておくと良い)
set autoindent smartindent shiftwidth=4
" タブをスペースに展開しない (expandtab:展開する)
set noexpandtab
" バックスペースでインデントや改行を削除できるようにする
set backspace=indent,eol,start
" 検索時にファイルの最後まで行ったら最初に戻る (nowrapscan:戻らない)
set wrapscan
" 括弧入力時に対応する括弧を表示 (noshowmatch:表示しない)
set showmatch
" コマンドライン補完するときに強化されたものを使う(参照 :help wildmenu)
set wildmenu
" テキスト挿入中の自動折り返しを日本語に対応させる
set formatoptions+=mM
" windows の clipboard用に @" と @* を共用
set clipboard+=unnamedplus,unnamed
" コマンド K に使われるヘルプの default を :help にする 
set keywordprg=:help
" ファイルの最後の改行を自動で入れない。初めから入っている分にはそのまま
set nofixeol
" 親ディレクトリのtagsを探す
set tags+=./tags;
"}}}

"---------------------------------------------------------------------------
" GUI固有ではない画面表示の設定:
"
"{{{
" 行番号を非表示 (number:表示)
set nonumber
" ルーラーを表示 (noruler:非表示)
set ruler
" タブや改行を表示 (nolist:非表示)
set list
" どの文字でタブや改行を表示するかを設定
set listchars=tab:^\ ,eol:~,trail:~,nbsp:%,extends:>,precedes:<
" 長い行を折り返して表示 (nowrap:折り返さない)
set wrap
" 常にステータス行を表示 (詳細は:he laststatus)
set laststatus=2
" コマンドラインの高さ (Windows用gvim使用時はgvimrcを編集すること)
set cmdheight=2
" コマンドをステータス行に表示
set showcmd
" タイトルを表示
set title
" GUI実行時に設定しない(gvimrcに設定の任を委譲)
if ! has("gui_running")
  " カラースキーム (Windows用gvim使用時はgvimrcを編集すること)
" colorscheme torte
  if (has('win32') && $ConEmuANSI == 'ON')
    set term=pcansi
    set encoding=cp932
    set termencoding=cp932
    set t_Co=256
    let &t_AB="\e[48;5;%dm"
    let &t_AF="\e[38;5;%dm"
    colorscheme molokai
  endif

  " ポップアップ補完メニュー色設定（通常の項目、選択されている項目、スクロールバー、スクロールバーのつまみ部分） 
  highlight Pmenu       ctermfg=0 guifg=#000000 ctermbg=6 guibg=#4c745a
  highlight PmenuSel    ctermfg=0 guifg=#000000 ctermbg=3 guibg=#d4b979
  highlight PmenuSbar   ctermfg=0 guifg=#000000 ctermbg=0 guibg=#333333
  highlight PmenuThumb  ctermfg=0 guifg=#000000 ctermbg=0 guibg=Red
endif

" ユニコードの全角か半角か曖昧な記号を全角表示する
set ambiwidth=double
" ステータスラインに文字コードと改行文字を表示
"set statusline=%<[%n]%f\ %m%r%h%w%{'['.(&fenc==''?&enc:&fenc).']['.&ff.']['.(%ft==''?'n/a':&ft).']'}%=%l,%c%V%8P
set statusline=%<[%n]%f\ %m%r%h%w%{'['.(&fenc==''?&enc:&fenc).']['.&ff.']'}%y%=%l,%c%V%8P 

" シンタックスを有効にする
syntax enable

" Windowを分割する際、下あるいは右に新しいWindowを出現させる
set splitbelow
set splitright
"}}}

"---------------------------------------------------------------------------
" プラットホーム依存の特別な設定
"
"{{{
" for unix
"{{{
if has('unix')
  " コンソールでのカラー表示のための設定(暫定的にUNIX専用)
  if !has('gui_running')
    let s:uname = system('uname')
    if s:uname =~? "linux"
      set term=builtin_linux
    elseif s:uname =~? "freebsd"
      set term=builtin_cons25
    elseif s:uname =~? "Darwin"
      set term=beos-ansi
    else
      set term=builtin_xterm
    endif
    unlet s:uname
  endif
endif
"}}}

" for mac
"{{{
if has('mac')
  " Macではデフォルトの'iskeyword'がcp932に対応しきれていないので修正
  set iskeyword=@,48-57,_,128-167,224-235
endif
"}}}

" for Windows
"{{{
if has('win32')
  " runtimepath を unix like に設定
  let &runtimepath = '~/.vim,' . &runtimepath . ',~/.vim/after'
  " WinではPATHに$VIMが含まれていないときにexeを見つけ出せないので修正
  if $PATH !~? '\(^\|;\)' . escape($VIM, '\\') . '\(;\|$\)'
    let $PATH = $VIM . ';' . $PATH
  endif
endif
"}}}

" ファイル名に大文字小文字の区別がないシステム用の設定:
"   (例: DOS/Windows/MacOS)
if filereadable($HOME . '/.vimrc') && filereadable($HOME . '/.ViMrC')
  " tagsファイルの重複防止
  set tags=./tags,tags
endif
" コンソール版で環境変数$DISPLAYが設定されていると起動が遅くなる件へ対応
if !has('gui_running') && has('xterm_clipboard')
  set clipboard=exclude:cons\\\|linux\\\|cygwin\\\|rxvt\\\|screen
endif
"}}}

"---------------------------------------------------------------------------
" ファイル操作に関する設定:
"
"{{{
if has("vms")
  set nobackup
else
  " バックアップファイルを作成する (nobackup: バックアップしない)
  set backup
  " バックアップファイルをテンポラリーディレクトリーに作成
  set backupdir=$TMP

  " 永続 undo 可能
  if has('persistent_undo')
    " undofile を作成する (noundofile: undofileを作成しない)
    set undofile
    " undofile をテンポラリーディレクトリーに作成
    set undodir=$TMP
  endif
endif

" スワップファイルをテンポラリーディレクトリーに作成
set directory=$TMP

" ハードリンク切れ対策で先にバックアップファイルのコピー
set backupcopy=yes
"}}}

"---------------------------------------------------------------------------
"  keymap
"
"{{{
" 改行ではなく、表示行単位で行移動する
nnoremap j      gj
nnoremap k      gk
nnoremap <down> gj
nnoremap <up>   gk

" 検索時のカーソル位置
nmap n nzz
nmap N Nzz
nmap * *zz
nmap # #zz
nmap g* g*zz
nmap g# g#zz

"コマンドラインモードで Emacs 風のキー操作を提供するものです。
"
" 行頭へ移動
cnoremap <C-a> <Home>
" 一文字戻る
cnoremap <C-b> <Left>
" カーソルの下の文字を削除
"cnoremap <C-d> <Del>
" 行末へ移動
cnoremap <C-e> <End>
" 一文字進む
cnoremap <C-f> <Right>
" コマンドライン履歴を一つ進む
"cnoremap <C-n> <Down>
" コマンドライン履歴を一つ戻る
"cnoremap <C-p> <Up>
" 前の単語へ移動
cnoremap <M-b> <S-Left>
" 次の単語へ移動
cnoremap <M-f> <S-Right>

" C-l で検索のハイライトをやめる
nmap <C-l> :nohlsearch<CR> :redraw!<CR>

" Windows操作のトリガーキーを S に設定
nmap s <C-W>

" タグジャンプ先が一つの時は即ジャンプ, 二つ以上の時は選択
nmap <C-]> g<C-]>
nmap <C-W><C-]> <C-W>g<C-]>

" 入力モード中に素早くjjと入力した場合はESCとみなす
inoremap jj <Esc>
"}}}

"---------------------------------------------------------------------------
"  全角スペースなどに色づけ
"
"{{{
" https://sites.google.com/site/fudist/Home/vim-nihongo-ban/vim-color#color-zenkaku
function! ZenkakuSpace()
  highlight ZenkakuSpace cterm=underline ctermfg=darkgrey gui=underline guifg=#505080
endfunction

if has('syntax')
  augroup ZenkakuSpace
    autocmd!
    autocmd ColorScheme * call ZenkakuSpace()
    autocmd VimEnter,WinEnter,BufRead * let w:m1=matchadd('ZenkakuSpace', '　')
  augroup END
  call ZenkakuSpace()
endif
"}}}

"---------------------------------------------------------------------------
"  Bell
"
"{{{
set visualbell t_vb=
set noerrorbells

"}}}

"---------------------------------------------------------------------------
"  指定カラムに色付け
"
set colorcolumn=80

"---------------------------------------------------------------------------
"  ftplugin/ruby.vim
"
"{{{
"let loaded_ruby_ftplugin = 1
"}}}

"---------------------------------------------------------------------------
" vim -b : edit binary using xxd-format!
"
"{{{
augroup Binary
  autocmd!
  autocmd BufReadPre  *.bin let &bin=1
  autocmd BufReadPost * if &bin | silent %!xxd -g 1
  autocmd BufReadPost * set ft=xxd | endif
  autocmd BufWritePre * if &bin | %!xxd -r
  autocmd BufWritePre * endif
  autocmd BufWritePost * if &bin | silent %!xxd -g 1
  autocmd BufWritePost * set nomod | endif
augroup END
"}}}

"---------------------------------------------------------------------------
" viminfo のファイル名(viminfo の n オプションは最後に指定する必要がある)
"
"{{{
set viminfo+=n~/.viminfo
"}}}

"---------------------------------------------------------------------------
" number と relativenumber を ,n でトグルする
"
"{{{
if version >= 703
  nnoremap  <silent> ,n :<C-u>ToggleNumber<CR>
  command! -nargs=0 ToggleNumber call ToggleNumberOption()

  function! ToggleNumberOption()
    if &number
      set relativenumber
    else
      set number
    endif
  endfunction
endif
"}}}

"---------------------------------------------------------------------------
" 新規作成時のテンプレート読み込み
"
"{{{
augroup IncludeTemplate
  autocmd!
  autocmd BufNewFile *.rb -r ~/.vim/templates/rb.tpl " Ruby
  autocmd BufNewFile *.gemspec -r ~/.vim/templates/gemspec.tpl " RubyGems
augroup END
"}}}

"===========================================================================
" Plugins Setting
"===========================================================================
"{{{

"---------------------------------------------------------------------------
" matchit.vim
"
"{{{
source $VIMRUNTIME/macros/matchit.vim
"}}}

"---------------------------------------------------------------------------
" vim-nyaos
"
"{{{
set runtimepath+=~/.vim/vim-nyaos
"" Shell settings.
"" Use NYAOS.
"set shell=nyaos.exe
"set shellcmdflag=-e
"set shellpipe=\|&\ tee
"set shellredir=>%s\ 2>&1
"set shellxquote=\"
"}}}

"---------------------------------------------------------------------------
" migemo
"
" refe: http://www.kaoriya.net/software/cmigemo/
"
"{{{
set runtimepath+=~/.vim/migemo
"}}}

" End Of `Plugins Setting` }}}

filetype plugin on
filetype indent on
