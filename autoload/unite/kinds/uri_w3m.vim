"=============================================================================
" FILE: uri_w3m.vim
" AUTHOR:  Toshiki Teramura <toshiki.teramura@gmail.com>
" License: MIT license  {{{
"     Permission is hereby granted, free of charge, to any person obtaining
"     a copy of this software and associated documentation files (the
"     "Software"), to deal in the Software without restriction, including
"     without limitation the rights to use, copy, modify, merge, publish,
"     distribute, sublicense, and/or sell copies of the Software, and to
"     permit persons to whom the Software is furnished to do so, subject to
"     the following conditions:
"
"     The above copyright notice and this permission notice shall be included
"     in all copies or substantial portions of the Software.
"
"     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
"     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
"     MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
"     IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
"     CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
"     TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
"     SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
" }}}
"=============================================================================

let s:save_cpo = &cpo
set cpo&vim

function! unite#kinds#uri_w3m#define() 
  return s:kind
endfunction

let s:kind = {
      \ 'name' : 'uri_w3m',
      \ 'default_action' : 'w3m',
      \ 'action_table' : {},
      \}

" Actions
let s:kind.action_table.w3m= {
      \ 'description' : 'open uri by browser (using OpenBrowser)',
      \ 'is_selectable' : 1,
      \ }

function! s:get_path(candidate) 
  let path = has_key(a:candidate, 'action__uri') ?
        \ a:candidate.action__uri : a:candidate.action__path
  if unite#util#is_windows() && path =~ '^//'
    " substitute separator for UNC.
    let path = substitute(path, '/', '\\', 'g')
  endif
  return path
endfunction 

function! s:kind.action_table.w3m.func(candidates) 
  for candidate in a:candidates
    call w3m#Open(g:w3m#OPEN_TAB, "local", s:get_path(candidate))
  endfor
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: foldmethod=marker
