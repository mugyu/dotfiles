" Snippets Directory
let g:neosnippet#snippets_directory='~/.cache/dein/repos/github.com/honza/vim-snippets/snippets, ~/.cache/dein/repos/github.com/mugyu/vim-user-snippets'

" Plugin key-mappings.
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
" Unite.vim
imap <C-s> <Plug>(neocomplete_start_unite_snippet)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable() <Bar><bar> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable() <Bar><bar> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

" Enable snipMate compatibility feature.
" let g:neosnippet#enable_snipmate_compatibility = 1

" with Unit.vim
nnoremap <silent> ,us :<C-u>Unite neosnippet<CR>

augroup SnippetsSetting
  autocmd!
  " RubyGems
  autocmd BufNewFile,BufRead *.gemspec NeoSnippetSource ~/.cache/dein/repos/github.com/mugyu/vim-user-snippets/gemspec.snippets
augroup END
