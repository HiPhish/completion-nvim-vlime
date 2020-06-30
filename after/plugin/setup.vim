" Automatic registration of the Vlime source.

if has_key(g:, 'completion_vlime_did_load')
	finish
endif
let g:completion_vlime_did_load = v:true

lua require'completion'.addCompletionSource("vlime", require'completion.source.vlime'.source)
