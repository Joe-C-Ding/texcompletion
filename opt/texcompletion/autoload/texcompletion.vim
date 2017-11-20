" texcompletion.vim	vim: ts=8 sw=4 ff=unix
" Language:	TeX / LaTeX
" Maintainer:	Joe Ding
" Version:	0.8
" Last Change:	2017-11-15 21:53:57

let s:keepcpo = &cpo
set cpo&vim

let s:ctrl_seq = []
function s:load_file(file)
    noautocmd exec 'vs +set\ noswf\ buftype=nowrite '.fnameescape(a:file)
    let line = getline(1, "$")

    let file = fnamemodify(a:file, ":t:r")
    let menu = substitute(file, '^[^_]*_', '', '')
    let dict = map(line,'{"word": v:val, "menu":"'.menu.'", "file":"'.file.'"}')
    call extend(s:ctrl_seq, s:fill_menu(dict))

    bwipeout
endfunction

function s:fill_menu(dict)
    for d in a:dict
	let sp = split(d.word, "\t")
	if len(sp) > 1
	    let d.word = sp[0]
	    let d.menu .= "-".sp[1]
	endif
    endfor

    return a:dict
endfunction

if empty(s:ctrl_seq)	" load completion now
    let files = expand("<sfile>:p:h") . '/../control_sequences/*.txt'
    let files = glob(files, 0, 1)
    if !empty(files)
	for f in files
	    call s:load_file(f)
	endfor

	call sort(s:ctrl_seq, {i1, i2 -> i1.word>i2.word ? 1 : -1})
    endif
endif

function! texcompletion#Cmp_command(findstart, base)
    if a:findstart
	" locate the start of the \commands (control sequences)
	let line = getline('.')
	let curr = col('.') - 2
	let start = match(line[0:curr], '^.*\zs\\')
	if start < 0
	    " -2 To cancel silently and stay in completion mode.
	    let start = -2
	endif
	return start

    else
	" find \commands matching with "a:base"
	" \commands are come from local buffer and basic commands
	let local = []

	" reverse buffer to simulate the <C-P> behavior
	let buf = reverse(getbufline("%", 1, "$"))
	let curr= line(".")
	let buf = buf[-curr:] + buf[0:curr-1]

	call filter(buf, 'v:val =~ "\\\\\\a\\+"')
	for line in buf
	    let strpos = matchstrpos(line, '\\\a\+')
	    while strpos[0] != ""
		call add(local, {"word": strpos[0]})
		let strpos = matchstrpos(line, '\\\a\+', strpos[2])
	    endwhile
	endfor

	let others = s:ctrl_seq
	if &ft == "plaintex"
	    call filter(others, 'v:val.file =~ "^tex_"')
	endif

	return filter(local + others, 'v:val.word =~ "^\\\\'.a:base[1:].'"')
    endif
endfunction

let &cpo = s:keepcpo
unlet s:keepcpo
