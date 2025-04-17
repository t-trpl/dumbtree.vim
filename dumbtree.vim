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
    let ft = getbufvar(cb, '&filetype')
    if ft != 'netrw' && ft != ''
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

autocmd BufEnter * call StoreRecentBuffers()
