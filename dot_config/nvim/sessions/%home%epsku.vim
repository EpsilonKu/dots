let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
argglobal
%argdel
$argadd .local/share/Steam/steamapps/compatdata/236850/pfx/drive_c/users/steamuser/Documents/Paradox\ Interactive/Europa\ Universalis\ IV/mod/MEIOUandTaxes1/Tools\ for\ Modding/Coding/README_Coding.txt
edit .local/share/Steam/steamapps/compatdata/236850/pfx/drive_c/users/steamuser/Documents/Paradox\ Interactive/Europa\ Universalis\ IV/mod/MEIOUandTaxes1/Tools\ for\ Modding/Coding/README_Coding.txt
argglobal
let s:l = 1 - ((0 * winheight(0) + 10) / 21)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1
normal! 0
tabnext 1
badd +0 .local/share/Steam/steamapps/compatdata/236850/pfx/drive_c/users/steamuser/Documents/Paradox\ Interactive/Europa\ Universalis\ IV/mod/MEIOUandTaxes1/Tools\ for\ Modding/Coding/README_Coding.txt
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=filnxtToOF
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
set hlsearch
nohlsearch
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
