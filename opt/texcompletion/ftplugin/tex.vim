" tex.vim	vim: ts=8 sw=4 ff=unix
" Language:	TeX
" Maintainer:	Joe Ding
" Version:	0.1
" Last Change:	2017-11-06 09:22:48

if &cp || exists("g:loaded_tex")
    finish
endif
let g:loaded_tex = 1

let s:keepcpo = &cpo
set cpo&vim

set completefunc=texcompletion#Cmp_command

let &cpo = s:keepcpo
unlet s:keepcpo
