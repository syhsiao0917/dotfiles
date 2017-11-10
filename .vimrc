winp 27 1 
set lines=170
set columns=100

inoremap <c-t> <C-R>=strftime("%H:%M")<CR><Space>
inoremap <c-r><c-t> <C-R>=strftime("%H:%M")<CR><Space>
inoremap <c-r><c-d> <C-R>=strftime("%Y%m%d")<CR><Space>

set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

nnoremap <a-e> :e .<CR>

" nnoremap <a-d> :edit ~/prj<CR>

"" No open fold when search hit 
set foldopen-=search
 
set paste

set backspace=2
set backspace=indent,eol,start

" keep command or search history
set history=400

set nocompatible
 
" GUI option 
 
set guioptions-=m
 " always show the status line
 set laststatus=2 
 
nnoremap <c-g> :silent let @*=expand("%:p")<CR>:silent let @"=expand("%:p")<CR>:echo expand("%:p")<CR>:silent let @f=expand("%:p") . ":" . line('.')<CR>

 
" for unified operation
nnoremap <c-v> P

" quick fix 
"    toggle quickfix window
 nnoremap sqf :QFix<CR>
 nnoremap <a-n> :cnext<CR>
 nnoremap <a-p> :cprev<CR>
 

" MAKE for compiler.log
"  au BufNew,BufRead *compiler.log nnoremap <buffer> <F5> :lcd %:p:h<CR>:set makeprg=vd_filter.py\ %<CR>:set errorformat=%f@@%l@@%m<CR>:make<CR>
 au BufNew,BufRead *.bat set ft=csh
 
 " MY Global 
 nnoremap <leader>gy :call setreg('a', '' )<CR>:g/<C-R>//y A<CR>:let @"=@A<CR>``
 nnoremap <leader>gd :call setreg('a', '' )<CR>:g/<C-R>//d A<CR>:let @"=@A<CR>``
 nnoremap <leader>go :v//d<CR>
 
 nnoremap <leader>gk :g/<C-R>//t'k<CR>
 nnoremap <leader>g. :g/<C-R>//normal .
 nnoremap <leader>gn :g/<C-R>//normal 
 
 nnoremap <leader>pk :set foldcolumn=1<CR>:set foldmethod=expr<CR>:set foldexpr=getline(v:lnum)[1]=='='?'>1':'='<CR>

 nnoremap ssfm :set foldmethod=marker<CR>
 nnoremap ssfs :set foldmethod=syntax<CR>
 
xnoremap v iw

" play macro on select mode
xnoremap qq :norm @q<CR> 
xnoremap . :norm .<CR> 
 
"[edit] type highlight word 
 function! RemoveBoundaryModifier( s )
	 let s1 = substitute( a:s, '\\<' , '' , '')
	 let s1 = substitute( s1, '\\>' , '' , '')
	 
	 " remove \V
	 if  strpart( s1, 0, 2 )  == '\V' 
		 let s1 = strpart( s1, 2 ) 
	 endif 

	 return s1
 endfunction
 
   inoremap <C-r>e <C-R>=RemoveBoundaryModifier(@/)<CR>
   cnoremap <C-r>e <C-R>=RemoveBoundaryModifier(@/)<CR>
 
   inoremap <C-r><c-e> <C-R>=RemoveBoundaryModifier(@/)<CR>
   cnoremap <C-r><c-e> <C-R>=RemoveBoundaryModifier(@/)<CR>
 
"[edit] Tab complete
function! CleverTab()
   let column = col('.')
 
   if column==1
     return "\<Tab>"
   elseif getline('.')[column-2] =~ '\S'
      return "\<C-P>"
   else
     return "\<Tab>"
   endif
 
endfunction
 
inoremap <Tab> <C-R>=CleverTab()<CR>
 
 " clear select mode mapping for xpt
 smapclear 
 
 
 " Use Enter and Space to select 
 
 " ab ;env #!/usr/bin/env
 " ab ;csh #!/bin/csh
 " ab ;py #!/usr/bin/python
 
 " mouse in select mode
 snoremap <C-v> <C-g>p
 snoremap <C-c> <C-g>y
 
 
"" <cmd> replace @/ """""""""""""""""""""""''
   nnoremap ser :%s/<C-R>///g<left><left>

"" <normal> Search cword ( to replace # * )
	function! SearchCurrentWord()
	" get <cword>
		let @/="\\<".expand("<cword>")."\\>"
		call histadd("/", @/ )

		highlight Search guibg=red guifg=white

	endfunction

	nnoremap <c-e> :call SearchCurrentWord()<CR>:set hlsearch<CR>
 
  function! SearchSelect()
      let temp = @a
      norm! gv"ay
	  " search 
      let @/ = '\V' . substitute(escape(@a, '\'), '\n', '\\n', 'g')
      call histadd("/", @/ )
      let @a = temp
  endfunction
  xnoremap <C-e> :call SearchSelect()<CR>

"" <normal> replace cword 

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


   nnoremap seg :noautocmd vimgrep /<c-r>//g *
 
 "" 
 
"  cnoremap <c-w> <c-f>
 
 nnoremap <c-u> :redo<CR>

 
 " black hole register
 nnoremap - "_

 inoremap <c-r>d <C-R>=strftime("%Y%m%d")<CR>
 inoremap <c-r>t <C-R>=strftime("%H:%M")<CR>
 colorscheme koehler

 abbr /i /* */<ESC>hhi
 
 colorscheme koehler
 
 set nocompatible
 syntax on
 filetype plugin indent on
 
 set noswapfile " better speed, but a little danger  
 set nobackup " no backup 
 set autoread   " auto reload a file 
 set autochdir  
 
 set guioptions-=T " remove toolbar
 set guioptions+=a " autoselect ???
 set guioptions+=R " right hand scroller 
 
 
 set showcmd             " display incomplete commands
 set incsearch           " do incremental searching
 set mouse=a             " use mouse in xterm to scroll
 set scrolloff=0         " 5 lines bevore and after the current line when scrolling
 set noignorecase        " ignore case
 set smartcase                   " but don't ignore it, when search string contains uppercase letters
 
" Buffer """""""""""""""""""""""
 set hidden                     " allow switching buffers, which have unssved changes
 set autowrite " autosave when buffer switch
 
 set showmatch                   " showmatch: Show the matching bracket for the last ')'?
 
 set winminheight=0  " AysplitiH§1tS|3aA?!
 set noequalalways  " Ao±?split?·|§a3N?Uaoequal
 
 set hlsearch

 set splitbelow
 set splitright
 set winaltkeys=no " ?IaltO±±imenu
 
 "" edit basic setting 
 set virtualedit=all
 set nowrap
 
 set tabstop=4      "stay the same with 8
 set softtabstop=4
 set shiftwidth=4
 set expandtab
 
 set path+=./** " search down
 
 set smarttab 
 
 " enhanced tab mode 
 set wildchar=<Tab> wildmenu wildmode=full
 set wildcharm=<Tab>
  
 "When edit tags, tab can't be replaced by space  
 autocmd BufRead tags set noexpandtab 

 "always jump to (line,col) be careful of space behind `
 nnoremap ' `
 xnoremap ' `
 
   hi FstMark guifg=white guibg=purple
   hi SecMark guifg=white guibg=darkcyan
 
   match SecMark /\%'j/
   function! SetSeqMark()
 
       if line("'k")!=0 && ( getpos(".") != getpos("'k") )
 
           "set h to j
           if line("'j")!=0 && line(".") != line("'j")
               call setpos( "'h", [0,line("'j"),col("'j"),"off"] )
           endif
 
           "set j to k
           call setpos( "'j", [0,line("'k"),col("'k"),"off"] )
 
       endif
 
       normal mk
       "set current position to mk
 "       exec 'match Todo /\%' . col("'k") . 'v\%' . line("'k") . 'l/'
       match FstMark /\%'k/
       2match SecMark /\%'j/
 
   endfunction 
 
 inoremap <C-s> <ESC>
 nnoremap <C-s> <ESC>:silent call SetSeqMark()<CR>:silent update<CR><ESC>
 xnoremap <C-s> <ESC>:silent call SetSeqMark()<CR>:silent update<CR><ESC>
 
 "" self map key 
 
 nnoremap <SPACE> <PageDown>
 nnoremap <S-SPACE> <PageUp>
 nnoremap <c-k> 5gk
 nnoremap <c-j> 5gj
 nnoremap <c-h> 15h
 nnoremap <c-l> 15l
 xnoremap <c-k> 5gk
 xnoremap <c-j> 5gj
 xnoremap <c-h> 15h
 xnoremap <c-l> 15l
 
 cnoremap <c-k> <Up>
 cnoremap <c-j> <Down>
 
 let mapleader = "s"
 nnoremap s <ESC>
 
 """"" command line abbr
 "" current file 
   cabbr  %% <C-R>=expand("%:p:h")<CR>
 
 
"" <normal> change to current path
nnoremap <leader>cd :lcd %:p:h<CR>

"" TODO ?? 
 xnoremap / <ESC>/\%V
 xnoremap ? <ESC>/\%V<C-R>/
 
 
"setting Complete 
 set complete=.,w
"  set completeopt=menu,preview,longest
 set completeopt=menu,preview
 
 set sessionoptions="blank,size,sesdir,slash,tabpages,unix,winpos,winsize"
 
"" Setting fold 
 
 set foldcolumn=0

 "show fold
 nnoremap ssfd :set foldcolumn=1<CR>
 nnoremap snfd :set foldcolumn=0<CR>
 
 hi FoldColumn guifg=lightgreen guibg=grey30
 
 function! FoldText()
   let line = getline(v:foldstart)
   let num = v:foldend - v:foldstart
   return line . "  +" . num 
 endfunction
 
 set foldtext=FoldText()
 
 hi Folded guibg=grey20 guifg=lightgreen
 
 set foldlevel=3

   function! StripTrailingWhiteSpaces()
     let search = @/
     " 'e' means not showing error when none of pattern are found
     s/\s\+$//e  
     let @/=search
   endfunction
 
 nnoremap <leader>d<space> :call StripTrailingWhiteSpaces()<CR>
 xnoremap <leader>d<space> :call StripTrailingWhiteSpaces()<CR>
 
   function! DelEmptyLine()
     let search = @/
     " 'e' means not showing error when none of pattern are found
     " remove multiline 
     s/^[\ \t]*\n//ge
     let @/ = search 
   endfunction

 nnoremap <leader>dn :call DelEmptyLine()<CR>
 xnoremap <leader>dn :call DelEmptyLine()<CR>
 
 " change to light background and TOHTML
 nnoremap <leader>web :set bg=light<CR>:hi Normal guibg=white guifg=black<CR>:TOhtml<CR>
 
 
 set foldexpr=(getline(v:lnum)=~'^$')?-1:((indent(v:lnum)<indent(v:lnum+1))?('>'.indent(v:lnum+1)):indent(v:lnum)) 
 
 " for portable vim  
 " nnoremap <c-F1> :e $VIMRUNTIME\..\..\DefaultData\settings\vimrc<CR>
 
 set smartindent
 
 "" TabPage """""""""""""""""""""""""""""""
     nnoremap <A-h> :tabp<CR>
     nnoremap <A-l> :tabn<CR>
     nnoremap <A-S-h> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
     nnoremap <A-S-l> :execute 'silent! tabmove ' . tabpagenr()<CR>
     " move current tabpage to head
     nnoremap <A-)> :tabm 0<CR>xnoremap   
 
hi Visual term=None cterm=None gui=None guibg=grey30

au filetype autohotkey  let b:comment_string = ';'
au filetype perl    let b:comment_string = '#'
au filetype python  let b:comment_string = '#'
au filetype yaml    let b:comment_string = '#'
au filetype vhdl    let b:comment_string = '--'
au filetype sh      let b:comment_string = '#'
au filetype csh     let b:comment_string = '#'
au filetype make    let b:comment_string = '#'
au filetype tcl     let b:comment_string = '#'
au filetype c       let b:comment_string = '\/\/'
au filetype vim     let b:comment_string = '"'
au filetype my      let b:comment_string = '//'

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




" map <F5> :checktime<CR>

"  use control v  as paste clipboard
cnoremap <c-v> <c-r>*

 
"" gvim line operating 
nnoremap seey :call setreg('a', '' )<CR>:g/<C-R>//y A<CR>:let @"=@A<CR>``
nnoremap seed :call setreg('a', '' )<CR>:g/<C-R>//d A<CR>:let @"=@A<CR>``

" nnoremap <leader>gk :g/<C-R>//t'k<CR>
" nnoremap <leader>g. :g/<C-R>//normal .
" nnoremap <leader>gn :g/<C-R>//normal 

"!!! Select and execute Important
xnoremap qq :norm @q<CR> 
xnoremap . :norm .<CR>                        

" or 

" nnoremap <c-s-f> :w<CR>

"no name buffer 
nnoremap <c-w>t :let tmp_ft=&ft<CR>:new<CR>:setlocal buftype=nofile bufhidden=wipe nobuflisted<CR>:exec 'set ft=' . tmp_ft<CR>

" function! RelativePath()
" 
"   let origin_path =  expand('<cfile>' )
"   let relative_path = system( 'vr ' . origin_path ) 
" 
"   let @x = substitute( relative_path , '\n' , '' , "" )
" 
"   exec 'normal diW"xpa ' 
" 
" " python << EOF
" " import vim; 
" " import os ;
" " 
" " #  vim.eval('expand("%")' )
" " 
" " print os.path.relpath( vim.eval('<cfile>' ) )
" " 
" " EOF
" endfunction
" nnoremap srf :call RelativePath()<CR>


function! OpenFilePath()

  "" xx/xx/file:111  open file  
                  "" Just turn ":" to "+"
"   let cmd = join( [ ':sp' ] + [ join( split( expand('<cfile>') , ':' ) , ' +' ) ] , " " )  
    let cfile_a = split(expand('<cfile>'), ',' )

    let a = []

    for i in cfile_a
      let a += split( i ) 
    endfor
       

    if len(cfile_a) == 1  
      let cmd = ':pedit ' . cfile_a[0] 
    else
      let cmd = ':pedit ' . '+' . cfile_a[1] . ' ' . cfile_a[0]
    endif

  exec  cmd 

endfunction

" function! OpenFilePath()
" 
"     set isfname+=)(
" 
"     let cfile_a = split(tr(expand('<cfile>'), '()', '  ' ) )
" 
"     if len(cfile_a) == 1  
"       let cmd = ':sp ' . cfile_a[0] 
"     else
"       let cmd = ':sp ' . '+' . cfile_a[1] . ' ' . cfile_a[0]
"     endif
" 
"   exec  cmd 
"     set isfname-=)(
" 
" endfunction

" nnoremap sgf :call OpenFilePath()<CR>
nnoremap <c-f> :call OpenFilePath()<CR>:normal j<CR>




command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)
function! s:RunShellCommand(cmdline)
  botright new
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
  call setline(1, 'You entered:  ' . a:cmdline)
  silent execute '$read !'. a:cmdline
  1
endfunction

ca sh Shell
 

command! -complete=shellcmd -nargs=+ F call s:RunShellFind(<q-args>)
function! s:RunShellFind(find_args)

  let cur_dir = expand("%")
  execute 'botright new '. '[find_buffer]' . cur_dir
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
  silent execute '0r !find ' . cur_dir . ' -name "'. a:find_args .'"'
"   call setline(1, 'find in ' . cur_dir . ' -name "'. a:find_args .'"' )
  1
endfunction


set showcmd
set autoread

set list listchars=tab:>-,trail:_
hi SpecialKey guifg=#333333 

inoremap <c-v> <C-R>*
" nnoremap <c-v> i<C-R>*<ESC>
nnoremap <c-v> "*gp
 


" remote = in filename 
set isfname-==
set isfname+=:

" " Source the vimrc file after saving it
" if has("autocmd")
"   autocmd bufwritepost .vimrc source $MYVIMRC
" endif

" nnoremap <c-F5> source $MYVIMRC


nnoremap s== :Tabularize /=<CR>
xnoremap s== :Tabularize /=<CR>
nnoremap s=: :Tabularize /:\zs<CR>
xnoremap s=: :Tabularize /:\zs<CR>

nnoremap se= :Tabularize /<c-r>/<CR>



inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a
 
function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction

"------------------------------
"Fold 
" Fold start 
nnoremap [[ [zzz
" Fold end 
nnoremap ]] ]zzz

"prev fold start 
nnoremap zk zk[z

nnoremap ) zjzz
nnoremap ( zk[zzz


set tags=./tags;
set tags+=/home/syshiao/uvm_tags

nmap <F8> :TlistToggle<CR>

" let Tlist_Ctags_Cmd = 'ctags'
" let Tlist_Show_One_File = 1            "tag
" let Tlist_Exit_OnlyWindow = 1          "taglistvim
" let Tlist_Use_Right_Window = 1         "taglist


 nnoremap <leader>rls :r !\ls 

augroup CursorLine
     au!
     au VimEnter,WinEnter,BufWinEnter * setlocal nocursorline
     au WinLeave * setlocal cursorline
augroup END


" function! SplitComma()
"   
"   s/,/,\r/g
" 
" endfunction
" 
" nnoremap sp,  :call SplitComma()<CR>
" xnoremap sp,  :call SplitComma()<CR>

" nnoremap srr :checktime<CR>

" map <a-k> :bn<CR>
" map <a-j> :bp<CR>
" 
" map <a-s-k> :sbn<CR>
" map <a-s-j> :sbp<CR>

"" 
" nnoremap <silent> svl :BufExplorerVerticalSplit<CR>  
nnoremap <silent> <a-f> :noautocmd BufExplorer<CR>
" nnoremap <silent> svb :BufExplorerHorizontalSplit<CR>

nnoremap <silent> sp :let @a=expand("%:p:h")<CR>:sp <C-R>a/


" let q; open command window
nnoremap <c-w>; q:
nnoremap <c-w>/ q/

"" Global bookmarker """""""""""
nnoremap M m

"" Execute shell command and store the output to scratch buffer
command! -nargs=* -complete=shellcmd R new | setlocal buftype=nofile bufhidden=hide noswapfile | r !no_color <args>

cabbr %% <C-R>=expand('%:p:h')<CR>


" nnoremap <a-e> :e.<CR>
" nnoremap <a-d> :e  C:\Users\SY.Hsiao\Documents\vim_my\prj.my<CR>


"----------------------------------------------
" function! MyAddBufHis()
" 
"   """ init variable """"""""""""""""
"   let w:post_buf_history = []
" 
"   if ! exists( "w:prev_buf_history" ) 
"     let w:prev_buf_history = [] 
"   endif 
" 
"   "" store to history and assign new  """""""""""""
"   if exists( "w:curr_buf" )
"     let w:prev_buf_history += [ w:curr_buf ]
"   endif
" 
"     let w:curr_buf = bufnr("%")
" 
" "   echo w:prev_buf_history w:curr_buf
" 
" endfunction
" 
" 
" function! MyGotoPrevBuf()
" 
"   if exists( "w:prev_buf_history" )
" 
"     if empty( w:prev_buf_history )
"       echo "NO previous buffer" 
"     else
"       " get prev buff 
"       let prev_buf = w:prev_buf_history[-1]
"       call remove( w:prev_buf_history, -1 )
" 
"       " store curr buf 
"       let w:post_buf_history = [ w:curr_buf ] + w:post_buf_history
" 
"       " go to prev buf 
"       let exe_line = ":noautocmd b " . string(prev_buf)
"       exe exe_line 
" 
"       let w:curr_buf = bufnr('%')
"     endif
" 
" "   echo w:prev_buf_history w:curr_buf w:post_buf_history
" 
"   else
"     echo "No previous buffer" 
"   endif
" 
" endfunction
" 
" function! MyGotoNextBuf()
" 
"   if exists( "w:post_buf_history" )
" 
"     if empty( w:post_buf_history )
"       echo "NO next buffer" 
"     else
" 
"       " get next buf 
"       let next_buf = w:post_buf_history[0]
"       call remove( w:post_buf_history, 0 )
" 
"       " store curr buf 
"       let w:prev_buf_history += [ w:curr_buf ]
" 
"       " go to next buf 
"       let exe_line = ":noautocmd b " . string(next_buf)
"       exe exe_line 
" 
"       let w:curr_buf = bufnr('%')
" 
"     endif
" 
" "   echo w:prev_buf_history w:curr_buf
" 
"   else
"     echo "No previous buffer" 
"   endif
" 
" endfunction
" 
" function! Clean()
"     let  w:prev_buf_history  = []
"     let  w:curr_buf  = bufnr('%')
"     let  w:post_buf_history = []
"     echo w:prev_buf_history w:curr_buf w:post_buf_history
" endfunction
" 
" au BufEnter * call MyAddBufHis()
" 
" nnoremap <a-left>  :call MyGotoPrevBuf()<CR>
" nnoremap <a-right> :call MyGotoNextBuf()<CR>
" nnoremap scc :call Clean()<CR>
" 
" function! MyAddBufHis()
" 
" "   if bufname('%') == "[BufExplorer]"
" "     echo "This is BufExplore"
" "     return 
" "   endif
" 
" "   echo "Start exe "
" 
"   "-- skip FileExplore
"   if filereadable( bufname('%') )
" 
"     """ init variable """"""""""""""""
"     let w:post_buf_history = []
" 
"     if ! exists( "w:prev_buf_history" ) 
"       let w:prev_buf_history = [] 
"     endif 
" 
"     "" store to history and assign new  """""""""""""
"     if exists( "w:curr_buf" )
"       let w:prev_buf_history += [ w:curr_buf ]
"     endif
" 
"       let w:curr_buf = bufnr("%")
" 
"   endif
" 
" "   echo w:prev_buf_history w:curr_buf
" 
" endfunction
" 
" 
" function! MyGotoPrevBuf()
" 
"   if exists( "w:prev_buf_history" )
" 
"     if empty( w:prev_buf_history )
"       echo "NO previous buffer" 
"     else
"       " get prev buff 
"       let prev_buf = w:prev_buf_history[-1]
"       call remove( w:prev_buf_history, -1 )
" 
"       " store curr buf 
"       let w:post_buf_history = [ w:curr_buf ] + w:post_buf_history
" 
"       " go to prev buf 
"       let exe_line = ":noautocmd b " . string(prev_buf)
"       exe exe_line 
" 
"       let w:curr_buf = bufnr('%')
"     endif
" 
" "   echo w:prev_buf_history w:curr_buf w:post_buf_history
" 
"   else
"     echo "No previous buffer" 
"   endif
" 
" endfunction
" 
" function! MyGotoNextBuf()
" 
"   if exists( "w:post_buf_history" )
" 
"     if empty( w:post_buf_history )
"       echo "NO next buffer" 
"     else
" 
"       " get next buf 
"       let next_buf = w:post_buf_history[0]
"       call remove( w:post_buf_history, 0 )
" 
"       " store curr buf 
"       let w:prev_buf_history += [ w:curr_buf ]
" 
"       " go to next buf 
"       let exe_line = ":noautocmd b " . string(next_buf)
"       exe exe_line 
" 
"       let w:curr_buf = bufnr('%')
" 
"     endif
" 
" "   echo w:prev_buf_history w:curr_buf
" 
"   else
"     echo "No previous buffer" 
"   endif
" 
" endfunction
" 
" function! Clean()
"     let  w:prev_buf_history  = []
"     let  w:curr_buf  = bufnr('%')
"     let  w:post_buf_history = []
"     echo w:prev_buf_history w:curr_buf w:post_buf_history
" endfunction
" 
" au BufEnter * call MyAddBufHis()
" nnoremap <F11> :call MyGotoPrevBuf()<CR>
" nnoremap <F5> :so /home/syshiao/buf_his.vim<CR>
" nnoremap <F1> :echo w:prev_buf_history w:curr_buf w:post_buf_history<CR>


" nnoremap <a-left>  :BufSurfBack<CR>
" nnoremap <a-right> :BufSurfForward<CR>

" function! DecAndHex(number)
"   let ns = '[.,;:''"<>()^_lL]'      " number separators
"   if a:number =~? '^' . ns. '*[-+]\?\d\+' . ns . '*$'
"      let dec = substitute(a:number, '[^0-9+-]*\([+-]\?\d\+\).*','\1','')
"      echo dec . printf('  ->  0x%X, -(0x%X)', dec, -dec)
"   elseif a:number =~? '^' . ns. '*\%\(h''\|0x\|h\|#\)\?\(\x\+\)' . ns . '*$'
"      let hex = substitute(a:number, '.\{-}\%\(h''\|0x\|#\)\?\(\x\+\).*','\1','')
"      echon '0x' . hex . printf('  ->  %d', eval('0x'.hex))
"      if strpart(hex, 0,1) =~? '[89a-f]' && strlen(hex) =~? '2\|4\|6'
"         " for 8/16/24 bits numbers print the equivalent negative number
"         echon ' ('. float2nr(eval('0x'. hex) - pow(2,4*strlen(hex))) . ')'
"      endif
"      echo
"   else
"      echo "NaN"
"   endif
" endfunction
" nnoremap gn :call DecAndHex(expand("<cword>"))<CR>
" 
" nnoremap sr./ :s/\./\//g<CR>
" nnoremap sr/. :s/\//\./g<CR>
" 
nnoremap sp; :s/;/;\r/g<CR>

" "" append what you copy 
" nnoremap yu  :call setreg( 'z', @" , "a" )<CR>:call setreg('"', @z)<CR>
" 
" "" New store what you copy 
" nnoremap gy :call setreg( 'z', @"   )<CR>:call setreg('"', @z)<CR>


" "" For tagbar '"""""""""""""""""""""""""
" let g:tagbar_type_systemverilog = {
"     \ 'ctagstype': 'systemverilog',
"     \ 'kinds': [
"         \'c:class',
"         \'m:module',
"         \'p:program',
"         \'f:function',
"         \'i:interface',
"         \'e:typedef',
"         \'t:task'
"       \],
"             \ 'sro'        : '.',
"             \ 'kind2scope' : {
"                 \ 'c' : 'class',
"                 \ 'f' : 'function',
"                 \ 't' : 'task'
"             \ },
"             \ 'scope2kind' : {
"                 \ 'enum'      : 'g',
"                 \ 'namespace' : 'n',
"                 \ 'class'     : 'c',
"                 \ 'struct'    : 's',
"                 \ 'union'     : 'u'
"             \ }
"     \}
" 
" 
" nnoremap stt :TagbarToggle<CR>

" nnoremap sta :let &tags+=substitute(expand("%:p:h"), "\(^\/path\/to\/.*/\).*$", "\1", "")<CR>

" " For easy motion
" nnoremap gb ssb
" nnoremap gw ssw
" nnoremap gf ssf
" nnoremap gF ssF
"

" noremap <a-j> J

" function! NumberToggle()
"   if(&relativenumber == 1)
"     set number
"   else
"     set relativenumber
"   endif
" endfunc
" 
" nnoremap ssnu :call NumberToggle()<cr>

" set relativenumber
" :au FocusLost * :set number
" :au FocusGained * :set relativenumber
" autocmd InsertEnter * :set number
" autocmd InsertLeave * :set relativenumber


"""""""

" "" UVM dictionary
" set dictionary=/home/syshiao/MY/vim/uvm_dict.vim
" set dictionary+=/home/syshiao/MY/vim/uvm_macro_dict.vim
" set complete+=k
" inoremap <c-t> <c-x><c-]>


"" highlight popup menu
highlight Pmenu guibg=brown gui=bold


"From http://bootleq.blogspot.jp/search/label/Vim?updated-max=2010-07-04T08:30:00%2B08:00&max-results=10&start=40&by-date=false

function LastTab(act)

    let lt = g:lasttab
    let tabClosed = tabpagenr('$') < lt.knownLength ? 1 : 0

    if a:act ==# 'TabLeave'
        if ! tabClosed
            let lt.prevLeave = lt.leave
        elseif lt.prevLeave > tabpagenr()
            let lt.prevLeave -= 1
        endif
        let lt.leave = tabpagenr()
    elseif a:act ==# 'switch'
        if tabClosed
            let lastTab = lt.prevLeave > tabpagenr() ? lt.prevLeave -1  : lt.prevLeave
        else
            let lastTab = lt.leave
        endif
        if lastTab == tabpagenr()
            echo 'Already on last tab.'
        else
            exe "tabn " . lastTab
        endif
    endif

    let lt.knownLength = tabpagenr('$')

endfunction

if ! exists('g:lasttab')
    let g:lasttab = {'leave':1, 'prevLeave':1, 'knownLength':1}
endif

au TabLeave * :call LastTab('TabLeave')
au TabEnter * :call LastTab('TabEnter')
nnoremap <c-Tab> :call LastTab('switch')<CR>
inoremap <c-Tab> <C-\><C-N>:call LastTab('switch')<CR>

" "" plugin yankstack
" 
"   let g:yankstack_map_keys = 0
"   nmap <c-p> <Plug>yankstack_substitute_older_paste
"   nmap <c-n> <Plug>yankstack_substitute_newer_paste
" 

"" select the text just paste
nnoremap <expr> gp '`[' . getregtype()[0] . '`]'

let g:vimwiki_list = [{
    \ 'path': '~/wikidata/',
    \ 'path_html': '~/wikidata/',
    \ 'ext': '.my',
    \ 'nested_syntaxes': {
        \ 'c': 'c',
        \ 'cpp': 'cpp',
        \ 'java': 'java',
        \ 'python': 'python',
        \ 'systemverilog': 'systemverilog',
    \ },
\ }]


"" set fold method to syntax or manual 
nnoremap ssfds :set foldmethod=syntax<CR>
nnoremap ssfdm :set foldmethod=manual<CR>

""search class
nnoremap [[ :call search( "^\\s*class\\s\\+\\w\\+" , "b")<CR>
nnoremap ]] :call search( "^\\s*class\\s\\+\\w\\+" , "")<CR>


"" search tag super class 
nnoremap -- :call search( "^\\s*class\\s\\+\\w\\+" , "b")<CR>:call search("extends")<CR>:normal W<CR><c-]> 


" ctrl-p plugin
let g:ctrlp_map = '<c-a>'
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/tsmc*/*,*/VerdiLog/*


nnoremap <c-b> :CtrlPBuffer<CR>
nnoremap <c-t> :CtrlPTag<CR>

let g:ctrlp_by_filename=1
let g:ctrlp_working_path_mode = 'c'

let g:ctrlp_follow_symlinks = 1

" let g:ctrlp_extensions = ['tag']

" let g:BufSurfIgnore="prj,[BufExplorer]"
"
" ab #py #!/usr/bin/env python


"" Fugative plugin    
" auto clean fugative buffers
autocmd BufReadPost fugitive://* set bufhidden=delete

" add git branch to status line 
" set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P


"diffoption 
set diffopt=filler,foldcolumn:0,context:2

hi! DiffAdd      guibg=#003300
hi! DiffChange   guibg=#003300
hi! DiffDelete   guifg=#330000 guibg=#330000
hi! DiffText     guibg=#990000

"" popup menu 
inoremap <expr> <Esc>      pumvisible() ? "\<C-e>" : "\<Esc>"
inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"

set nornu
set nu

