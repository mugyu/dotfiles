scriptencoding utf-8
source $HOME/.vim/rc/dein.vim
filetype off
" vim:set ts=8 sts=2 sw=2 tw=0 foldmethod=marker:
" (上記の行に関しては:help modelineを参照)
"
" Kariya Vim の $VIM/vimrc を先読みしている前提の設定です。
"
" Last Change: 27-Jul-2017.
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
