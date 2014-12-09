"=============================================================================
" FILE: uri_openbrowser.vim
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

function! unite#kinds#uri_openbrowser#define() 
  return s:kind
endfunction

let s:kind = {
      \ 'name' : 'uri_openbrowser',
      \ 'default_action' : 'openbrowser',
      \ 'action_table' : {},
      \}

" Actions
let s:kind.action_table.openbrowser= {
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

function! s:kind.action_table.openbrowser.func(candidates) 
  for candidate in a:candidates
    call openbrowser#open(s:get_path(candidate))
  endfor
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: foldmethod=marker
