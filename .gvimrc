"source /usr/share/vim/vimrc_jungo.vim

set guifont=Monospace\ 13

"in order to assure f status
set cpoptions=aABceFs
colorscheme elflord
set lines=45 columns=80

" replace tabs with space
set et
"window size always equal for multiple windows
set ea

set nobackup

"make backspace work
set bs=2

set guioptions-=T

set tw=0

set ic 
"cscope abbrevation
"set scs
set ruler
"incremental serach
set is
"set vb
"set sm 
"set ts=4
set smartindent

set shiftwidth=4
"scroll off
set so=5

set smarttab

inoremap <S-Tab> <C-V><Tab>
"enable syntax for c
syntax enable
" enable background highlighting
set hlsearch
" hide the mouse when typing text
set mousehide
" ignore in autocomplete
set wildignore=*.o,*.dep,*.ko,*.bak,*.swp
" enable auto-wrapping of text (not only comments)
set formatoptions+=t

" use GNU c syntax highlights
let c_gnu=1

source ~/cscope_maps.vim
"highlight wasted spaces
let c_space_errors=1
"highlight long lines
au FileType text setlocal textwidth=80
"paste using mouse
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

au BufNewFile,BufRead *.c.*.tmp setf c
au BufNewFile,BufRead *.h.*.tmp setf c
au BufNewFile,BufRead *.mak.*.tmp setf make
au BufNewFile,BufRead Makefile.*.tmp setf make

set guicursor=n-v-c:block-Cursor/lCursor-blinkwait528-blinkoff0-blinkon1144,ve:ver35-Cursor,o:hor50-Cursor,i-ci:ver25-Cursor/lCursor-blinkwait528-blinkoff0-blinkon1144,r-cr:hor20-Cursor/lCursor,sm:block-Cursor

" Remove "# needreview" instances (with confirmation) 
:nmap <F2> :%s/needreview//gc<CR>

if &diff 
  set winwidth=82
  hi DiffAdd term=bold ctermbg=blue 
  hi DiffChange term=bold ctermbg=green guifg=red guibg=lightGray
  hi DiffDelete term=bold cterm=bold ctermfg=4 ctermbg=6 gui=bold guifg=lightGray guibg=DarkGray
  hi DiffText term=reverse cterm=bold ctermbg=1 gui=bold guibg=DarkGray guifg=purple
  
  map <SPACE> ]czz
  map <A-x> ]czz
  map <A-z> [czz
  map <s-SPACE> [czz
  map <silent> <f2> :set diffopt^=iwhite<cr>
  map <silent> <s-f2> :set diffopt-=iwhite<cr>
  map <silent> <a-d> :set diff!<cr>
  map yu <esc>:diffget<cr>
  map yt <esc>:diffup<cr>
  cnoreab q qa
  cnoreab qq q
  cnoreab x xa
  cnoreab xx x
  if $COMMIT == 1
      colorscheme peachpuff
  endif

  set go-=rRlL dip=filler,context:5000
  set lsp=3 co=159 noea

endif

"to change the DirDiff options
let g:DirDiffSort = 1
let g:DirDiffIgnore = "ld;Revision;Date"
let g:DirDiffExcludes = "CVS,*.class,*.exe,*.swp,*.o"

function! IsTokenChar(is_fname, char)

        if a:char == "_"
                return 1
        endif
        if a:char >= "0" && a:char <= "9"
                return 1
        endif
        if a:char >= "A" && a:char <= "Z"
                return 1
        endif
        if a:char >= "a" && a:char <= "z"
                return 1
        endif
        if a:is_fname && a:char == "/"
                return 1
        endif
        if a:is_fname && a:char == "."
                return 1
        endif
        if a:is_fname && a:char == "-"
                return 1
        endif
        return 0
endfunction

function! TokenUnderCursor(is_fname)
        let line = getline(".")
        let pos = col(".") - 1

        let begpos = pos - 1
        while IsTokenChar(a:is_fname, strpart(line, begpos, 1)) == 1
                let begpos = begpos - 1
        endwhile

        let endpos = pos + 1
        while IsTokenChar(a:is_fname, strpart(line, endpos, 1)) == 1
                let endpos = endpos + 1
        endwhile

        return strpart(line, begpos+1, endpos-begpos-1)
endfunction

function Jbugz()
    if &modified
        " TODO: consider warning the caller
        echo "Saving buffer before doing CVS Ann"
        exe ":w"
    endif
    let cmd="bugz show " . TokenUnderCursor(1) . " -f -t"
    let out=system(cmd)
    " TODO: try to edit a new temp file
    :ene
    silent 0put=out
    set buftype=nofile
    set filetype=bugz
endfunction

function! PutDebugLine(lvl)
    if a:lvl==1
        let dlvl="_E"
    elseif a:lvl==2
        let dlvl="_W"
    elseif a:lvl==3
        let dlvl="_I"
    elseif a:lvl==4
        let dlvl="_V"
    elseif a:lvl==5
        let dlvl="_X"
    endif
    exe 'norm! aDBG'.dlvl.'(, ("%s: \n", FNAME));'
endfunction

map <F1> ma :execute ':!cvsdiff' TokenUnderCursor(1) <CR><CR>

" add debug lines (DBG_)
au BufNewFile,BufRead *.c map debug1 :call PutDebugLine(1)<cr>==wli
"au BufNewFile,BufRead *.c imap debug1 <c-o>:call PutDebugLine(1)<cr><esc>==wli
au BufNewFile,BufRead *.c map debug2 :call PutDebugLine(2)<cr>==wli
"au BufNewFile,BufRead *.c imap debug2 <c-o>:call PutDebugLine(2)<cr><esc>==wli
au BufNewFile,BufRead *.c map debug3 :call PutDebugLine(3)<cr>==wli
"au BufNewFile,BufRead *.c imap debug3 <c-o>:call PutDebugLine(3)<cr><esc>==wli
au BufNewFile,BufRead *.c map debug4 :call PutDebugLine(4)<cr>==wli
"au BufNewFile,BufRead *.c imap debug4 <c-o>:call PutDebugLine(4)<cr><esc>==wli
au BufNewFile,BufRead *.c map debug5 :call PutDebugLine(5)<cr>==wli
"au BufNewFile,BufRead *.c imap debug5 <c-o>:call PutDebugLine(5)<cr><esc>==wli

map <F3> :call Jbugz()<CR>
map <F8> :call Browser()<CR>
map <silent> <f12> :TlistToggle<cr>
"open buffers and choose the buffer you want
map bb :buffers<CR>:b
"copy cut paste like windows
map <C-c> yw
map <C-v> pw
map <C-x> dw
"increase/decrease font
nmap <F11> :silent! let &guifont = substitute(&guifont, ':h\zs\d\+', '\=eval(submatch(0) - 1)', '')<CR>
nmap <S-F11> :silent! let &guifont = substitute(&guifont, ':h\zs\d\+', '\=eval(submatch(0) + 1)', '')<CR>

function! MySwapUp()
  if ( line(".") > 1 )
    let cur_col = virtcol(".") - 1
    if ( line(".") == line("$") )
      normal ddP
    else
      normal ddkP
    endif
    execute "normal " . cur_col . "|"
  endif
endfunction

function! MySwapDown()
  if ( line(".") < line("$") )
    let cur_col = virtcol(".")
    normal ddp
    execute "normal " . cur_col . "|"
  endif
endfunction

function! MySwapRight()
  if ( col(".") < col("$") - 1 )
    normal xp
  endif
endfunction

function! MySwapLeft()
  if ( col(".") > 1 )
    if ( col(".") < col("$")  - 1 )
      normal xhP
    else
      normal xP
    endif
  endif
endfunction

" swap char right
noremap <silent> <c-a-right> :call MySwapRight()<cr>
" swap char left
noremap <silent> <c-a-left> :call MySwapLeft()<cr>
" swap line up
noremap <silent> <c-up> :call MySwapUp()<cr>
" swap line down
noremap <silent> <c-down> :call MySwapDown()<cr>

"change settings for linux kernel coding
nmap linux <ESC>:set noexpandtab<CR>:set shiftwidth=8<CR>

au FileType make setlocal nosmarttab | setlocal noexpandtab


