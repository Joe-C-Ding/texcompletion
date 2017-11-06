" tex.vim	vim: ts=8 sw=4 ff=unix
" Language:	plain TeX
" Maintainer:	Joe Ding
" Version:	0.1
" Last Change:	2017-11-06 09:22:35

if &cp || exists("g:loaded_plaintex")
    finish
endif
let g:loaded_plaintex = 1

let s:keepcpo = &cpo
set cpo&vim

set completefunc=texcompletion#Cmp_command

let &cpo = s:keepcpo
unlet s:keepcpo
