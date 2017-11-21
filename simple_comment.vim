
au filetype autohotkey  let b:comment_string = ';'
au filetype c           let b:comment_string = '\/\/'
au filetype csh         let b:comment_string = '#'
au filetype make        let b:comment_string = '#'
au filetype my          let b:comment_string = '//'
au filetype perl        let b:comment_string = '#'
au filetype python      let b:comment_string = '#'
au filetype sh          let b:comment_string = '#'
au filetype tcl         let b:comment_string = '#'
au filetype verilog     let b:comment_string = '//'
au filetype vhdl        let b:comment_string = '--'
au filetype vim         let b:comment_string = '"'
au filetype yaml        let b:comment_string = '#'


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
