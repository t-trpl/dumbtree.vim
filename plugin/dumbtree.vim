" Tyler Triplett
" dumbtree.vim

let g:dumbtreeBuffers = []

function ToggleExplore()
    let currBufNum = (bufnr('%'))
    if &ft ==# 'netrw' 
        let ind = len(g:dumbtreeBuffers) - 1
        if ind > -1
            if buflisted(g:dumbtreeBuffers[ind])
                execute 'buffer' g:dumbtreeBuffers[ind]
            else
                call remove(g:dumbtreeBuffers, ind)
                echo "removed invalid buffer"
            endif
        else
            echo "no buffer"
        endif
    else
        execute 'Explore'
    endif
endfunction

function SaveTwoRecent()
    let currBufNum = bufnr('%')
    if !buflisted(currBufNum)
        return
    endif
    let isRecentInd = index(g:dumbtreeBuffers, currBufNum)
    if isRecentInd != -1
        call remove(g:dumbtreeBuffers, isRecentInd)
    endif
    call add(g:dumbtreeBuffers, currBufNum)
    if len(g:dumbtreeBuffers) > 2 
        call remove(g:dumbtreeBuffers, 0)
    endif
endfunction

function FastSwap()
    if len(g:dumbtreeBuffers) < 1
        echo "no buffers..."
    else
        let rb = g:dumbtreeBuffers[0]
        if bufnr('%') == rb
            echo "can't fastswap to nothing..."
        else
            execute 'buffer' rb
        endif
    endif
endfunction

nnoremap <F3> :call FastSwap()<CR>
nnoremap <F2> :call ToggleExplore()<CR>

" Without a timer the :Explore buffer gets saved to the most recent. I have
" no idea why.
autocmd BufEnter * call timer_start(100, {-> SaveTwoRecent()})
" autocmd BufEnter * call SaveTwoRecent()
