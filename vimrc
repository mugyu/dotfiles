set nocompatible
scriptencoding utf-8
filetype off
" vim:set ts=8 sts=2 sw=2 tw=0 foldmethod=marker:
" (上記の行に関しては:help modelineを参照)
"
" Kariya Vim の $VIM/vimrc を先読みしている前提の設定です。
"
" Last Change: 30-Jul-2014.
"

"---------------------------------------------------------------------------
" 検索の挙動に関する設定:
"
"{{{
" インクリメンタルサーチを行う
set incsearch
" grep の設定を 'findstr /n' から jvgrep へ変更(win32の defult は findstr)
set grepprg=jvgrep\ -8
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
" windows の clipboard用に @" と @* を共用
set clipboard+=unnamedplus,unnamed
" コマンド K に使われるヘルプの default を :help にする 
set keywordprg=:help
"}}}

"---------------------------------------------------------------------------
" GUI固有ではない画面表示の設定:
"
"{{{
" ユニコードの全角か半角か曖昧な記号を全角表示する
set ambiwidth=double
" ステータスラインに文字コードと改行文字を表示
"set statusline=%<[%n]%f\ %m%r%h%w%{'['.(&fenc==''?&enc:&fenc).']['.&ff.']['.(%ft==''?'n/a':&ft).']'}%=%l,%c%V%8P
set statusline=%<[%n]%f\ %m%r%h%w%{'['.(&fenc==''?&enc:&fenc).']['.&ff.']'}%y%=%l,%c%V%8P 

" カラースキーム (Windows用gvim使用時はgvimrcを編集すること)
syntax enable
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
" プラットホーム依存の特別な設定
"
"{{{
if has('win32')
  " runtimepath を unix like に設定
  let &runtimepath = '~/.vim,' . &runtimepath . ',~/.vim/after'
endif
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
"

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
" NeoBundle
"
"{{{

" NeoBundle "{{{
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
endif

call neobundle#begin(expand('~/.vim/bundle'))

NeoBundleFetch 'Shougo/neobundle.vim'
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
" howm 一人お手軽wikiもどき
"{{{
NeoBundle 'osyo-manga/unite-qfixhowm'
let s:bundle = neobundle#get('unite-qfixhowm')
function! s:bundle.hooks.on_source(bundle)
  call unite#custom_source('qfixhowm', 'sorters',
       \ ['sorter_qfixhowm_updatetime', 'sorter_reverse'])
endfunction
unlet s:bundle
" keymap
nnoremap <silent> ,uh  :<C-u>Unite -no-start-insert qfixhowm<CR>
"}}}
"}}}

" NeoComplate ポップアップ補完
NeoBundle 'Shougo/neocomplete.vim'
" NeoSnippet.vim スニペットのポップアップ補完
"{{{
NeoBundle 'Shougo/neosnippet.vim'
" 個人用 snippets
NeoBundle 'mugyu/vim-user-snippets'
" neosnip.vim の default snippets
NeoBundle 'Shougo/neosnippet-snippets'
" その他 snippets
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
  \| call vimshell#hook#add('chpwd', 'my_chpwd', 'MyChpwd')

  function! MyChpwd(args, context)
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
  " Edit file by tabedit.
  "let g:vimfiler_edit_action = 'tabopen'

  " Enable file operation commands.
  "let g:vimfiler_safe_mode_by_default = 0

  " Use trashbox.
  " Windows only and require latest vimproc.
  let g:unite_kind_file_use_trashbox = 1

  " vimデフォルトのエクスプローラをvimfilerで置き換える
  let g:vimfiler_as_default_explorer = 1
  " カレントディレクトリを自動で変更する
  let g:vimfiler_enable_auto_cd = 1
  " 現在開いているバッファのディレクトリを開く
  nnoremap <silent> ,f :<C-u>VimFilerBufferDir -quit<CR>
  " 現在開いているバッファをIDE風に開く
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
" レジスタの履歴を取得・再利用する<c-p>, <c-n>
NeoBundle "LeafCage/yankround.vim"
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
" QFixHowm 一人お手軽wikiもどき
NeoBundle 'fuenor/qfixhowm'

" colorscheme 'tomasr/molokai'
NeoBundle 'tomasr/molokai'

" remote でプログラムのbuild and nunした結果を返す
NeoBundle 'rhysd/wandbox-vim'

" disable
"{{{
"NeoBundle 'Shougo/neocomplcache'
"}}}

call neobundle#end()
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
nnoremap <silent> ,uR :<C-u>Unite -buffer-name=register register history/yank<CR>
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
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets, ~/.vim/bundle/vim-user-snippets'

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

augroup SNIPPETS_AUGROUP
  autocmd!
  " RubyGems
  autocmd BufNewFile,BufRead *.gemspec NeoSnippetSource ~/.vim/bundle/vim-user-snippets/gemspec.snippets
augroup END
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
"}}}

"---------------------------------------------------------------------------
" VimShell.vim
"
"{{{
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
let g:syntastic_javascript_args = '-conf "c:/home/jsl.conf"'
let g:syntastic_ruby_checkers = ['mri', 'rubocop']
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
\       'outputter/buffer/close_on_empty': 1,
\       'runner/vimproc/updatetime': 60,
\   },
\   'lua': {'command': 'luajit'},
\}
" with wandbox-vim
let g:quickrun_config = {
\   'groovy':  {'runner': 'wandbox'},
\   'haskell': {'runner': 'wandbox'},
\   'pascal':  {'runner': 'wandbox'},
\   'php':     {'runner': 'wandbox'},
\   'python':  {'runner': 'wandbox'},
\   'rust':    {'runner': 'wandbox'},
\}
"}}}

"---------------------------------------------------------------------------
" yankround.vim
"
"{{{
" keymap
nmap p <Plug>(yankround-p)
xmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap gp <Plug>(yankround-gp)
xmap gp <Plug>(yankround-gp)
nmap gP <Plug>(yankround-gP)
nmap <C-p> <Plug>(yankround-prev)
nmap <C-n> <Plug>(yankround-next)

" yankound history with unite.vim
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=yankound yankround<CR>
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
\     ['some', 'any', 'every', 'no'],
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

"---------------------------------------------------------------------------
" QFixHowm
"
"{{{
" キーマップリーダー
let g:qfixmemo_mapleader = ',h'
" howm_dirはファイルを保存したいディレクトリを設定
let g:howm_dir             = '~/howm'
let g:howm_filename        = '%Y/%m/%Y-%m-%d-%H%M%S.mkd'
let g:howm_fileencoding    = 'utf8'
let g:howm_fileformat      = 'unix'
" QFixHowmのファイルタイプ
let g:QFixHowm_FileType    = 'markdown'
" タイトル記号
let g:QFixHowm_Title       = '#'
" キーコードやマッピングされたキー列が完了するのを待つ時間(ミリ秒)
set timeout timeoutlen=3000 ttimeoutlen=100
" プレビューや絞り込みをQuickFix/ロケーションリストの両方で有効化(デフォルト:2)
let g:QFixWin_EnableMode = 1
" textwidthの再設定
augroup HOWM_AUGROUP
  autocmd!
  autocmd Filetype qfix_memo setlocal textwidth=0
augroup END
" 休日定義ファイル
let g:QFixHowm_HolidayFile = '~/howm/Sche-Hd-0000-00-00-000000.utf8'
" GMTとの時差
let g:QFixHowm_ST = -9
" 外部grepの指定
let g:mygrepprg = 'jvgrep'
" 外部grep(OS)のshellエンコーディング
let g:MyGrep_ShellEncoding = 'utf-8'
"" マルチエンコーディングgrepを使用する
"let g:MyGrep_MultiEncoding = 1

" MRU表示数
let g:QFixMRU_Entries      = 30
" MRUの保存ファイル名
let g:QFixMRU_Filename     = '~/howm/qfixmru'
" MRUに登録しないファイル名(正規表現)
let g:QFixMRU_IgnoreFile   = ''
" MRUに登録するファイルの正規表現(設定すると指定ファイル以外登録されない)
let g:QFixMRU_RegisterFile = ''
" MRUに登録しないタイトル(正規表現)
let g:QFixMRU_IgnoreTitle  = ':invisible'
" MRUでエントリタイトルと見なす正規表現
let g:QFixMRU_Title = {
\   'java': '^\s*public.*(.*).*{',
\   'js':   '^\s*function',
\   'php':  '^\s*function',
\   'py':   '^def',
\   'rb':   '^\s*def',
\   'vim':  '^\s*\(silent!\?\)\?\s*function',
\   'howm': '^=\([^=]\|$\)',
\   'txt':  '^=\([^=]\|$\)',
\   'mkd':  '^#',
\}

" MRU内部のエントリ最大保持数
let g:QFixMRU_EntryMax     = 300
"}}}

" End Of `Plugins Setting` }}}

filetype plugin on
filetype indent on
