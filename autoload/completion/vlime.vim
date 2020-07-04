" Vlime completion has to be split into a Lua part and a Vim script part. Vlime
" uses Vim script functions for callback, and it is currently impossible to
" share function objecte from either language with the other one.

" Called from the Lua side when completion has been triggered. This function is
" responsible for issuing the completion request to Vlime and setting up the
" callback.
function! completion#vlime#on_trigger(base)
	silent let l:connection = vlime#connection#Get(v:true)
	if type(l:connection) == type(v:null)
		return
	endif

	" Both functions are asynchronous, they do not return any value. Instead
	" we supply a callback function as the second argument, the callback takes
	" to arguments: the connection that as used and the actual result.
	if s:use_fuzzy(l:connection)
		call l:connection.FuzzyCompletions(a:base, {c,r->s:complete_fuzzy(r)})
	else
		call l:connection.SimpleCompletions(a:base, {c,r->s:complete_simple(r)})
	endif
endfunction


" ---[ Completion functions ]--------------------------------------------------
" These are the callbacks which will be called after Vlime has finished getting
" the completion items. They are responsible for actually submitting the items
" to completion-nvim.

function! s:complete_simple(result)
	let [l:items, l:base] = a:result
	call luaeval('require"completion.source.vlime"._onSimpleComplete(_A)', l:items)
endfunction

function! s:complete_fuzzy(result)
	" The result is a pair, the first element is a list of tuples.
	let l:items = a:result[0]
	call luaeval('require"completion.source.vlime"._onFuzzyComplete(_A)', l:items)
endfunction


" ---[ Helper functions ]------------------------------------------------------

" Determine whether to use fuzzy or simple completion. If nothing is specified
" take an educated guess.
function! s:use_fuzzy(connection)
	for l:scope in [b:, t:, g:]
		if has_key(l:scope, 'completion_vlime_fuzzy')
			return l:scope['completion_vlime_fuzzy']
		endif
	endfor

	if has_key(g:, 'vlime_contribs')
		return index(g:klime_contribs, 'SWANK-FUZZY') >= 0
	endif

	" This code is taken from Vlime itself and uses undocumented features, it
	" might break in the future.
	let l:contribs = get(a:connection.cb_data, 'contribs', [])
	return index(l:contribs, 'SWANK-FUZZY') >= 0
endfunction


" vim: tw=79 ts=4 noet
