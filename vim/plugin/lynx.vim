command! -nargs=? Lynx call Lynx_func('<f-args>')
function! Lynx_func(url)
  if a:url == ""
    let url = input("Enter url: ")
  else
    let url = a:url
  endif
  " execute "new|r!c:\\tools\\lynx\\lynx -dump " . url
  execute "r!c:\\tools\\lynx\\lynx -dump " . escape(url, ' #%&')
	normal gg
  set nonumber
  nmap <buffer> <Space> <C-F>
  nmap <buffer> <S-Space> <C-B>
  nmap <buffer> <C-CR> :bdelete!<CR>
endfunction

