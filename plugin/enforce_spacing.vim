" vim: set foldlevel=0 foldmethod=marker:

" {{{ Function: EnforceSpacesToTabs

" Replaces leading whitespace with tabs (up to 12 levels)
"
fun! g:EnforceSpacesToTabs()
    try
        exe ':%s/^    /\t'
        exe ':%s/^\t    /\t\t'
        exe ':%s/^\t\t    /\t\t\t'
        exe ':%s/^\t\t\t    /\t\t\t\t'
        exe ':%s/^\t\t\t\t    /\t\t\t\t\t'
        exe ':%s/^\t\t\t\t\t    /\t\t\t\t\t\t'
        exe ':%s/^\t\t\t\t\t\t    /\t\t\t\t\t\t\t'
        exe ':%s/^\t\t\t\t\t\t\t    /\t\t\t\t\t\t\t\t'
        exe ':%s/^\t\t\t\t\t\t\t\t    /\t\t\t\t\t\t\t\t\t'
        exe ':%s/^\t\t\t\t\t\t\t\t\t    /\t\t\t\t\t\t\t\t\t\t'
        exe ':%s/^\t\t\t\t\t\t\t\t\t\t    /\t\t\t\t\t\t\t\t\t\t\t'
        exe ':%s/^\t\t\t\t\t\t\t\t\t\t\t    /\t\t\t\t\t\t\t\t\t\t\t\t'
    catch
    endtry
endfun

" }}}
" {{{ Function: EnforceTabsToSpaces

" Replaces tabs with spaces
"
fun! g:EnforceTabsToSpaces()
    try
        exe ':%s/\t/    /g'
    catch
    endtry
endfun

" }}}
" {{{ Function: ToggleTabsVsSpaces

" Toggles vim settings between tabs and spaces
fun! g:ToggleTabsVsSpaces(which)
    if a:which == "tabs"
        set noexpandtab
        set shiftwidth=4
        set tabstop=4
        set softtabstop=0
    endif
    if a:which == "spaces"
        set expandtab
        set shiftwidth=4
        set tabstop=4
        set softtabstop=4
    endif
endfun

" }}}
" {{{ Function: EnforceTabsVsSpaces

" Detect whether we should use tabs or spaces for this buffer and set up
" accordingly
"
fun! g:EnforceTabsVsSpaces()
    let enforce = 'none'
    if exists('b:enforceTabs') && b:enforceTabs == 'y'
        let enforce = 'tabs'
    elseif exists('b:enforceSpaces') && b:enforceSpaces == 'y'
        let enforce = 'spaces'
    elseif exists('g:enforceTabs') && g:enforceTabs == 'y'
        let enforce = 'tabs'
    elseif exists('g:enforceSpaces') && g:enforceSpaces == 'y'
        let enforce = 'spaces'
    endif
    if enforce == 'tabs'
        call g:ToggleTabsVsSpaces('tabs')
        call g:EnforceSpacesToTabs()
    elseif enforce == 'spaces'
        call g:ToggleTabsVsSpaces('spaces')
        call g:EnforceTabsToSpaces()
    endif
endfun

" }}}
" {{{ Function: EnforceTrailingWhitespace

" Detect whether we should clear out trailing whitespace on write
"
fun! g:EnforceTrailingWhitespace()
    let this_ext  = expand('%:e')
    let this_file = expand('%:t')

    let enforce = {}
    if exists('b:enforceNoTrailingWhitespace')
        let enforce = b:enforceNoTrailingWhitespace
    elseif exists('g:enforceNoTrailingWhitespace')
        let enforce = g:enforceNoTrailingWhitespace
    endif

    let ignore = {}
    if exists('b:ignoreTrailingWhitespace')
        let ignore = b:ignoreTrailingWhitespace
    elseif exists('g:ignoreTrailingWhitespace')
        let ignore = g:ignoreTrailingWhitespace
    endif

    if has_key(enforce, this_ext) && enforce[this_ext] == 'y'
        if has_key(ignore, this_file) && ignore[this_file] == 'y'
        else
            :%s/\s\+$//e
        endif
    endif
endfun

" }}}

" Correct for tabs and spaces after read and before write
if &diff
else
    autocmd BufWritePre *.* :call g:EnforceTabsVsSpaces()
    autocmd BufWritePre *.* :call g:EnforceTrailingWhitespace()
endif

