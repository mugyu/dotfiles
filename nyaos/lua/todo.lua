function nyaos.command.todo()
  local cmd = 'jvgrep -n "\\b(TODO|FIXME|OPTIMIZE|HACK|REVIEW)\\b" **/* \
               | nkf -w \
               | peco \
               | nkf -s'
  local line = nyaos.eval(cmd)
  if line == "" then
    print("")
  else
    local path, number = line:match("(.-):(.-):")
--    local editor = os.getenv("EDITOR")
    local editor = "gvim"
    local editor_cmd = editor ..
                       " +" .. number ..
                       " \034" .. path .. "\034"
    print(editor_cmd)
    nyaos.exec(editor_cmd)
  end
end
