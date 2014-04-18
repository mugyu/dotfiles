-- svnの作業dirでurlを、そしてgitの作業dirでbranch名をプロンプトに出力
--
-- svn url
local function subversion(current)
  local svn_url = string.match(nyaos.eval('svn info --xml'), '<url>(.*)</url>', 1)
  return '$e[36;40;1mSVN[' .. svn_url .. ']$_'
end

-- git branch
local function git(current)
  local git_path = current
  repeat
    if nyaos.access(git_path .. '/.git', 0) then
      local git_branch = string.match(nyaos.eval('git branch'), '* (%S*)', 1)
      if git_branch then
        return '$e[33;40;1mGIT[' .. git_branch .. ']'
      end
      break
    end
    git_path = string.match(git_path, '^(.+)\\', 1)
  until not git_path
  return ''
end

-- 顔文字
local function face(current)
  local errorlevel = (nyaos.option.errorlevel or '0')
  if errorlevel == '0' then
    return "$e[32;40;1m( *'v')$e[37;40;1m "
  else
    return "$e[33;41;1m( #> <)< " .. errorlevel .. "$e[37;40;1m "
  end
  return ''
end

-- dynamic prompt
function nyaos.prompt(prompt)
  local current = nyaos.eval('__pwd__')
  if nyaos.access(current .. '/.svn/entries', 0) then
    return true, subversion(current) .. face(current) .. prompt
  else
    return true, git(current) .. face(current) .. prompt
  end
  return nil, prompt
end
