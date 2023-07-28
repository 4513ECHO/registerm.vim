function! s:term_insert(content) abort
  if has('nvim')
    call chansend(b:terminal_job_id, a:content)
  else
    call term_sendkeys(bufnr(), a:content->join("\n"))
    call term_wait(bufnr())
  endif
endfunction

function! s:nvim_quote_equal() abort
  augroup term_insert_register
    autocmd!
    autocmd ModeChanged c:nt ++once call feedkeys('i', 'n')
    autocmd ModeChanged nt:t ++once call s:term_insert(getreg('='))
  augroup END
endfunction

if has('nvim')
  function! registerm#do(regname) abort
    return a:regname ==# '='
          \ ? s:nvim_quote_equal() ?? "\<C-\>\<C-n>\"="
          \ : $"\<C-\>\<C-n>\"{a:regname}pi"
  endfunction
else
  function! registerm#do(regname) abort
    return a:regname ==# '='
          \ ? "\<C-w>\"="
          \ : s:term_insert(getreg(a:regname, 1, 1)) ?? ''
  endfunction
endif
