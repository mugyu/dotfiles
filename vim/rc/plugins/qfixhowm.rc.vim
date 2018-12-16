" キーマップリーダー
let g:qfixmemo_mapleader = ',h'
" howm_dirはファイルを保存したいディレクトリを設定
let g:howm_dir             = '~/howm'
let g:howm_filename        = '%Y/%m/%Y-%m-%d-%H%M%S.md'
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
