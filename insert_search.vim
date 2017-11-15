

function! RemoveBoundaryModifier( s )
	let s1 = substitute( a:s, '\\<' , '' , '')
	let s1 = substitute( s1, '\\>' , '' , '')
	 
	" remove \V
	if  strpart( s1, 0, 2 )  == '\V' 
		let s1 = strpart( s1, 2 ) 
	endif 

	return s1
endfunction
 
""""""""""""""""""""""
"  get search word  
""""""""""""""""""""""
   inoremap <C-r>e <C-R>=RemoveBoundaryModifier(@/)<CR>
   cnoremap <C-r>e <C-R>=RemoveBoundaryModifier(@/)<CR>
   inoremap <C-r><c-e> <C-R>=RemoveBoundaryModifier(@/)<CR>
   cnoremap <C-r><c-e> <C-R>=RemoveBoundaryModifier(@/)<CR>

