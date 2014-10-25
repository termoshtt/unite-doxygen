" FILE: doxygen.vim
" AUTHOR:  Toshiki TERAMUREA <toshiki.teramura@gmail.com>
" Last Modified: 24 Oct 2014
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

" Variables
call unite#util#set_default('g:unite_doxygen_home','')

let s:source = {
      \ 'name': 'doxygen',
      \ 'description' : 'Links for Doxygen HTML',
      \ 'hooks' : {},
      \ }

let s:here = expand('<sfile>:p:h')
let s:xslt = expand(s:here . "/../../../format.xslt")

function! s:source.gather_candidates(args,context)
  let result = vimproc#system('Xalan '.g:unite_doxygen_home.'/searchdata.xml '.s:xslt)
  let candidates = []
  for line in split(result, "\n")
    let words = split(line, " ")
    let addr = expand(g:unite_doxygen_home."/html/".words[0])
    let category = words[1]
    let description = join(words[2:], " ")
    call add(candidates, {"addr":addr, "category":category, "description":description})
  endfor
  return map(candidates,'{
  \   "word": v:val["category"]." ".v:val["description"],
  \   "source": "doxygen",
  \   "kind": "uri",
  \   "action__uri": "file://".v:val["addr"]
  \ }')
endfunction

function! s:source.hooks.on_syntax(args, context)
  syntax match uniteSource__Doxygen_DocType /^\s\+\w\+/
  highlight uniteSource__Doxygen_DocType ctermfg=green
endfunction

function! unite#sources#doxygen#define() 
  return s:source
endfunction 

" vim: foldmethod=marker
