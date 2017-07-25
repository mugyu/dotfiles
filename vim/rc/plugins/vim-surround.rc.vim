augroup VimSurroundFileTypeSetting
  " ruby
  autocmd!
  autocmd FileType ruby let b:surround_{char2nr("i")} = "if \1condition: \1 \r end"
  autocmd FileType ruby let b:surround_{char2nr("d")} = "def \1method: \1 \r end"
  " erb
  autocmd FileType eruby let b:surround_{char2nr("-")} = "<% \r %>"
  autocmd FileType eruby let b:surround_{char2nr("%")} = "<% \r %>"
  autocmd FileType eruby let b:surround_{char2nr("=")} = "<%= \r %>"
  " php
  autocmd FileType php let b:surround_{char2nr("-")} = "<? \r ?>"
  autocmd FileType php let b:surround_{char2nr("?")} = "<? \r ?>"
  autocmd FileType php let b:surround_{char2nr("=")} = "<?= \r ?>"
  autocmd FileType php let b:surround_{char2nr("a")} = "array(\r)"
  " javascript
  autocmd FileType javascript let b:surround_{char2nr("f")} = "function \1function:\1() {\r}"
  autocmd FileType javascript let b:surround_{char2nr("F")} = "function() {\r}"
augroup END
