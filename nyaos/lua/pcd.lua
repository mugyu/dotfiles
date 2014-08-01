function nyaos.command.pcd()
  local cmd = "find . -type d -maxdepth 2 | grep -v -F \\. | nkf -w | peco | nkf -s"
  local path = nyaos.eval(cmd)
  if path ~= "" then
    nyaos.exec("cd " .. path)
  end
end
