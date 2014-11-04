-- svnの作業dirでurlを、そしてgitの作業dirでbranch名をプロンプトに出力
--
-- 祖先に向かって目標のディレクトリまたはファイルを探す
local function closest(current, target)
  local path = current
  repeat
    if nyaos.access(path .. target, 0) then
      return path .. target
    end
    path = string.match(path, '^(.+)\\', 1)
  until not path
  return false
end

-- svn url
local function subversion(current)
  if not closest(current, '/.svn') then
    return ''
  end

  local url = string.match(nyaos.eval('svn info --xml'), '<url>(.*)</url>', 1)
  return url and '$e[36;40;1mSVN[' .. url .. ']$_' or ''
end

-- git branch
local function git(current)
  if not closest(current, '/.git') then
    return ''
  end

  local branch = string.match(nyaos.eval('git branch'), '* (%S*)', 1)
  return branch and '$e[33;40;1mGIT[' .. branch .. ']' or ''
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
  local branch = git(current)
  if branch == '' then
    branch = subversion(current)
  end

  if branch ~= '' then
    return true, branch .. face(current) .. prompt
  end
  return nil, prompt
end
