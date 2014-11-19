-- svnの作業dirでurlを、そしてgitの作業dirでbranch名をプロンプトに出力
--
local function errorlevel()
  return nyaos.option.errorlevel or '0'
end

-- 祖先に向かって目標のディレクトリまたはファイルを探す
local function closest(path, target)
  if not path then
    return false
  end

  if nyaos.access(path .. target, 0) then
    return path .. target
  end

  return closest(string.match(path, '^(.+)\\', 1), target);
end

-- svn url
local function subversion(current)
  if not closest(current, '/.svn') then
    return ''
  end

  local url = string.match(nyaos.eval('svn info --xml 2>&1'), '<url>(.*)</url>', 1)
  if (errorlevel() ~= '0') then
    nyaos.option.errorlevel = '0'
    return ''
  end

  return url and '$e[36;40;1mSVN[' .. url .. ']$_' or ''
end

-- git branch
local function git(current)
  if not closest(current, '/.git') then
    return ''
  end

  local branch = string.match(nyaos.eval('git branch'), '* (%S*)', 1)
  if (errorlevel() ~= '0') then
    nyaos.option.errorlevel = '0'
    return ''
  end

  return branch and '$e[33;40;1mGIT[' .. branch .. ']' or ''
end

-- branch
local function branch(current)
  local branch = git(current)
  if branch ~= '' then
    return branch
  end

  return subversion(current)
end

-- 顔文字
local function face(current)
  local errorlevel = errorlevel()
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
  local face_marke = face(current)
  return true, branch(current) .. face_marke .. prompt
end
