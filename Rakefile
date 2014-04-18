# coding: utf-8

SOURCE_DIR = File.dirname(File.expand_path(__FILE__))
DEST_DIR =  File.expand_path("~/")

# 無視リスト
EXCLUDE_PATTERNS = [
  /[Rr]akefile/,
  "*.rake",
  "*.bak",
  "*~",
  "*.swp",
  ".*",
  "Thumbs.db"
]

# debug モードの時は実際のファイル操作を行わない
NOOP = $DEBUG ? true : false

# 対象ファイル
DotFiles = FileList["#{SOURCE_DIR}/*"].exclude(*EXCLUDE_PATTERNS)

# source file name から dest file name を生成
def make_dest_file_name(source_file)
  return "#{DEST_DIR}/.#{File.basename(source_file)}"
end

# 実行した環境の OS が Windows
def os_is_Windows?
  ENV['OS'].match("Windows") ? true : false
end

# Windows 環境用に mklink の事前準備
def preparation_mklink(source_file, dest_file)
  if FileTest.exist? dest_file
    if FileTest.identical? source_file, dest_file
      rm dest_file, noop: NOOP
    else
      mv dest_file, "#{source_file}.~temp~.bak", noop: NOOP
    end
  end
end

# Windows 環境用 mklink
def mklink(source_file, dest_file)
  mklink = "cmd /c mklink"
  mklink << " /d" if FileTest.directory? source_file
  cmd = "#{mklink} #{dest_file.gsub("/", "\\")} #{source_file.gsub("/", "\\")}"

  if NOOP
    puts cmd
    return true
  else
    begin
      return sh cmd
    rescue RuntimeError
      return false
    end
  end
end


desc "対象フアイル一覧"
task :list => DotFiles do
  puts DotFiles.map{|file|File.basename(file)}
end

desc "シンボリックリンクを張る"
task :symlink => DotFiles do
  DotFiles.each do |source_file|

    # dotfile にリネーム
    dest_file = make_dest_file_name(source_file)

    if os_is_Windows?
      # Windows 環境では ln -s の代わりに mklink を実行
      # 失敗 == 管理者権限無し と判断して即時停止
      preparation_mklink source_file, dest_file
      exit unless mklink source_file, dest_file
    else
      ln_s source_fle, dest_file, force: true, noop: NOOP
    end
  end
end
