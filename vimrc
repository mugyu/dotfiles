scriptencoding utf-8
source $HOME/.vim/rc/dein.vim
filetype off
" vim:set ts=8 sts=2 sw=2 tw=0 foldmethod=marker:
" (上記の行に関しては:help modelineを参照)
"
" Kariya Vim の $VIM/vimrc を先読みしている前提の設定です。
"
" Last Change: 24-Jul-2017.
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
  colorscheme torte

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
augroup NeoComplateEnableCmniComplation
  autocmd!
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
augroup END

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

augroup SnippetsSetting
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

" highlight
let g:yankround_use_region_hl=1

" cache directory
let g:yankround_dir="~/.cache/yankround"
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
augroup VimSurroundFileTypeSetting
  autocmd!
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
augroup END
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
augroup HowmSetting
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
