require 'irb/completion'
require 'irb/ext/save-history'
require 'readline'
require 'pp'

IRB.conf[:USE_READLINE] = true
IRB.conf[:SAVE_HISTORY] = 2000
IRB.conf[:HISTORY_PATH] = File.expand_path("~/.irb.history")
