command! -nargs=? Wm call W3m('<f-args>')
function! W3m(url)
  if a:url == ""
    let url = input("Enter url: ")
  else
    let url = a:url
  endif
  " execute "new|r!w3m -dump -cols 76 -S " . url
  execute "r!w3m -dump -cols 76 -S " . escape(url, ' #%&')
	normal gg
  set nonumber
  nmap <buffer> <Space> <C-F>
  nmap <buffer> <S-Space> <C-B>
  nmap <buffer> <C-CR> :bdelete!<CR>
endfunction
