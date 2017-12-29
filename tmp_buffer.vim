
"no name buffer 
nnoremap <c-w>t :let tmp_ft=&ft<CR>:new<CR>:setlocal buftype=nofile bufhidden=wipe nobuflisted<CR>:exec 'set ft=' . tmp_ft<CR>
