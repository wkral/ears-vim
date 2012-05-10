" Set configurable default host and port
if !exists('g:ears_host_port')
    let g:ears_host_port = 'localhost 3277'
endif

" Send the filename that was just written to the ears server
function! SendFileChange (filename)
    let cmd = 'echo -n "' . a:filename . '" | nc ' . g:ears_host_port
    call system(cmd)
endfunction

" Connect to the file writing event but first removing all existing event
" handlers
augroup ears
autocmd! ears
autocmd ears BufWritePost * call SendFileChange(expand("%:p"))
