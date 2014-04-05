" vim:set ts=8 sts=2 sw=2 tw=0 foldmethod=marker:
" (上記の行に関しては:help modelineを参照)
"
" An example for a Japanese version vimrc file.
" 日本語版のデフォルト設定ファイル(vimrc)
"
" Last Change: 05-Apr-2014.
" Maintainer:  MURAOKA Taro <koron@tka.att.ne.jp>
"
" 解説:
"{{{
" このファイルにはVimの起動時に必ず設定される、編集時の挙動に関する設定が書
" かれています。GUIに関する設定はgvimrcに書かかれています。
"
" 個人用設定は_vimrcというファイルを作成しそこで行ないます。_vimrcはこのファ
" イルの後に読込まれるため、ここに書かれた内容を上書きして設定することが出来
" ます。_vimrcは$HOMEまたは$VIMに置いておく必要があります。$HOMEは$VIMよりも
" 優先され、$HOMEでみつかった場合$VIMは読込まれません。
"
" 管理者向けに本設定ファイルを直接書き換えずに済ませることを目的として、サイ
" トローカルな設定を別ファイルで行なえるように配慮してあります。Vim起動時に
" サイトローカルな設定ファイル($VIM/vimrc_local.vim)が存在するならば、本設定
" ファイルの主要部分が読み込まれる前に自動的に読み込みます。
"
" 読み込み後、変数g:vimrc_local_finishが非0の値に設定されていた場合には本設
" 定ファイルに書かれた内容は一切実行されません。デフォルト動作を全て差し替え
" たい場合に利用して下さい。
"
" 参考:
"   :help vimrc
"   :echo $HOME
"   :echo $VIM
"   :version
"}}}

"---------------------------------------------------------------------------
" サイトローカルな設定($VIM/vimrc_local.vim)があれば読み込む。読み込んだ後に
" 変数g:vimrc_local_finishに非0な値が設定されていた場合には、それ以上の設定
" ファイルの読込を中止する。
"
"{{{
if 1 && filereadable($VIM . '/vimrc_local.vim')
  unlet! g:vimrc_local_finish
  source $VIM/vimrc_local.vim
  if exists('g:vimrc_local_finish') && g:vimrc_local_finish != 0
    finish
  endif
endif
"}}}
"---------------------------------------------------------------------------
" ユーザ優先設定($HOME/.vimrc_first.vim)があれば読み込む。読み込んだ後に変数
" g:vimrc_first_finishに非0な値が設定されていた場合には、それ以上の設定ファ
" イルの読込を中止する。
"
"{{{
if 0 && exists('$HOME') && filereadable($HOME . '/.vimrc_first.vim')
  unlet! g:vimrc_first_finish
  source $HOME/.vimrc_first.vim
  if exists('g:vimrc_first_finish') && g:vimrc_first_finish != 0
    finish
  endif
endif
"}}}
"---------------------------------------------------------------------------
" (試験中)
" Vimをモードレスな普通のエディタに変身させてしまうCreamを手軽に利用するため
" の設定。$VIMに下記URLから入手したcream/ディレクトリを置けば、起動時に自動
" 的に読み込まれる。
"
"{{{
if 1 && filereadable($VIM.'/cream/cream.vim')
  let g:cream_enabled = 1
  if filereadable($VIM.'/cream/_vimrc')
    source $VIM/cream/_vimrc
  endif
  finish
endif
"}}}
"---------------------------------------------------------------------------
" 日本語対応のための設定:
"
"{{{
" ファイルを読込む時にトライするエンコーディングの順序を指定する。漢字コード
" 自動判別機能を利用する場合には別途iconv.dllが必要。iconv.dllについては
" README_j.txtを参照。オプション'encoding'はWindowsから取得できる情報を基
" に、自動的にcp932(Windows)に設定される。UNIXでは設定されないこともあるらし
" い。
"
" 日本語を扱うために必要
"source $VIM/plugins/kaoriya/encode_japan.vim
"if &encoding ==# 'utf-8'
"  set termencoding=utf-8
"else
  if !has('unix') && has('gui_running')
    let &fileencoding=&encoding
    set encoding=utf-8
    let &termencoding=&encoding
  else
"    set encoding=japan
    let &fileencoding=&encoding
    set encoding=utf-8
  end
"end
" ファイルの漢字コード自動判別のために必要。(要iconv)
if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'
  " iconvがJISX0213に対応しているかをチェック
  if iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213,euc-jp'
    let s:enc_jis = 'iso-2022-jp-3,iso-2022-jp'
  endif
  " fileencodingsを構築
  if &encoding =~# '^euc-\%(jp\|jisx0213\)$'
    let &encoding = s:enc_euc
  endif
  let &fileencodings = s:enc_jis.',ucs-bom,utf-8,cp932'.','.s:enc_euc
  " 定数を処分
  unlet s:enc_euc
  unlet s:enc_jis
endif
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
" 改行コードの自動認識
set fileformats=unix,dos,mac
" MacOS Xメニューの日本語化 (メニュー表示前に行なう必要がある)
if has('mac')
  set langmenu=japanese
endif
" 日本語入力用のkeymapの設定例 (コメントアウト)
if has('keymap')
  " ローマ字仮名のkeymap
  "silent! set keymap=japanese
  "set iminsert=0 imsearch=0
endif
" 非GUI日本語コンソールを使っている場合の設定
if !has('gui_running') && &encoding != 'cp932' && &term == 'win32'
  set termencoding=cp932
endif
"}}}
"---------------------------------------------------------------------------
" メニューファイルが存在しない場合は予め'guioptions'を調整しておく
"
"{{{
if 1 && !filereadable($VIMRUNTIME . '/menu.vim') && has('gui_running')
  set guioptions+=M
endif
"}}}
"---------------------------------------------------------------------------
" Bram氏の提供する設定例をインクルード (別ファイル:vimrc_example.vim)。これ
" 以前にg:no_vimrc_exampleに非0な値を設定しておけばインクルードはしない。
"
"{{{
if 1 && (!exists('g:no_vimrc_example') || g:no_vimrc_example == 0)
  source $VIMRUNTIME/vimrc_example.vim
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
" grep の設定を 'findstr /n' から grep へ変更(win32の defult は findstr)
set grepprg=grep\ -nH
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
" タブの画面上での幅 (defule = 8)
set tabstop=4
" 自動的にインデントする (noautoindent:インデントしない)
" shiftwidth=4 cindentやautoindent時に挿入されるタブの幅
" (tabstop と揃えておくと良い)
set autoindent smartindent shiftwidth=4
" タブをスペースに展開しない (expandtab:展開する)
set noexpandtab
" バックスペースでインデントや改行を削除できるようにする
set backspace=2
" 検索時にファイルの最後まで行ったら最初に戻る (nowrapscan:戻らない)
set wrapscan
" 括弧入力時に対応する括弧を表示 (noshowmatch:表示しない)
set showmatch
" コマンドライン補完するときに強化されたものを使う(参照 :help wildmenu)
set wildmenu
" テキスト挿入中の自動折り返しを日本語に対応させる
set formatoptions+=mM
" 日本語整形スクリプト(by. 西岡拓洋さん)用の設定
let format_allow_over_tw = 1	" ぶら下り可能幅
" windows の clipboard用に @" と @* を共用
set clipboard+=unnamedplus,unnamed
" コマンド K に使われるヘルプの default を :help にする 
set keywordprg=:help
"}}}
"---------------------------------------------------------------------------
" GUI固有ではない画面表示の設定:
"
"{{{
" 行番号を非表示 (number:表示)
set nonumber
" ルーラーを表示 (noruler:非表示)
set ruler
" タブや改行を表示 (list:表示)
set nolist
" どの文字でタブや改行を表示するかを設定
"set listchars=tab:>-,extends:<,trail:-,eol:<
" 長い行を折り返して表示 (nowrap:折り返さない)
set wrap
" 常にステータス行を表示 (詳細は:he laststatus)
set laststatus=2
" ステータスラインに文字コードと改行文字を表示
"set statusline=%<[%n]%f\ %m%r%h%w%{'['.(&fenc==''?&enc:&fenc).']['.&ff.']['.(%ft==''?'n/a':&ft).']'}%=%l,%c%V%8P
set statusline=%<[%n]%f\ %m%r%h%w%{'['.(&fenc==''?&enc:&fenc).']['.&ff.']'}%y%=%l,%c%V%8P 
" コマンドラインの高さ (Windows用gvim使用時はgvimrcを編集すること)
set cmdheight=2
" コマンドをステータス行に表示
set showcmd
" タイトルを表示
set title
" 画面を黒地に白にする (次行の先頭の " を削除すれば有効になる)
syntax enable
"colorscheme evening " (Windows用gvim使用時はgvimrcを編集すること)
colorscheme torte

"ポップアップ補完メニュー色設定（通常の項目、選択されている項目、スクロールバー、スクロールバーのつまみ部分） 
highlight Pmenu       ctermfg=0 guifg=#000000 ctermbg=6 guibg=#4c745a
highlight PmenuSel    ctermfg=0 guifg=#000000 ctermbg=3 guibg=#d4b979
highlight PmenuSbar   ctermfg=0 guifg=#000000 ctermbg=0 guibg=#333333
highlight PmenuThumb  ctermfg=0 guifg=#000000 ctermbg=0 guibg=Red

" Windowを分割する際、下あるいは右に新しいWindowを出現させる
set splitbelow
set splitright
"}}}
"---------------------------------------------------------------------------
" ファイル操作に関する設定:
"
"{{{
" バックアップファイルを作成しない (次行の先頭の " を削除すれば有効になる)
" set nobackup
" バックアップファイルをテンポラリーディレクトリーに作成
set backupdir=$TMP
" スワップファイルをテンポラリーディレクトリーに作成
set directory=$TMP

" undofile を作成しない (次行の先頭の " を削除すれば有効になる)
" set noundofile
" undofile をテンポラリーディレクトリーに作成
set undodir=$TMP
" ハードリンク切れ対策で先にバックアップファイルのコピー
set backupcopy=yes
"}}}

"---------------------------------------------------------------------------
" ファイル名に大文字小文字の区別がないシステム用の設定:
"   (例: DOS/Windows/MacOS)
"{{{
if filereadable($VIM . '/vimrc') && filereadable($VIM . '/ViMrC')
  " tagsファイルの重複防止
  set tags=./tags,tags
  "set tags=tags;
  "set tags+=./**/tags; "下層ディレクトリも探しにいく
endif
"}}}

"---------------------------------------------------------------------------
" コンソールでのカラー表示のための設定(暫定的にUNIX専用)
"
"{{{
if has('unix') && !has('gui_running')
  let uname = system('uname')
  if uname =~? "linux"
    set term=builtin_linux
  elseif uname =~? "freebsd"
    set term=builtin_cons25
  elseif uname =~? "Darwin"
    set term=beos-ansi
  else
    set term=builtin_xterm
  endif
  unlet uname
endif
"}}}

"---------------------------------------------------------------------------
" コンソール版で環境変数$DISPLAYが設定されていると起動が遅くなる件へ対応
"
"{{{
if !has('gui_running') && has('xterm_clipboard')
  set clipboard=exclude:cons\\\|linux\\\|cygwin\\\|rxvt\\\|screen
endif
"}}}

"---------------------------------------------------------------------------
" プラットホーム依存の特別な設定
"
"{{{
if has('win32')
  " runtimepath を unix like に設定
  let &runtimepath = '~/.vim,' . &runtimepath . ',~/.vim/after'
  " WinではPATHに$VIMが含まれていないときにexeを見つけ出せないので修正
  if $PATH !~? '\(^\|;\)' . escape($VIM, '\\') . '\(;\|$\)'
    let $PATH = $VIM . ';' . $PATH
  endif
endif

if has('mac')
  " Macではデフォルトの'iskeyword'がcp932に対応しきれていないので修正
  set iskeyword=@,48-57,_,128-167,224-235
endif
"}}}
"---------------------------------------------------------------------------
" KaoriYaでバンドルしているプラグインのための設定
"
"{{{

" autofmt: 日本語文章のフォーマット(折り返し)プラグイン.
set formatexpr=autofmt#japanese#formatexpr()

" vimdoc-ja: 日本語ヘルプを無効化する.
if kaoriya#switch#enabled('disable-vimdoc-ja')
  let &rtp = join(filter(split(&rtp, ','), 'v:val !~ "vimdoc-ja"'), ',')
endif
"}}}
"---------------------------------------------------------------------------
"  keymap
"
"{{{
"  改行ではなく、表示行単位で行移動する
nnoremap j      gj
nnoremap k      gk
nnoremap <down> gj
nnoremap <up>   gk
"  検索時のカーソル位置
nmap n nzz
nmap N Nzz
nmap * *zz
nmap # #zz
nmap g* g*zz
nmap g# g#zz
" Visualモードのpで上書きされたテキストをレジスタに入れない
vnoremap p "_c<C-r>"<ESC>

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

nmap s <C-W>
"}}}
"---------------------------------------------------------------------------
"  全角スペースなどに色づけ
"
"{{{
" highlight SpecialKey   cterm=underline ctermfg=darkgrey
"highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkblue
highlight ZenkakuSpace ctermbg=1
autocmd BufNewFile,BufRead * call matchadd("ZenkakuSpace", iconv('　', &encoding, 'cp932')) 
"}}}

"---------------------------------------------------------------------------
"  指定カラムに色付け
"
set colorcolumn=80

"---------------------------------------------------------------------------
"  ftplugin/ruby.vim
"
"{{{
" let loaded_ruby_ftplugin = 1
"}}}
"---------------------------------------------------------------------------
"  タイプの部分最適化
"
"{{{
autocmd FileType html imap <buffer> <C-_> <%=  %><Esc>2hi
autocmd FileType html imap <buffer> <C-E> <%  %><Esc>2hi
"}}}
"---------------------------------------------------------------------------
" vim -b : edit binary using xxd-format!
"
"{{{
augroup Binary
  au!
  au BufReadPre  *.bin let &bin=1
  au BufReadPost *.bin if &bin | silent %!xxd -g 1
  au BufReadPost *.bin set ft=xxd | endif
  au BufWritePre *.bin if &bin | %!xxd -r
  au BufWritePre *.bin endif
  au BufWritePost *.bin if &bin | silent %!xxd -g 1
  au BufWritePost *.bin set nomod | endif
augroup END
"}}}
"---------------------------------------------------------------------------
" viminfo のファイル名(viminfo の n オプションは最後に指定する必要がある)
"
"{{{
set viminfo+=n~/.viminfo
"}}}

"---------------------------------------------------------------------------
" 改行文字とかの出力
"
"{{{
set list
set listchars=tab:^\ ,eol:~,trail:~,nbsp:%,extends:>,precedes:<
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
" NeoBundle
"
"{{{

" NeoBundle "{{{
filetype off
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
  call neobundle#rc(expand('~/.vim/bundle'))
"  call neobundle#rc(expand('C:/Users/admin/.vim/bundle'))
endif

NeoBundle 'Shougo/neobundle.vim'
"}}}

" Unite
"{{{
NeoBundleLazy 'Shougo/unite.vim', {
\  'autoload': {'commands': [
\                  'Unite',
\                  'UniteWithCurrentDir',
\                  'UniteWithBufferDir',
\                  'UniteWithInput',
\                  'UniteWithCursorWord',
\                  'UniteClose',
\                  'UniteBookmarkAdd'
\              ]}
\}
let s:bundle = neobundle#get('unite.vim')
function! s:bundle.hooks.on_source(bundle)
  " 起動時にinsertモード
  let g:unite_enable_start_insert=1
  " 縦分割でWindowをオープン
  "let g:unite_enable_split_vertically=1
  " Windowの幅
  "let g:unite_winwidth=40
  " ホームディレクトリ展開
  call unite#custom#profile('files', 'substitute_patterns', {
        \ 'pattern' : '^\~',
        \ 'subst' : substitute(
        \     unite#util#substitute_path_separator($HOME),
        \           ' ', '\\\\ ', 'g'),
        \ 'priority' : -100,
        \ })
  call unite#custom#profile('files', 'substitute_patterns', {
        \ 'pattern' : '\.\{2,}\ze[^/]',
        \ 'subst' : "\\=repeat('../', len(submatch(0))-1)",
        \ 'priority' : 10000,
        \ })
  " レジスタの履歴
  let g:unite_source_history_yank_enable = 1

  "---------------------------------------------------------------------------
  " Unite-Neco
  "
  "{{{
  let s:unite_source = {'name': 'neco'}
  function! s:unite_source.gather_candidates(args, context)
    let necos = [
	  \ "~(-'_'-) goes right",
	  \ "~(-'_'-) goes right and left",
	  \ "~(-'_'-) goes right quickly",
	  \ "~(-'_'-) goes right then smile",
	  \ "~(-'_'-)  -8(*'_'*) go right and left",
	  \ "(=' .' ) ~w",
	  \ ]
    return map(necos, '{
	  \ "word": v:val,
	  \ "source": "neco",
	  \ "kind": "command",
	  \ "action__command": "Neco " . v:key,
	  \ }')
  endfunction
  call unite#define_source(s:unite_source)
  "}}}
endfunction
unlet s:bundle
"}}}

" Unite Source
"{{{
" neomru
"{{{
NeoBundle 'Shougo/neomru.vim', {
\  'depends': [
\      'Shougo/unite.vim',
\  ]
\}
"}}}
"NeoBundle 'kmnk/vim-unite-svn'
"NeoBundle 'hrsh7th/vim-unite-vcs'
NeoBundle 'kmnk/vim-unite-giti'
" ujihisa/unite-gem
"{{{
NeoBundleLazy 'ujihisa/unite-gem', {
\  'autoload': {'filetypes': ['ruby']}
\}
let s:bundle = neobundle#get('unite-gem')
function! s:bundle.hooks.on_source(bundle)
endfunction
unlet s:bundle
"}}}
" ujihisa/unite-rake
"{{{
NeoBundleLazy 'ujihisa/unite-rake', {
\  'autoload': {'filetypes': ['ruby']}
\}
let s:bundle = neobundle#get('unite-rake')
function! s:bundle.hooks.on_source(bundle)
endfunction
unlet s:bundle
"}}}
" unite-outline
" {{{
NeoBundle 'Shougo/unite-outline'
nnoremap <silent> ,uo :<C-u>Unite -buffer-name=outline outline<CR>
"}}}
" ctag のタグ
"{{{
NeoBundle 'tsukkee/unite-tag'
autocmd BufEnter *
  \   if empty(&buftype)
  \|     noremap <silent> ,ut :<C-u>UniteWithCursorWord -immediately tag<CR>
  \|  endif
"}}}
" codic の辞書
"{{{
NeoBundle 'rhysd/unite-codic.vim', {
\  'depends': [
\      'koron/codic-vim',
\      'Shougo/unite.vim',
\      'Shougo/vimproc.vim'
\  ]
\}
" with Unite.vim
nnoremap <silent> ,uc :<C-u>Unite codic<CR>
"}}}
" rhysd/unite-ruby-require.vim
"{{{
NeoBundleLazy 'rhysd/unite-ruby-require.vim', {
\  'autoload': {'filetypes': ['ruby']}
\}
let s:bundle = neobundle#get('unite-ruby-require.vim')
function! s:bundle.hooks.on_source(bundle)
  nnoremap <silent> ,ui :<C-u>Unite -buffer-name=require ruby/require<CR>
endfunction
unlet s:bundle
"}}}
"}}}

" NeoComplate ポップアップ補完
NeoBundle 'Shougo/neocomplete.vim'
" NeoSnippet.vim スニペットのポップアップ補完
"{{{
NeoBundle 'Shougo/neosnippet.vim'
" neosnip.vim の default スニペット
NeoBundle 'Shougo/neosnippet-snippets'
" その他のスニペット
NeoBundle 'honza/vim-snippets'
"}}}

" VimShell
"{{{
NeoBundleLazy 'Shougo/vimshell.vim', {
\  'autoload': {'commands': [
\                  'VimShell',
\                  'VimShellCreate',
\                  'VimShellTab',
\                  'VimShellPop',
\                  'VimShellCurrentDir',
\                  'VimShellBufferDir',
\                  'VimShellExecute',
\                  'VimShellInteractive',
\                  'VimShellTerminal',
\                  'VimShellSendString',
\                  'VimShellSendBuffer'
\              ]},
\  'depends': ['Shougo/unite.vim', 'Shougo/vimproc.vim']
\}
let s:bundle = neobundle#get('vimshell.vim')
function! s:bundle.hooks.on_source(bundle)
  let g:vimshell_user_prompt = 'fnamemodify(getcwd(), ":~")'
  "let g:vimshell_right_prompt = 'vcs#info("(%s)-[%b]", "(%s)-[%b|%a]")'
  let g:vimshell_enable_smart_case = 1

  if has('win32') || has('win64')
    " Display user name on Windows.
    let g:vimshell_prompt = $USERNAME."% "
  else
    " Display user name on Linux.
    let g:vimshell_prompt = $USER."% "
  endif

  " Initialize execute file list.
  let g:vimshell_execute_file_list = {}
  call vimshell#set_execute_file('txt,vim,c,h,cpp,d,xml,java', 'vim')
  let g:vimshell_execute_file_list['rb'] = 'ruby'
  let g:vimshell_execute_file_list['pl'] = 'perl'
  let g:vimshell_execute_file_list['py'] = 'python'
  call vimshell#set_execute_file('html,xhtml', 'gexe firefox')

  autocmd FileType vimshell
  \ call vimshell#altercmd#define('g', 'git')
  \| call vimshell#altercmd#define('i', 'iexe')
  \| call vimshell#altercmd#define('l', 'll')
  \| call vimshell#altercmd#define('ll', 'ls -l')
  \| call vimshell#hook#add('chpwd', 'my_chpwd', 'g:my_chpwd')

  function! g:my_chpwd(args, context)
    call vimshell#execute('ls')
  endfunction

  autocmd FileType int-* call s:interactive_settings()
  function! s:interactive_settings()
  endfunction
endfunction
unlet s:bundle
"}}}

" VimFiler
"{{{
NeoBundleLazy 'Shougo/vimfiler.vim', {
\  'autoload': {'commands': [
\                  'VimFiler',
\                  'VimFilerBufferDir',
\              ]},
\  'depends': ['Shougo/unite.vim', 'Shougo/vimproc.vim']
\}
let s:bundle = neobundle#get('vimfiler.vim')
function! s:bundle.hooks.on_source(bundle)
  call vimfiler#set_execute_file('vim', 'vim')
  call vimfiler#set_execute_file('txt', 'notepad')
  call vimfiler#set_execute_file('c', ['vim', 'notepad'])

  " Edit file by tabedit.
  "let g:vimfiler_edit_action = 'tabopen'

  let g:vimfiler_as_default_explorer = 1

  " Enable file operation commands.
  "let g:vimfiler_safe_mode_by_default = 0

  " Like Textmate icons.
  let g:vimfiler_tree_leaf_icon = ' '
  "let g:vimfiler_tree_opened_icon = '▾'
  "let g:vimfiler_tree_closed_icon = '▸'
  let g:vimfiler_file_icon = '-'
  let g:vimfiler_marked_file_icon = '*'

  " Use trashbox.
  " Windows only and require latest vimproc.
  let g:unite_kind_file_use_trashbox = 1

  "vimデフォルトのエクスプローラをvimfilerで置き換える
  let g:vimfiler_as_default_explorer = 1
  "現在開いているバッファのディレクトリを開く
  nnoremap <silent> ,f :<C-u>VimFilerBufferDir -quit<CR>
  "現在開いているバッファをIDE風に開く
  nnoremap <silent> <Leader>fi :<C-u>VimFilerBufferDir -split -simple -winwidth=35 -no-quit<CR>
endfunction
unlet s:bundle
"}}}

" Vimdoc-ja 日本語ヘルプ
"{{{
NeoBundleLazy 'vim-jp/vimdoc-ja', {
\  'autoload': {'commands': ['help']}
\}
"}}}

" Ruby
" vim-ruby/vim-ruby "{{{
NeoBundleLazy 'vim-ruby/vim-ruby', {
\  'autoload': {'filetypes': ['ruby']}
\}
let s:bundle = neobundle#get('vim-ruby')
function! s:bundle.hooks.on_source(bundle)
endfunction
unlet s:bundle
"}}}
" ecomba/vim-ruby-refactoring "{{{
NeoBundleLazy 'ecomba/vim-ruby-refactoring', {
\  'autoload': {'filetypes': ['ruby']}
\}
let s:bundle = neobundle#get('vim-ruby-refactoring')
function! s:bundle.hooks.on_source(bundle)
  " デフォルトのキーマップを有効にする
  let g:ruby_refactoring_map_keys=0
endfunction
unlet s:bundle
"}}}

" Gauche(scheme)
" aharisu/vim-gdev "{{{
NeoBundleLazy 'aharisu/vim-gdev', {
\  'autoload': {'filetypes': ['scheme']}
\}
let s:bundle = neobundle#get('vim-gdev')
function! s:bundle.hooks.on_source(bundle)
endfunction
unlet s:bundle
"}}}

" 非同期で外部コマンドを実行したりとか
NeoBundle 'Shougo/vimproc.vim'
" text-object の縁側版
NeoBundle 'tpope/vim-surround'
" vim-surrond とかの操作をリピートできる
NeoBundle 'tpope/vim-repeat'
" テキスト整形用
NeoBundle 'h1mesuke/vim-alignta'
" function,do,then などに対して end のようなものを補完する
"NeoBundle 'tpope/vim-endwise'
" [, (, {, ", ' に対して閉じカッコを補完
NeoBundle 'kana/vim-smartinput'
" do などに対して end を補完
NeoBundle 'cohama/vim-smartinput-endwise'
" vim の正規表現を Perl や Ruby っぽくする
NeoBundle 'othree/eregex.vim'
" シンタックスチェックや臭いコードを調べる
NeoBundle 'scrooloose/syntastic'
" 書いたスクリプトを即実行 ,r
NeoBundle 'thinca/vim-quickrun'
" レジストリの履歴 <C-p>, <C-n>
NeoBundle "YankRing.vim"
" カレンダー
NeoBundle 'calendar.vim'
" 行単位のdiff
" AndrewRadev/linediff.vim "{{{
NeoBundleLazy 'AndrewRadev/linediff.vim', {
\  'autoload': {'commands': ['Linediff', 'LinediffReset']}
\}
let s:bundle = neobundle#get('linediff.vim')
function! s:bundle.hooks.on_source(bundle)
endfunction
unlet s:bundle
"}}}
" nishigori/increment-activator
NeoBundle 'nishigori/increment-activator'

" colorscheme 'tomasr/molokai'
NeoBundle 'tomasr/molokai'

" disable
"{{{
"NeoBundle 'Shougo/neocomplcache'
"}}}

filetype plugin on
filetype indent on
"}}}

"---------------------------------------------------------------------------
" Unite
"
" keymap {{{
"
" 常用セット
nnoremap <silent> ,uu :<C-u>Unite buffer_tab neomru/file<CR>
" バッファ一覧
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
" ファイル一覧
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -start-insert -buffer-name=files file<CR>
" レジスタ一覧
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register history/yank<CR>
xnoremap <silent> ,ur d:<C-u>Unite -buffer-name=register register history/yank<CR>
" 最近使用したファイル一覧
nnoremap <silent> ,um :<C-u>Unite neomru/file<CR>
" ジャンプ
nnoremap <silent> ,uj :<C-u>Unite jump<CR>
" タブ一覧
nnoremap <silent> ,ul :<C-u>Unite tab<CR>
" 全部乗せ
nnoremap <silent> ,ua :<C-u>UniteWithCurrentDir -buffer-name=files buffer neomru/file bookmark file_rec<CR>
" バッファ内検索
nnoremap <silent> ,u/ :<C-u>Unite -buffer-name=search -start-insert line/fast -no-quit<CR>
"nnoremap <silent> g/  :<C-u>Unite -buffer-name=search -start-insert line -no-quit<CR>
" history/yank
nmap <silent> ,uy :<C-u>Unite history/yank register<CR>
xnoremap <silent> ,uy d:<C-u>Unite -buffer-name=register history/yank register<CR>
" tas
autocmd BufEnter *
\  if empty(&buftype)
\|     nnoremap <buffer> <C-]> :<C-u>UniteWithCursorWord -immediately tag<CR>
\| endif
"}}}
"---------------------------------------------------------------------------
" neocomplete.vim
"
"{{{
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1

" Use smartcase.
let g:neocomplete#enable_smart_case = 1

" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplate#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell/command-history',
    \ 'scheme' : $HOME.'/.vim/dict/gosh.dict',
    \ 'ruby' : $HOME.'/.vim/dict/ruby.dict'
    \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g> neocomplete#undo_completion()
inoremap <expr><C-l> neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
"inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplete#smart_close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
"inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
"inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()
" <BS> でポップアップを閉じて文字を削除
imap <expr> <BS>
      \ neocomplete#smart_close_popup() . "\<Plug>(smartinput_BS)"

" <C-h> でポップアップを閉じて文字を削除
imap <expr> <C-h>
      \ neocomplete#smart_close_popup() . "\<Plug>(smartinput_C-h)"


" <CR> でポップアップ中の候補を選択し改行する
imap <expr> <CR>
      \ neocomplete#smart_close_popup() . "\<Plug>(smartinput_CR)"

" <CR> でポップアップ中の候補を選択するだけで、改行はしないバージョン
" ポップアップがないときには改行する
imap <expr> <CR> pumvisible() ?
      \ neocomplete#close_popup() : "\<Plug>(smartinput_CR)"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

" For cursor moving in insert mode(Not recommended)
"inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
"inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
"inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
"inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
" Or set this.
"let g:neocomplete#enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplete#enable_insert_char_pre = 1

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.ruby =
\ '[^. *\t]\.\w*\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.php =
\ '[^. \t]->\%(\h\w*\)\?\|\h\w*::\%(\h\w*\)\?'
let g:neocomplete#sources#omni#input_patterns.c =
\ '[^.[:digit:] *\t]\%(\.\|->\)\%(\h\w*\)\?'
let g:neocomplete#sources#omni#input_patterns.cpp =
\ '[^.[:digit:] *\t]\%(\.\|->\)\%(\h\w*\)\?\|\h\w*::\%(\h\w*\)\?'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl =
\ '[^. \t]->\%(\h\w*\)\?\|\h\w*::\%(\h\w*\)\?'

" For smart TAB completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ neocomplete#start_manual_complete()
  function! s:check_back_space() "{{{
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
  endfunction "}}}
"}}}
"---------------------------------------------------------------------------
" neosnippet
"
"{{{
" Snippets Directory
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets, ~/.vim/user-snippets'

" Plugin key-mappings.
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
" Unite.vim
imap <C-s> <Plug>(neocomplete_start_unite_snippet)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable() <Bar><bar> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable() <Bar><bar> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

" Enable snipMate compatibility feature.
" let g:neosnippet#enable_snipmate_compatibility = 1

" with Unit.vim
nnoremap <silent> ,us :<C-u>Unite neosnippet<CR>
"}}}
"---------------------------------------------------------------------------
" VimFiler.vim
"
"{{{
""現在開いているバッファのディレクトリを開く
nnoremap <silent> ,ff :<C-u>VimFilerBufferDir -quit<CR>
"現在開いているバッファをIDE風に開く
nnoremap <silent> ,fi :<C-u>VimFilerBufferDir -split -simple -winwidth=35 -no-quit<CR>
nnoremap <silent> ,fv :<C-u>VimFilerBufferDir -split -simple -winwidth=35 -no-quit<CR>
nnoremap <silent> ,fc :<C-u>VimFilerCurrentDir<CR>
" unite.vim で絞り込み
autocmd FileType vimfiler
      \ nnoremap <buffer><silent>/
      \ :<C-u>Unite file -default-action=vimfiler<CR>
"}}}
"---------------------------------------------------------------------------
" VimShell.vim
"
"{{{
let g:vimshell_user_prompt = 'fnamemodify(getcwd(), ":~")'
"let g:vimshell_right_prompt = 'vcs#info("(%s)-[%b]", "(%s)-[%b|%a]")'
let g:vimshell_enable_smart_case = 1

if has('win32') || has('win64')
  " Display user name on Windows.
  let g:vimshell_prompt = $USERNAME."% "
else
  " Display user name on Linux.
  let g:vimshell_prompt = $USER."% "
endif

" Initialize execute file list.
let g:vimshell_execute_file_list = {}
call vimshell#set_execute_file('txt,vim,c,h,cpp,d,xml,java', 'vim')
let g:vimshell_execute_file_list['rb'] = 'ruby'
let g:vimshell_execute_file_list['pl'] = 'perl'
let g:vimshell_execute_file_list['py'] = 'python'
call vimshell#set_execute_file('html,xhtml', 'gexe firefox')

autocmd FileType vimshell
\ call vimshell#altercmd#define('g', 'git')
\| call vimshell#altercmd#define('i', 'iexe')
\| call vimshell#altercmd#define('l', 'll')
\| call vimshell#altercmd#define('ll', 'ls -l')
\| call vimshell#hook#add('chpwd', 'my_chpwd', 'g:my_chpwd')

function! g:my_chpwd(args, context)
  call vimshell#execute('ls')
endfunction

autocmd FileType int-* call s:interactive_settings()
function! s:interactive_settings()
endfunction

"
"http://nauthiz.hatenablog.com/entry/20101107/1289140518
" ,is: シェルを起動
nnoremap <silent> ,is :VimShell<CR>
" ,irb: irbを非同期で起動
nnoremap <silent> ,irb :VimShellInteractive irb<CR>
" ,pry: pryを非同期で起動
nnoremap <silent> ,pry :VimShellInteractive pry<CR>
" ,gosh goshを非同期で起動
nnoremap <silent> ,gosh :VimShellInteractive gosh<CR>
" ,sqlite sqlite3を非同期で起動
nnoremap <silent> ,sql :VimShellInteractive sqlite3<CR>
" ,ss: 非同期で開いたインタプリタに現在の行を評価させる
vmap <silent> ,ss :VimShellSendString<CR>
" 選択中に,ss: 非同期で開いたインタプリタに選択行を評価させる
nnoremap <silent> ,ss <S-v>:VimShellSendString<CR>
"}}}
"---------------------------------------------------------------------------
" syntastic
"
"{{{
let g:syntastic_javascript_checkers = ['jsl']
let g:syntastic_javascript_jsl_conf = "c:/home/jsl.conf"
"}}}
"---------------------------------------------------------------------------
" QuickRun
"
"{{{

" KEY MAP
let g:quickrun_no_default_key_mappings = 1
silent! map <unique> ,r <Plug>(quickrun)

" config
let g:quickrun_config = {
\   '_': {
\       'output/buffer/split': 'botright 8sp',
\       'hook/time/enable': '1',
\       'runner': 'vimproc',
\       'runner/vimproc/updatetime': 60,
\   },
\   'lua': {
\       'command': 'luajit',
\   },
\}
"}}}
"---------------------------------------------------------------------------
" yankring.vim - Yank / Delete Ring for Vim
"   - http://www.vim.org/scripts/script.php?script_id=1234
"   - http://nanasi.jp/articles/vim/yankring_vim.html
"
"{{{
set viminfo+=!
"}}}
"---------------------------------------------------------------------------
" vim-nyaos
"
"{{{
set runtimepath+=~/.vim/vim-nyaos
" Shell settings.
" Use NYAOS.
set shell=nyaos.exe
set shellcmdflag=-e
set shellpipe=\|&\ tee
set shellredir=>%s\ 2>&1
set shellxquote=\"
"}}}
"---------------------------------------------------------------------------
" Go language
"
"{{{
set runtimepath+=~/.vim/golang
"}}}

"---------------------------------------------------------------------------
" vim-smartinput
"
"{{{
call smartinput#map_to_trigger('i', '<Plug>(smartinput_BS)',
      \                        '<BS>',
      \                        '<BS>')
call smartinput#map_to_trigger('i', '<Plug>(smartinput_C-h)',
      \                        '<BS>',
      \                        '<C-h>')
call smartinput#map_to_trigger('i', '<Plug>(smartinput_CR)',
      \                        '<Enter>',
      \                        '<Enter>')
"}}}

"---------------------------------------------------------------------------
" vim-smartinput-endwise
"
"{{{
call smartinput_endwise#define_default_rules()
"}}}

"---------------------------------------------------------------------------
"  nishigori/increment-activator
"
"{{{
let g:increment_activator_filetype_candidates =
\ {
\   '_': [
\     [
\       'zero', 'one', 'two', 'three', 'four', 'five',
\       'six',  'seven', 'eight', 'nine', 'ten',
\       'eleven', 'twelve', 'thirteen', 'fourteen', 'fifteen',
\       'sixteen', 'seventeen', 'eighteen', 'nineteen', 'twenty'
\     ],
\     [
\       '1st', '2nd', '3rd', '4th', '5th',
\       '6th', '7th', '8th', '9th', '10th',
\       '11th', '12th', '13th', '14th', '15th',
\       '16th', '17th', '18th', '19th', '20th',
\     ],
\     [
\       'first', 'second', 'third', 'fourth', 'fifth',
\       'sixth', 'seventh', 'eighth', 'ninth', 'tenth',
\       'eleventh', 'twelfth', 'thirteenth', 'fourteenth', 'fifteenth',
\       'sixteenth', 'seventeenth', 'eighteenth', 'nineteenth', 'twentieth',
\     ],
\     ['i', 'ii', 'iii', 'iv', 'v', 'vi', 'vii', 'viii', 'ix', 'x'],
\     ['foo', 'bar', 'baz', 'qux', 'quux', 'hoge', 'piyo', 'fuga', 'hogera'],
\     ['left', 'right'],
\     ['top', 'bottom'],
\     ['noth', 'east', 'south', 'west'],
\     ['under', 'over'],
\     ['start', 'stop'],
\     ['begin', 'end'],
\     ['next', 'previous'],
\     ['read', 'write'],
\     ['draw', 'erase'],
\     ['old', 'new'],
\     ['first', 'second', 'th'],
\     ['min', 'max'],
\     ['head', 'body', 'tail'],
\     ['lose', 'find'],
\     ['in', 'out'],
\     ['input', 'output'],
\     ['export', 'inport'],
\     ['parent', 'child', 'children'],
\     ['push', 'pull', 'pop'],
\     ['good', 'bad'],
\     ['same', 'different'],
\     ['create', 'destory'],
\     ['prefix', 'sufix'],
\   ],
\   'ruby': [
\     ['if', 'unless'],
\   ],
\   'php': [
\     ['extends', 'implements'],
\     ['require', 'require_once', 'imclude', 'include_once'],
\   ]
\ }
"}}}

"---------------------------------------------------------------------------
"  vim-surround
"
"{{{
" ruby
autocmd FileType ruby let b:surround_{char2nr("i")} = "if \1condition: \1 \r end"
autocmd FileType ruby let b:surround_{char2nr("d")} = "def \1method: \1 \r end"
" erb
autocmd FileType eruby let b:surround_{char2nr("-")} = "<% \r %>"
autocmd FileType eruby let b:surround_{char2nr("%")} = "<% \r %>"
autocmd FileType eruby let b:surround_{char2nr("=")} = "<%= \r %>"
" php
autocmd FileType php let b:surround_{char2nr("-")} = "<? \r ?>"
autocmd FileType php let b:surround_{char2nr("?")} = "<? \r ?>"
autocmd FileType php let b:surround_{char2nr("=")} = "<?= \r ?>"
autocmd FileType php let b:surround_{char2nr("a")} = "array(\r)"
" javascript
autocmd FileType javascript let b:surround_{char2nr("f")} = "function \1function:\1() {\r}"
autocmd FileType javascript let b:surround_{char2nr("F")} = "function() {\r}"
"}}}
" End Of `Plugins Setting` }}}

"===========================================================================
" Disable Plugins
"===========================================================================
"{{{
""---------------------------------------------------------------------------
""  Viki plugin
""
""{{{
"set runtimepath+=$VIM/viki
"let g:vikiOpenUrlWith_mailto = 'c:\tools\rimarts\b2\b2 %{URL}'
"let g:vikiOpenFileWith_html  = 'silent !w3m %{FILE}'
"let g:vikiOpenFileWith_ANY   = 'silent !start %{FILE}'
"let g:vikiHomePage           = 'C:/home/memo/viki/FrontPage'
"autocmd BufRead,BufNewFile $HOME/memo/viki/* set filetype=viki
""}}}
""---------------------------------------------------------------------------
"" LookupFile
""
""{{{
"nmap <unique> <silent> <C-S> :LUBufs ^.*<CR>
"let g:LookupFile_AlwaysAcceptFirst=1
"let g:LookupFile_PreserveLastPattern=0
"let g:LookupFile_AllowNewFiles=0
"~/.vim/ftplugin/lookupfile.vim
"inoremap <buffer> <TAB> <C-n>
"inoremap <buffer> <S-TAB> <C-p>
"inoremap <buffer> <C-c> <Esc><C-W>q
"nnoremap <buffer> <C-c> <C-W>q
"inoremap <buffer> <C-s> <Esc>:LUPath<CR>
"nnoremap <buffer> <C-s> :LUPath<CR>
""}}}
""---------------------------------------------------------------------------
""  ２ちゃんねる閲覧 plugin
""
""{{{
"set runtimepath+=$VIM/chalice
""}}}

""---------------------------------------------------------------------------
""  一人 wiki 風メモ取り環境 plugin howm_vim
""
""{{{
"set runtimepath+=$VIM/howm_vim
"let g:howm_dir = "$HOME/memo/viki"
"let g:howm_grepprg = "grep"
"let g:howm_findprg = "c:/tools/dos/bin/find"
"" let g:howm_instantpreview = 1
"let g:howm_html2txtcmd = "w3m -dump -cols 78 %s"
"let g:howm_quotemark = "> "
""}}}
""---------------------------------------------------------------------------
""  カレンダー plugin
""
""{{{
"let g:calendar_diary = "$HOME/memo/viki"
""}}}
""---------------------------------------------------------------------------
""  minibufexpl.vim plugin
""
""{{{
"let g:miniBufExplMapWindowNavVim = 1
"let g:miniBufExplMapWindowNavArrows = 1
"let g:miniBufExplMapCTabSwitchBuffs = 1
""}}}
""---------------------------------------------------------------------------
"" neocomplcache
""
""{{{
"" Disable AutoComplPop.
"let g:acp_enableAtStartup = 0
"" Use neocomplcache.
"let g:neocomplcache_enable_at_startup = 1
"" Use smartcase.
"let g:neocomplcache_enable_smart_case = 1
"" Use camel case completion.
"let g:neocomplcache_enable_camel_case_completion = 1
"" Use underbar completion.
"let g:neocomplcache_enable_underbar_completion = 1
"" Set minimum syntax keyword length.
"let g:neocomplcache_min_syntax_length = 3
"let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
"
"" Define dictionary.
"let g:neocomplcache_dictionary_filetype_lists = {
"    \ 'default' : '',
"    \ 'vimshell' : $HOME.'/.vimshell/command-history',
"    \ 'scheme' : $HOME.'/.vim/dict/gosh.dict',
"    \ 'ruby' : $HOME.'/.vim/dict/ruby.dict'
"    \ }
"
"" Define keyword.
"if !exists('g:neocomplcache_keyword_patterns')
"  let g:neocomplcache_keyword_patterns = {}
"endif
"let g:neocomplcache_keyword_patterns['default'] = '\h\w*'
"
"" Plugin key-mappings.
"inoremap <expr><C-g>     neocomplcache#undo_completion()
"inoremap <expr><C-l>     neocomplcache#complete_common_string()
"
"" Recommended key-mappings.
"" <CR>: close popup and save indent.
"" inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
"" inoremap <silent> <CR> <C-R>=<SID>CrInInsertModeBetterWay()<CR>
"inoremap <expr> <silent> <CR> <C-R>=<SID>CrInInsertModeBetterWay()<CR>
"function! s:CrInInsertModeBetterWay()
"  return pumvisible() ? neocomplcache#close_popup()."\<CR>" : "\<CR>"
"endfunction
"
"" <TAB>: completion.
"inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
"" <C-h>, <BS>: close popup and delete backword char.
"inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
"inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
"inoremap <expr><C-y>  neocomplcache#close_popup()
"inoremap <expr><C-e>  neocomplcache#cancel_popup()
"
"" AutoComplPop like behavior.
""let g:neocomplcache_enable_auto_select = 1
"
"" Shell like behavior(not recommended).
""set completeopt+=longest
""let g:neocomplcache_enable_auto_select = 1
""let g:neocomplcache_disable_auto_complete = 1
""inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<TAB>"
""inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
"
"" Enable omni completion.
"autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
"autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
"autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
"autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
"autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
"
"" Enable heavy omni completion.
"if !exists('g:neocomplcache_omni_patterns')
"  let g:neocomplcache_omni_patterns = {}
"endif
"let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
""autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
"let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
"let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'
""}}}
"}}}

"---------------------------------------------------------------------------
" 新規作成時のテンプレート読み込み
"
"{{{
augroup IncludeTemplate
  autocmd!
  autocmd BufNewFile *.rb -r ~/.vim/templates/rb.tpl " Ruby
augroup END
"}}}

" Copyright (C) 2003 KaoriYa/MURAOKA Taro
