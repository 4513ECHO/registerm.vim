if exists('g:loaded_registerm')
  finish
endif
let g:loaded_registerm = v:true

tnoremap <expr> <Plug>(registerm) registerm#do(v:register)
tnoremap <expr> <Plug>(registerm-getchar) registerm#do(getcharstr())
