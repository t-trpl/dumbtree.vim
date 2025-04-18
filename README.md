# About
- A simple 'Explore' wrapper. Nerdtree is too powerful, and it also did not do something I wanted. A fast swap to previous buffer.
  
# Usage
- ToggleExplore(): toggles between :Explore and previous buffer
- FastSwap() : toggles between the last two buffers if possible
  
# Default mappings
- F2 To open the explorer
- F3 To toggle the last buffer

# Known "Issue"
- for some reason i need "autocmd BufEnter * call timer_start(100, {-> SaveTwoRecent()})" for proper Fast Swapping. If you know how to fix this please let me know.
