function nyaos.command.pcd()
  local cmd = "find . -type d -maxdepth 1 \
               | grep -v -F /. \
               | grep -v -E \\.$ \
               | sed -e 's/^.\\///' \
               | nkf -w \
               | peco \
               | nkf -s"
  local path = nyaos.eval(cmd)
  if path ~= "" then
    nyaos.exec("cd " .. path)
  end
end
