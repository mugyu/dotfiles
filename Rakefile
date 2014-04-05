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
  ".*"
]

# debug モードの時は実際のファイル操作を行わない
NOOP = $debug ? true : false

# 対象ファイル
DotFiles = FileList["#{SOURCE_DIR}/*"].exclude(*EXCLUDE_PATTERNS)

desc "対象フアイル一覧"
task :list => DotFiles do
  puts DotFiles.map{|file|File.basename(file)}
end


desc "ハードリンクを張る"
task :hardlink => DotFiles do
  DotFiles.each do |source_file|

    # dotfile にリネーム
    dest_file = make_dest_file_name(source_file)

    if FileTest.exist? dest_file
      unless compare_file source_file, dest_file
        ln dest_file, source_file, force: true, noop: NOOP
      end
    else
      # hard link がいつの間にか切れてた場合は dest をオリジナルとして
      # hard link を張り直す。これは、source が 履歴管理されている事を
      # 前提としている。
      ln source_file, dest_file, force: true, noop: NOOP
    end
  end
end

task :init => DotFiles do
  DotFiles.each do |source_file|
    dest_file = make_dest_file_name(source_file)
    ln source_file, dest_file, force: true, noop: NOOP
  end
end

# source file name から dest file name を生成
def make_dest_file_name(source_file)
    return "#{DEST_DIR}/.#{File.basename(source_file)}"
end
