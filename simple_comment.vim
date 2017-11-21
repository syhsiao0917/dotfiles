
au Filetype autohotkey  let b:comment_string = ';'
au Filetype c           let b:comment_string = '\/\/'
au Filetype csh         let b:comment_string = '#'
au Filetype make        let b:comment_string = '#'
au Filetype my          let b:comment_string = '\/\/'
au Filetype perl        let b:comment_string = '#'
au Filetype python      let b:comment_string = '#'
au Filetype sh          let b:comment_string = '#'
au Filetype tcl         let b:comment_string = '#'
au Filetype verilog     let b:comment_string = '\/\/'
au Filetype vhdl        let b:comment_string = '--'
au Filetype vim         let b:comment_string = '"'
au Filetype yaml        let b:comment_string = '#'


function! MyComment()
  silent exec 's/^/' . b:comment_string . ' /e'
endfunction

function! MyUnComment()
  silent exec 's/^' . b:comment_string . ' //e'
endfunction

nnoremap <c-r> :call MyComment()<CR>
xnoremap <c-r> :call MyComment()<CR>
nnoremap <c-d> :call MyUnComment()<CR>
xnoremap <c-d> :call MyUnComment()<CR>
