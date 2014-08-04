function nyaos.command.gitbra()
  local cmd = "git branch \
               | nkf -w \
               | peco \
               | nkf -s"
  local branch = nyaos.eval(cmd)
  if branch == "" then
    print("")
  else
    nyaos.exec("git co " .. string.sub(branch, 3))
  end
end
