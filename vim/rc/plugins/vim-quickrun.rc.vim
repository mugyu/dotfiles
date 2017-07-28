" KEY MAP
let g:quickrun_no_default_key_mappings = 1
silent! map <unique> ,r <Plug>(quickrun)

" config
let g:quickrun_config = {
\   '_': {
\       'output/buffer/split': 'botright 8sp',
\       'hook/time/enable': '1',
\       'runner': 'job',
\       'outputter/buffer/close_on_empty': 1,
\   },
\   'lua': {'command': 'luajit'},
\}
