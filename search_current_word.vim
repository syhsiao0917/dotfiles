
 "" search operation """""""""""""""""""""""''
   nnoremap ser :%s/<C-R>///g<left><left>
 
   " delete
   nnoremap sed :%s///g<CR>:normal ''<CR>

 "MY function: Search current word ( to replace # * )
	 function! SearchCurrentWord()
			" get <cword>
				let @/="\\<".expand("<cword>")."\\>"
				call histadd("/", @/ )

				highlight Search guibg=red guifg=white

	 endfunction

 nnoremap <C-e> :call SearchCurrentWord()<CR>:set hlsearch<CR>

  function! SearchSelect()
    let temp = @a
    norm! gv"ay
    let @/ = '\V' . substitute(escape(@a, '\'), '\n', '\\n', 'g')
    call histadd("/", @/ )
    let @a = temp
  endfunction
  xnoremap <C-e> :call SearchSelect()<CR>


   " replace to <cword>
     function! ReplaceToCword()
       let save_cursor = getpos(".")
       
       let cword = expand("<cword>" )
       exec "%s//" . cword .  "/g"
 
                         call setpos('.', save_cursor)
 
       call SearchCurrentWord()
       highlight Search guibg=darkgreen guifg=white
 
     endfunction
 
   nnoremap sew :call ReplaceToCword()<CR>
