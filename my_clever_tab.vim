

function! CleverTab()
   let column = col('.')
 
   if  column==1
     return "    "
   elseif getline('.')[column-2] =~ '\S'
      return "\<C-P>"
   else
     return "    "
   endif
 
endfunction
 
inoremap <Tab> <C-R>=CleverTab()<CR>
