"" dumbtree.vim 

let g:recent_buffers = []

function ToggleExplore()
    if &ft == 'netrw'
        let ind = len(g:recent_buffers) - 1
        if ind > -1
            execute 'buffer' g:recent_buffers[ind]
        else 
            echo "nothing backwards!"
        endif
    else
        execute 'Explore'
    endif
endfunction

function StoreRecentBuffers()
    let cb = bufnr('%')
    if &filetype != 'netrw' 
        let idx = index(g:recent_buffers, cb)
        if idx != -1
            call remove(g:recent_buffers, idx)
        endif
        call add(g:recent_buffers, cb)
        if len(g:recent_buffers) > 2
            call remove(g:recent_buffers, 0)
        endif
    endif
endfunction

function FastSwap()
    if len(g:recent_buffers) < 1
        echo "no buffers..."
    else 
        let rb = g:recent_buffers[0]
        if bufnr('%') == rb
            echo "can't fastswap to nothing..."
        else
            execute 'buffer' rb
        endif
    endif
endfunction

nnoremap <F3> :call FastSwap()<CR>
nnoremap <F2> :call ToggleExplore()<CR>

" a hack job. i cannot figure out a way to ensure the buffer's filetype gets set
" before i store the buffer. so what was happening is when it was called on
" :Explore the file type would be set to '' but just for the first iteration.
" i need to retain the order in which they were most recently accessed, so i
" think this may be the only way...
autocmd BufEnter * call timer_start(10, {-> StoreRecentBuffers()})
