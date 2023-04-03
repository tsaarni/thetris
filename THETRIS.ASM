                dosseg
                model   compact
                .stack  1024
                .386

                extrn   fontti:byte
                extrn   picture:byte
                extrn   logo:byte
                extrn   requester:byte
                extrn   palat:byte
                extrn   high_tausta:byte

;--------------------------------------------------------------- NORMAL DATA

BS              equ     20
CR              equ     13
fadeflag        equ     1
soundflag       equ     2
lshiftflag      equ     4
rshiftflag      equ     8
nextflag        equ     16
eka_x           equ     115
n_p             equ     320*28+40
high_a_x        equ     11
high_b_x        equ     164
high_a_xr       equ     157
high_b_xr       equ     310
high_a_y        equ     74
high_b_y        equ     74
high_taus_y     equ     10

dseg            segment para public use16 'DATA'

                include thetris.pal
                include kirjapu.asm
                include defhigh.asm
highscore_filename db   'thetris.hi',0
setup_filename  db      'thetris.cfg',0
data_handle     dw      ?
text_1          db      'A .................................................................... Game A',0
text_2          db      'B .................................................................... Game B',0
text_3          db      'S ........................................................................ Setup',0
text_6          db      'H ................................................. See the top ten',0
text_info       db      'I ................ Information about the program',0
text_4          db      'Esc .............................................. Enough of this!',0
setup_menu      db      '-+ The Tris Setup +-',0
setup_1         db      'R ................................................. Redefine keys',0
setup_2off      db      'F .................................................... Fading is off',0
setup_2on       db      'F ..................................................... Fading is on',0
setup_3off      db      'S .................................... Sound default is off',0
setup_3on       db      'S ..................................... Sound default is on',0
setup_4off      db      'N .......................... Next piece default is off',0
setup_4on       db      'N ........................... Next piece default is on',0
setup_5         db      'Esc .......... Save changes and exit setup',0
level_text      db      'Choose starting level (0 - 9)',0
game_over_tx    db      '  Game over!  ',0
a_again_tx      db      'A .............. Play again',0
main_men_tx     db      'Esc ...... Game menu',0
high_score_tx   db      'Top 10 score!',0
type_name_tx    db      'Type your name:',0
player_name     dw      0
redefine_text   db      '-+ Key redefinition +-',0
left_key_text   db      'Move left: ',0
right_key_text  db      'Move right: ',0
rcw_key_text    db      'Rotate clockwise: ',0
rccw_key_text   db      'Rotate counter-clockwise: ',0
drop_key_text   db      'Drop: ',0
sound_key_text  db      'Sound toggle: ',0
next_key_text   db      'Next piece shown toggle: ',0
pause_key_text  db      'Pause: ',0
int_conv_buf    db      0,0,0,0,0,0,0
bufbuf          db      0,0
converter       db      230
empty_buf2      db      '           '
empty_buf       db      '         ',0
it_1            db      '-+ The Tris +-',0
it_2            db      '(c) Copyright 1994 TT-Soft',0
it_3            db      0
it_4            db      'Programmed by Timo Haanp„„',0
it_5            db      'Graphics by Tero Saarni',0
it_6            db      'This program is not free, please support',0
it_7            db      'the shareware concept.',0
it_8            db      'The contact addresses can be found in the',0
it_9            db      'document file included in the package.',0
it_10           db      'This is an unregistered version',0
;it_11           db      "Tero Saarni",0
;it_12           db      'ONLY',0
info_texts      dw      offset it_1
                dw      offset it_3
                dw      offset it_2
                dw      offset it_3
                dw      offset it_4
                dw      offset it_5
                dw      offset it_3
                dw      offset it_6
                dw      offset it_7
                dw      offset it_8
                dw      offset it_9
                dw      offset it_3
                dw      offset it_10
;                dw      offset it_11
;                dw      offset it_12
                dw      0
paloja          dw      044c0h,00e20h,06440h,08e00h     ;0 white
                dw      00f00h,02222h,00f00h,02222h     ;1 red
                dw      00cc0h,00cc0h,00cc0h,00cc0h     ;2 blue
                dw      006c0h,04620h,006c0h,04620h     ;3 green
                dw      00e80h,04460h,02e00h,0c440h     ;4 magenta
                dw      00e40h,04640h,04e00h,04c40h     ;5 brown
                dw      00c60h,02640h,00c60h,02640h     ;6 cyan
;--- level B
                dw      08000h,08000h,08000h,08000h     ;7 yellow
                dw      0c8c0h,00ae0h,06260h,0ea00h
                dw      0c800h,08c00h,04c00h,0c400h
                dw      04800h,08400h,04800h,08400h
                dw      08e20h,064c0h,08e20h,064c0h
                dw      02e80h,0c460h,02e80h,0c460h
                dw      04e40h,04e40h,04e40h,04e40h
                dw      06c80h,08c60h,026c0h,0c620h
koordit         dw      n_p+9+4*320,n_p+4,n_p+320*4,n_p+4+8*320
                dw      n_p+320*4,n_p-5,n_p+320*4,n_p-5
                dw      n_p+9,n_p+9,n_p+9,n_p+9
                dw      n_p+4,n_p+4*320,n_p+4,n_p+4*320
                dw      n_p+4,n_p+4*320,n_p+4+8*320,n_p+9+4*320
                dw      n_p+4,n_p+4*320,n_p+4+8*320,n_p+9+4*320
                dw      n_p+4,n_p+4*320,n_p+4,n_p+4*320
                dw      n_p+13+12*320,n_p+13+12*320,n_p+13+12*320,n_p+13+12*320
                dw      n_p+4+4*320,n_p+4+4*320,n_p+4+4*320,n_p+4+4*320
                dw      n_p+4+4*320,n_p+4+4*320,n_p+4+4*320,n_p+4+4*320
                dw      n_p+9+8*320,n_p+9+8*320,n_p+9+8*320,n_p+9+8*320
                dw      n_p+4+4*320,n_p+4+4*320,n_p+4+4*320,n_p+4+4*320
                dw      n_p+4+4*320,n_p+4+4*320,n_p+4+4*320,n_p+4+4*320
                dw      n_p+4+4*320,n_p+4+4*320,n_p+4+4*320,n_p+4+4*320
                dw      n_p+4+4*320,n_p+4+4*320,n_p+4+4*320,n_p+4+4*320

asciilista      dw      0,esctx,n1tx,n2tx,n3tx,n4tx,n5tx,n6tx,n7tx,n8tx,n9tx,n0tx
                dw      miinustx,onyhtakuintx,bstx,tabtx,qtx,wtx,etx,rtx,ttx
                dw      ytx,utx,itx,otx,ptx,vasenhakatx,oikeahakatx,entertx
                dw      ctrltx,atx,stx,dtx,ftx,gtx,htx,jtx,ktx,ltx
                dw      puolipilkkutx,heittotx,heitto2tx,leftshifttx
                dw      kenoviivatx,ztx,xtx,ctx,vtx,btx,ntx,mtx,pilkkutx
                dw      pistetx,kauttamerkkitx,rightshifttx,greytahtitx
                dw      alttx,spacebartx,capslocktx,f1tx,f2tx,f3tx,f4tx
                dw      f5tx,f6tx,f7tx,f8tx,f9tx,f10tx,numlocktx,scrolllocktx
                dw      hometx,arruptx,pguptx,greyminustx,arrlttx,kp5tx
                dw      arrrttx,greyplustx,endtx,arrdntx,pgdntx,instx
                dw      deltx,sysrqtx,0,leftkeno,f11tx,f12tx,PA1tx,f13tx
                dw      f14tx,f15tx,f16tx,f17tx,f18tx,f19tx,f20tx,f21tx
                dw      f22tx,f23tx,f24tx,0,0,0,0,0,0,0,0,0,0,0
ascii_dcase     db      0,0,"1234567890-=",BS,0,"qwertyuiop[]",CR
                db      0,"asdfghjkl;'",0,0,"\zxcvbnm,./",0,"*",0," ",0
                db      0,0,0,0,0,0,0,0,0,0,0,0,"789-456+1230.",0,0,"\"
                db      0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
                db      156 dup(0)
ascii_ucase     db      0,0,"!@#$%^&*()_+",BS,0,"QWERTYUIOP{}",CR
                db      0,'ASDFGHJKL:"',0,0,"|ZXCVBNM<>?",0,"*",0," ",0
                db      0,0,0,0,0,0,0,0,0,0,0,0,"789-456+1230.",0,0,"\"
                db      0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
                db      156 dup(0)


kenoviivatx     db      'Backslash',0
kauttamerkkitx  db      'Slash',0
atx             db      'A',0
btx             db      'B',0
ctx             db      'C',0
dtx             db      'D',0
etx             db      'E',0
ftx             db      'F',0
gtx             db      'G',0
htx             db      'H',0
itx             db      'I',0
jtx             db      'J',0
ktx             db      'K',0
ltx             db      'L',0
mtx             db      'M',0
ntx             db      'N',0
otx             db      'O',0
ptx             db      'P',0
qtx             db      'Q',0
rtx             db      'R',0
stx             db      'S',0
ttx             db      'T',0
utx             db      'U',0
vtx             db      'V',0
wtx             db      'W',0
xtx             db      'X',0
ytx             db      'Y',0
ztx             db      'Z',0
n1tx            db      '1',0
n2tx            db      '2',0
n3tx            db      '3',0
n4tx            db      '4',0
n5tx            db      '5',0
n6tx            db      '6',0
n7tx            db      '7',0
n8tx            db      '8',0
n9tx            db      '9',0
n0tx            db      '0',0
miinustx        db      '-',0
onyhtakuintx    db      'Equal sign',0
heittotx        db      "Quote char",0
heitto2tx       db      'Reverse quote',0
vasenhakatx     db      'Left bracket',0
oikeahakatx     db      'Right bracket',0
puolipilkkutx   db      'Semicolon',0
pistetx         db      '.',0
pilkkutx        db      ',',0
PA1tx           db      'PA1',0
leftkeno        db      'Left backslash',0
esctx           db      'Esc',0
bstx            db      'Backspace',0
tabtx           db      'Tab',0
entertx         db      'Enter',0
ctrltx          db      'Ctrl',0
leftshifttx     db      'Left shift',0
rightshifttx    db      'Right shift',0
greytahtitx     db      'Grey *',0
greyminustx     db      'Grey -',0
greyplustx      db      'Grey +',0
alttx           db      'Alt',0
spacebartx      db      'Space bar',0
capslocktx      db      'Caps lock',0
sysrqtx         db      'SysReq',0
instx           db      'Insert',0
hometx          db      'Home',0
pguptx          db      'PgUp',0
pgdntx          db      'PgDn',0
endtx           db      'End',0
deltx           db      'Delete',0
arruptx         db      'Arrow up',0
arrdntx         db      'Arrow down',0
arrlttx         db      'Arrow left',0
arrrttx         db      'Arrow right',0
kp5tx           db      'Keypad 5',0
prstx           db      'Print screen',0
scrolllocktx    db      'Scroll lock',0
numlocktx       db      'Num lock',0
pausetx         db      'Pause',0
f1tx            db      'F1',0
f2tx            db      'F2',0
f3tx            db      'F3',0
f4tx            db      'F4',0
f5tx            db      'F5',0
f6tx            db      'F6',0
f7tx            db      'F7',0
f8tx            db      'F8',0
f9tx            db      'F9',0
f10tx           db      'F10',0
f11tx           db      'F11',0
f12tx           db      'F12',0
f13tx           db      'F13',0
f14tx           db      'F14',0
f15tx           db      'F15',0
f16tx           db      'F16',0
f17tx           db      'F17',0
f18tx           db      'F18',0
f19tx           db      'F19',0
f20tx           db      'F20',0
f21tx           db      'F21',0
f22tx           db      'F22',0
f23tx           db      'F23',0
f24tx           db      'F24',0
curr_flags      db      0
flags           db      fadeflag
left_key        dw      4bh
right_key       dw      4dh
cw_rotate       dw      48h
ccw_rotate      dw      4ch
drop_key        dw      39h
sound_key       dw      1fh
next_key        dw      31h
pause_key       dw      19h
timer           db      ?
speed           db      ?
number_of_pieces db     ?
level           db      ?
rows            dw      ?
score           dw      ?
text_x          dw      ?
text_y          dw      ?
current_piece   dw      ?
current_angle   dw      ?
current_row     dw      ?
current_column  dw      ?
next_piece      dw      ?
next_angle      dw      ?
name_counter    dw      ?
random_seed     dw      ?
keycode         dw      ?
old_kb_seg      dw      ?
old_kb_off      dw      ?
lines_eliminated dw     ?
old_video_mode  db      ?
                ends

;------------------------------------------------------------------- CODE SEG

cseg            segment para public use16 'CODE'
                assume  cs:cseg,ds:dseg

                mov     dx,dseg
                mov     ds,dx
                mov     dx,040h
                mov     es,dx
                mov     ax,word ptr es:[6ch]
                add     ax,word ptr es:[6eh]
                add     ah,byte ptr es:[67h]
                add     ds:[random_seed],ax

                call    read_highscores
                call    read_setup

                call    set_kbhandler

                xor     esi,esi
                xor     edi,edi
                cld

                mov     dx,dseg
                mov     ds,dx

                mov     ah,0fh
                int     10h
                mov     ds:[old_video_mode],al

                mov     ax,0013h
                int     10h

                call    clear_palette

                call    game_menu

                mov     dx,dseg
                mov     ds,dx
                xor     ah,ah
                mov     al,ds:[old_video_mode]
                int     10h

                call    remove_kbhandler
exit:
                mov     ax,4c00h
                int     21h

;----------------------------------------------------------------------------


clear_palette   proc    near
                push    ds
                xor     bl,bl
                call    set_pal
                pop     ds
                ret
                endp

fade_out        proc    near
                pusha
                mov     dx,dseg
                mov     ds,dx
                test    ds:[flags],fadeflag
                jz      ei_fadea
                mov     bl,32
fo_loop:        call    waitblank
                call    set_pal
                dec     bl
                test    bl,bl
                jnz     fo_loop
                popa
                ret
ei_fadea:       mov     ds:[keycode],0
                popa
                ret
                endp

fade_in         proc    near
                pusha
                mov     dx,dseg
                mov     ds,dx
                test    ds:[flags],fadeflag
                jnz     fadetus
                mov     bl,31
                jmp     fi_loop
fadetus:        xor     bl,bl
fi_loop:        inc     bl
                call    waitblank
                call    set_pal
                cmp     bl,32
                jnz     fi_loop
                popa
                ret
                endp

set_pal         proc    near
                mov     dx,seg palette
                mov     ds,dx
                mov     si,offset palette
                mov     dx,3c8h
                xor     al,al
                out     dx,al
                inc     dx
                mov     cx,3*256
sp_lop:         lodsb
                mul     bl
                shr     ax,5
                out     dx,al
                loop    sp_lop
                ret
                endp

waitblank       proc    near
                mov     dx,3dah
w_bl:           in      al,dx
                test    al,8
                jz      w_bl
w_bl2:          in      al,dx
                test    al,8
                jnz     w_bl2
                ret
                endp

;----------------------------------------------------------------------------

game_menu       proc    near

takas_takas:
                call    clear_screen
                mov     dx,seg logo
                mov     ds,dx
                mov     si,offset logo
                mov     edi,320*20
                mov     cx,60*80
                rep     movsd

                mov     dx,dseg
                mov     fs,dx

                mov     si,offset text_1
                mov     ax,159
                mov     bx,90
                call    center_text
                mov     si,offset text_2
                mov     ax,159
                mov     bx,101
                call    center_text
                mov     si,offset text_3
                mov     ax,159
                mov     bx,112
                call    center_text

                mov     si,offset text_6
                mov     ax,159
                mov     bx,123
                call    center_text

                mov     si,offset text_info
                mov     ax,159
                mov     bx,134
                call    center_text

                mov     si,offset text_4
                mov     ax,159
                mov     bx,145
                call    center_text

                call    fade_in

wait_keyb:      mov     ax,fs:[keycode]
                test    al,0ffh
                jz      wait_keyb

                mov     word ptr ds:[keycode],0h

                cmp     al,1eh
                jnz     ei_a
                mov     fs:[number_of_pieces],7
                call    fade_out
                call    game
                jmp     takas_takas
ei_a:
                cmp     al,30h
                jnz     ei_b
                mov     fs:[number_of_pieces],15
                call    fade_out
                call    game
                jmp     takas_takas

ei_b:           cmp     al,23h
                jnz     ei_h

                call    fade_out
                call    show_highscores
                jmp     takas_takas

ei_h:           cmp     al,17h
                jnz     ei_i
                call    fade_out
                call    show_info
                jmp     takas_takas
ei_i:           cmp     al,1fh
                jnz     ei_s
                call    fade_out
                call    game_setup
                jmp     takas_takas

ei_s:
                cmp     al,1h
                jnz     wait_keyb
                call    fade_out
                ret


show_info:
                call    clear_screen
                mov     dx,seg info_texts
                mov     ds,dx
                mov     es,dx
                mov     di,offset info_texts

                mov     bx,20
sin_loop:       mov     si,es:[di]
                add     di,2
                cmp     si,0h
                jz      sin_pois
                push    bx
                push    es
                push    di
                mov     ax,159
                call    center_text
                pop     di
                pop     es
                pop     bx
                add     bx,11
                jmp     sin_loop

sin_pois:
                call    fade_in
                mov     dx,seg dseg
                mov     ds,dx

                mov     ds:[keycode],0
wait_keybsh:    mov     ax,ds:[keycode]
                test    al,0ffh
                jz      wait_keybsh
                mov     ds:[keycode],0
                call    fade_out
                ret

;-----------------------------------------------------------------------

game_setup:
                call    clear_screen
                mov     dx,dseg
                mov     ds,dx
                mov     fs,dx
                call    setup_ruutu
                call    fade_in

uusix:          call    setup_ruutu
wait_keybs:     mov     ax,ds:[keycode]
                test    al,0ffh
                jz      wait_keybs
                mov     ds:[keycode],0

                cmp     al,13h
                jnz     wei_r
                call    redefine_keys
                jmp     game_setup
wei_r:
                cmp     al,1fh
                jnz     wei_s
                xor     ds:[flags],soundflag
                jmp     uusix
wei_s:
                cmp     al,21h
                jnz     wei_f
                xor     ds:[flags],fadeflag
                jmp     uusix
wei_f:
                cmp     al,31h
                jnz     wei_n
                xor     ds:[flags],nextflag
                jmp     uusix
wei_n:
                cmp     al,1h
                jnz     wait_keybs

                call    fade_out
                call    write_setup
                ret

setup_ruutu:    mov     si,offset setup_menu
                mov     ax,159
                mov     bx,50
                call    center_text
                mov     si,offset setup_1
                mov     ax,159
                mov     bx,77
                call    center_text
                mov     si,offset setup_2off
                test    ds:[flags],fadeflag
                jz      ff_off
                mov     si,offset setup_2on
ff_off:
                mov     ax,159
                mov     bx,88
                call    center_text

                mov     si,offset setup_3off
                test    ds:[flags],soundflag
                jz      sf_off
                mov     si,offset setup_3on
sf_off:
                mov     ax,159
                mov     bx,99
                call    center_text

                mov     si,offset setup_4off
                test    ds:[flags],nextflag
                jz      nf_off
                mov     si,offset setup_4on
nf_off:
                mov     ax,159
                mov     bx,110
                call    center_text

                mov     si,offset setup_5
                mov     ax,159
                mov     bx,121
                call    center_text
                ret

redefine_keys:
                call    fade_out
                call    clear_screen
                mov     si,offset redefine_text
                mov     ax,159
                mov     bx,10
                call    center_text

                mov     si,offset left_key
                mov     ax,0
                mov     ds:[si],ax
                mov     ds:2[si],ax
                mov     ds:4[si],ax
                mov     ds:6[si],ax
                mov     ds:8[si],ax
                mov     ds:10[si],ax
                mov     ds:12[si],ax
                mov     ds:14[si],ax

                mov     si,offset left_key_text
                mov     ax,10
                mov     bx,30
                call    output_text
                call    fade_in
                call    get_key
                mov     left_key,ax

                mov     si,offset right_key_text
                mov     ax,10
                mov     bx,42
                call    output_text
                call    get_key
                mov     right_key,ax

                mov     si,offset rcw_key_text
                mov     ax,10
                mov     bx,54
                call    output_text
                call    get_key
                mov     cw_rotate,ax

                mov     si,offset rccw_key_text
                mov     ax,10
                mov     bx,66
                call    output_text
                call    get_key
                mov     ccw_rotate,ax

                mov     si,offset drop_key_text
                mov     ax,10
                mov     bx,78
                call    output_text
                call    get_key
                mov     drop_key,ax

                mov     si,offset sound_key_text
                mov     ax,10
                mov     bx,90
                call    output_text
                call    get_key
                mov     sound_key,ax

                mov     si,offset next_key_text
                mov     ax,10
                mov     bx,102
                call    output_text
                call    get_key
                mov     next_key,ax

                mov     si,offset pause_key_text
                mov     ax,10
                mov     bx,114
                call    output_text
                call    get_key
                mov     pause_key,ax

                call    fade_out
                ret
get_key:
wait_keybsr:    mov     ax,ds:[keycode]
                test    al,0ffh
                jz      wait_keybsr
                mov     ds:[keycode],0

                cmp     al,02ah
                jz      get_key

                mov     si,offset left_key
                cmp     [si],ax
                jz      get_key
                cmp     2[si],ax
                jz      get_key
                cmp     4[si],ax
                jz      get_key
                cmp     6[si],ax
                jz      get_key
                cmp     8[si],ax
                jz      get_key
                cmp     10[si],ax
                jz      get_key
                cmp     12[si],ax
                jz      get_key
                cmp     14[si],ax
                jz      get_key

                push    ax

                mov     si,offset asciilista
                mov     bx,ax
                and     bx,0ffh
                shl     bx,1
                mov     si,ds:[si+bx]
                mov     bx,text_y
                mov     ax,text_x
                call    output_text

                pop     ax

                ret

;-----------------------------------------------------------------------

show_highscores:
                call    clear_screen

                mov     dx,seg high_tausta
                mov     ds,dx
                mov     si,offset high_tausta
                mov     dx,0a000h
                mov     es,dx
                mov     di,high_taus_y*320

                mov     cx,320*188
                rep     movsb

                mov     dx,dseg
                mov     ds,dx

                mov     cx,10
                mov     si,offset hstab_a
                mov     bx,high_a_y
hs_loop:        push    si
                push    bx
                push    cx
                push    bx
                push    si
                mov     ax,high_a_x
                call    output_text
                pop     si
                pop     bx
                add     si,41
                mov     ax,high_a_xr
                call    right_align_int
                pop     cx
                pop     bx
                pop     si
                add     bx,11
                add     si,43
                loop    hs_loop

                mov     cx,10
                mov     si,offset hstab_b
                mov     bx,high_b_y
hs_loop2:       push    si
                push    bx
                push    cx
                push    bx
                push    si
                mov     ax,high_b_x
                call    output_text
                pop     si
                pop     bx
                add     si,41
                mov     ax,high_b_xr
                call    right_align_int
                pop     cx
                pop     bx
                pop     si
                add     bx,11
                add     si,43
                loop    hs_loop2

                call    fade_in

                mov     dx,seg dseg
                mov     ds,dx

                mov     ds:[keycode],0
wait_keybh2:    mov     ax,ds:[keycode]
                test    al,0ffh
                jz      wait_keybh2
                mov     ds:[keycode],0
                call    fade_out
                ret


ask_level:      call    clear_screen
                mov     si,offset level_text
                mov     ax,159
                mov     bx,94
                call    center_text

                call    fade_in

wait_keyc:      mov     ax,fs:[keycode]
                test    al,0ffh
                jz      wait_keyc
                mov     word ptr ds:[keycode],0h

                cmp     al,1h
                jz      esc_hit
                cmp     al,0bh
                ja      wait_keyc
                jnz     ei_nolla
                call    fade_out
                xor     al,al
                mov     ds:[level],al
                ret
ei_nolla:       dec     al
                mov     ds:[level],al
                xor     al,al
esc_hit:
                call    fade_out
                ret
                endp

center_text     proc    near
                push    si
                push    bx
                push    ax
                call    text_width
                pop     ax
                sar     dx,1
                sub     ax,dx
                pop     bx
                pop     si
                call    output_text
                ret
                endp

right_align_int proc    near
                mov     dx,dseg
                mov     ds,dx

                push    ax
                push    bx

                mov     ax,ds:[si]
                mov     byte ptr ds:[converter],'0'
                call    conv_int
                mov     si,di

                push    si
                call    text_width
                pop     si

                pop     bx
                pop     ax
                sub     ax,dx

                call    output_text
                ret
                endp

output_text     proc    near
                mov     dx,dseg
                mov     ds,dx
                mov     ds:[text_x],ax
                mov     ds:[text_y],bx
ot_loop:        lodsb
                test    al,0ffh
                jz      ot_pois
                call    output_char
                jmp     ot_loop
ot_pois:        ret
                endp

text_width      proc    near
                mov     dx,dseg
                mov     ds,dx
                xor     dx,dx
tw_loop:        lodsb
                test    al,0ffh
                jz      tw_pois
                call    char_width
                add     dx,ax
                jmp     tw_loop
tw_pois:        ret

char_width:     mov     cx,seg kirjapu
                mov     es,cx
                mov     di,offset kirjapu
                mov     cx,89
                repne   scasb
                mov     bx,88
                sub     bx,cx
                add     bx,bx
                mov     ax,es:[kirj_leveydet+BX]
                ret
                endp

output_char     proc    near
                push    ds
                push    si
                mov     dx,dseg
                mov     fs,dx
                mov     dx,seg kirjapu
                mov     es,dx
                mov     di,offset kirjapu
                mov     cx,89
                repne   scasb
                mov     bx,88
                sub     bx,cx
                add     bx,bx
                mov     cx,fs:[kirj_leveydet+BX]                ;ax = kirjaimen leveys
                mov     bx,fs:[kirj_offsetit+BX]                ;bx = offsetti kirjaimen alkuun
                mov     dx,0a000h
                mov     es,dx
                mov     dx,seg fontti
                mov     ds,dx
                mov     si,offset fontti
                add     si,bx
                mov     ax,fs:[text_y]
                mov     dx,320
                mul     dx
                add     ax,fs:[text_x]
                add     fs:[text_x],cx
                mov     di,ax
                mov     ax,320
                mov     bx,317
                sub     ax,cx
                sub     bx,cx
                mov     dx,cx
                rep     movsb
                add     si,bx
                add     di,ax
                mov     cx,dx
                rep     movsb
                add     si,bx
                add     di,ax
                mov     cx,dx
                rep     movsb
                add     si,bx
                add     di,ax
                mov     cx,dx
                rep     movsb
                add     si,bx
                add     di,ax
                mov     cx,dx
                rep     movsb
                add     si,bx
                add     di,ax
                mov     cx,dx
                rep     movsb
                add     si,bx
                add     di,ax
                mov     cx,dx
                rep     movsb
                add     si,bx
                add     di,ax
                mov     cx,dx
                rep     movsb
                add     si,bx
                add     di,ax
                mov     cx,dx
                rep     movsb
                add     si,bx
                add     di,ax
                mov     cx,dx
                rep     movsb
                add     si,bx
                add     di,ax
                mov     cx,dx
                rep     movsb
;                add     si,bx
;                add     di,ax
;                mov     cx,dx
;                rep     movsb
                pop     si
                pop     ds
                ret
                endp

;-----------------------------------------------------------------------------

clear_screen    proc    near
                mov     dx,0a000h
                mov     es,dx
                xor     di,di
                xor     eax,eax
                mov     cx,16000
                rep     stosd                   ;clear screen
                ret
                endp

;-----------------------------------------------------------------------------

game            proc    near

                mov     dx,seg dseg
                mov     ds,dx
                mov     al,ds:[flags]
                mov     ds:[curr_flags],al

uusi:           call    ask_level
                cmp     al,1h
                jnz     anti_menna
                ret
anti_menna:     mov     dx,seg picture
                mov     ds,dx
                mov     si,offset picture
                mov     dx,0a000h
                mov     es,dx
                xor     di,di
                mov     cx,16000
                rep     movsd

                mov     dx,seg dseg
                mov     ds,dx

                mov     al,ds:[level]
                mov     bl,3
                mul     bl
                mov     bl,4+9*3
                sub     bl,al
                mov     ds:[speed],bl

                mov     ds:[next_piece],0
                mov     ds:[next_angle],0
                call    arvo_next_piece
                call    arvo_next_piece

                mov     al,ds:[speed]
                dec     al
                mov     ds:[timer],al
                mov     ds:[rows],0
                mov     ds:[current_row],0
                mov     ds:[score],0
                mov     ds:[current_column],4

                call    show_score
                call    fade_in
wait_loop:      mov     dx,seg dseg
                mov     ds,dx
                mov     dx,3dah
wait_blank:     mov     ax,word ptr ds:[keycode]
                test    al,0ffh
                jnz     key_hit
                in      al,dx
                test    al,8
                jz      wait_blank
wbl2:           in      al,dx
                test    al,8
                jnz     wbl2
                inc     ds:[timer]
                mov     al,ds:[speed]
                cmp     ds:[timer],al
                jnz     no_event
                xor     al,al
                mov     ds:[timer],al
                push    ds
                call    drop
                pop     ds
                test    al,0ffh
                jz      wait_loop

pomppa:         xor     ah,ah
                mov     al,ds:[level]
                inc     al
                mov     bl,3
                mul     bl
                add     ds:[score],ax

                push    ds
                call    show_score
                pop     ds

                mov     al,ds:[speed]
                dec     al
                mov     ds:[timer],al

                push    ds
                call    check_lines
                pop     ds
                test    al,0ffh
                jnz     linjoja_poistui

                test    ds:[current_row],0ffh
                jz      game_over

linjoja_poistui:call    arvo_next_piece
                mov     ds:[current_row],0
                mov     ds:[current_column],4
no_event:
                jmp     wait_loop

key_hit:        mov     word ptr ds:[keycode],0h

                cmp     byte ptr ds:[ccw_rotate],al
                jnz     no_rotate
                call    rotate
                jmp     wait_loop
no_rotate:
                cmp     byte ptr ds:[cw_rotate],al
                jnz     no_rotate2
                call    rotate2
                jmp     wait_loop
no_rotate2:
                cmp     byte ptr ds:[left_key],al
                jnz     no_left
                call    move_left
                jmp     wait_loop
no_left:
                cmp     byte ptr ds:[right_key],al
                jnz     no_right
                call    move_right
                jmp     wait_loop
no_right:
                cmp     byte ptr ds:[drop_key],al
                jnz     no_spacebar
                xor     ah,ah
                mov     al,ds:[level]
                mov     bx,20
                sub     bx,ds:[current_row]
                add     al,bl
                shr     al,2
                add     ds:[score],ax
                push    ds
                call    drop_at_once
                pop     ds
                jmp     pomppa
no_spacebar:
                cmp     byte ptr ds:[pause_key],al
                jnz     no_pause

                pusha
                mov     bl,0
                call    set_pal
                popa

                mov     ds:[keycode],0
wait_for_key:
                mov     ax,word ptr ds:[keycode]
                test    al,0ffh
                jz      wait_for_key
                mov     ds:[keycode],0

                cmp     byte ptr ds:[pause_key],al
                jnz     wait_for_key

                pusha
                mov     bl,32
                call    set_pal
                popa
                jmp     wait_loop
no_pause:
                cmp     ds:[next_key],ax
                jnz     no_next_key
                xor     ds:[curr_flags],nextflag
                pusha
                call    clr_next
                call    draw_next
                popa
no_next_key:
                cmp     ds:[sound_key],ax
                jnz     no_sound_key
                xor     ds:[curr_flags],soundflag
no_sound_key:
                jmp     wait_loop
game_over:
                mov     dx,seg requester
                mov     ds,dx
                mov     si,offset requester
;159*65

                mov     dx,0a000h
                mov     es,dx
                mov     di,80+67*320

                mov     cx,65
req_loop:       push    cx
                mov     cx,159
                rep     movsb
                pop     cx
                add     di,320-159
                loop    req_loop

                mov     dx,dseg
                mov     ds,dx

                call    high_scoreko

                mov     si,offset game_over_tx
                mov     ax,159
                mov     bx,80
                call    center_text
                mov     si,offset a_again_tx
                mov     ax,159
                mov     bx,96
                call    center_text
                mov     si,offset main_men_tx
                mov     ax,159
                mov     bx,108
                call    center_text

wait_keyr:      mov     ax,fs:[keycode]
                test    al,0ffh
                jz      wait_keyr
                mov     word ptr ds:[keycode],0h
                cmp     al,1eh
                jnz     eiuusi

                call    fade_out
                jmp     uusi
eiuusi:
                cmp     al,1
                jnz     wait_keyr
                call    fade_out
                ret

high_scoreko:
                pusha

                mov     si,offset hstab_a

                cmp     number_of_pieces,7
                jz      hsgame_eib
                mov     si,offset hstab_b
hsgame_eib:
                mov     ax,score

                mov     cx,10
hs_looppi:      cmp     41[si],ax
                jb      bigger
                add     si,43
                loop    hs_looppi
                jmp     ei_highscorea
bigger:
                mov     dx,ds
                mov     es,dx
                mov     dx,si
                mov     di,dx

                mov     player_name,dx

                mov     ax,43
                mul     cx

                add     si,ax
                add     di,ax

                sub     si,43

hscopyloop:     movsd
                movsd
                movsd
                movsd
                movsd
                movsd
                movsd
                movsd
                movsd
                movsd
                movsw
                movsb
                sub     si,43*2
                sub     di,43*2
                loop    hscopyloop

                mov     di,player_name

                mov     name_counter,0h
                mov     byte ptr [di],0h
                mov     ax,score
                mov     word ptr 41[di],ax
                mov     si,offset high_score_tx
                mov     ax,159
                mov     bx,80
                call    center_text
                mov     si,offset type_name_tx
                mov     ax,159
                mov     bx,96
                call    center_text

                mov     word ptr ds:[keycode],0h
wait_keyrrrr:   mov     ax,fs:[keycode]
                test    al,0ffh
                jz      wait_keyrrrr
                mov     word ptr ds:[keycode],0h

                mov     si,offset ascii_dcase

                test    ax,100h
                jz      ei_shiftia

                mov     si,offset ascii_ucase
ei_shiftia:
                xor     bx,bx
                mov     bl,al

                mov     al,[si+bx]

                test    al,al
                jz      wait_keyrrrr

                cmp     al,' '
                jnz     ei_space

                cmp     name_counter,0
                jz      wait_keyrrrr

ei_space:

                cmp     al,CR
                jz      retikka

                mov     si,player_name
                mov     bx,name_counter

                cmp     al,BS
                jnz     ei_BS

                test    bx,bx
                jz      ohi

                dec     bx
                mov     byte ptr [si+bx],0h
                jmp     ohi

ei_BS:

                cmp     bx,40
                jz      ohi

                pusha

                mov     si,player_name
                call    text_width

                cmp     dx,110

                popa

                ja      ohi

                mov     [si+bx],al
                inc     bx
                mov     byte ptr [si+bx],0h

ohi:
                mov     name_counter,bx

                mov     si,offset empty_buf2
                mov     ax,159
                mov     bx,108
                call    center_text

                mov     si,player_name
                mov     ax,159
                mov     bx,108
                call    center_text

                jmp     wait_keyrrrr

retikka:        call    write_highscores

ei_highscorea:  popa
                ret


                endp


;----------------------------------------------------------------------------

drop            proc    near
                mov     dx,seg dseg
                mov     ds,dx
                call    clr_piece
                mov     dx,seg dseg
                mov     ds,dx
                inc     ds:[current_row]
                call    test_piece
                test    al,0ffh
                jz      draw_new_one
                dec     ds:[current_row]
                mov     dx,seg dseg
                mov     ds,dx
                call    put_piece
                mov     al,1
                ret
draw_new_one:   mov     dx,seg dseg
                mov     ds,dx
                call    put_piece
                xor     al,al
                ret
                endp

drop_at_once    proc    near
                mov     dx,seg dseg
                mov     ds,dx
                call    clr_piece
                mov     dx,seg dseg
                mov     ds,dx
dao_loop:       inc     ds:[current_row]
                call    test_piece
                test    al,0ffh
                jz      dao_loop
                dec     ds:[current_row]
                mov     dx,seg dseg
                mov     ds,dx
                call    put_piece
                ret
                endp

move_right      proc    near
                mov     dx,seg dseg
                mov     ds,dx
                call    clr_piece
                mov     dx,seg dseg
                mov     ds,dx
                inc     ds:[current_column]
                call    test_piece
                test    al,0ffh
                jz      dno
                dec     ds:[current_column]
dno:            mov     dx,seg dseg
                mov     ds,dx
                call    put_piece
                ret
                endp

move_left       proc    near
                mov     dx,seg dseg
                mov     ds,dx
                call    clr_piece
                mov     dx,seg dseg
                mov     ds,dx
                dec     ds:[current_column]
                call    test_piece
                test    al,0ffh
                jz      dno2
                inc     ds:[current_column]
dno2:           mov     dx,seg dseg
                mov     ds,dx
                call    put_piece
                ret
                endp

rotate          proc    near
                mov     dx,seg dseg
                mov     ds,dx
                call    clr_piece
                mov     dx,seg dseg
                mov     ds,dx
                inc     ds:[current_angle]
                and     ds:[current_angle],3
                call    test_piece
                test    al,0ffh
                jz      dno3
                dec     ds:[current_angle]
                and     ds:[current_angle],3
dno3:           mov     dx,seg dseg
                mov     ds,dx
                call    put_piece
                ret
                endp

rotate2         proc    near
                mov     dx,seg dseg
                mov     ds,dx
                call    clr_piece
                mov     dx,seg dseg
                mov     ds,dx
                dec     ds:[current_angle]
                and     ds:[current_angle],3
                call    test_piece
                test    al,0ffh
                jz      dno32
                inc     ds:[current_angle]
                and     ds:[current_angle],3
dno32:          mov     dx,seg dseg
                mov     ds,dx
                call    put_piece
                ret
                endp

;----------------------------------------------------------------------------

check_lines     proc    near

                mov     dx,seg dseg
                mov     ds,dx
                xor     ax,ax
                mov     ds:[lines_eliminated],ax

                mov     cx,320*8
                mov     ax,ds:[current_row]
                mul     cx

                mov     dx,0a000h
                mov     es,dx

                add     ax,eka_x
                mov     di,ax

                mov     cx,22
                sub     cx,ds:[current_row]
                cmp     cx,4
                jb      cl_looppi2
                mov     cx,4
cl_looppi2:     push    cx
                xor     bx,bx
                mov     cx,10
cl_looppi:      mov     ax,es:[di]
                test    ax,0ffh
                jz      nollaa
                inc     bx
nollaa:         add     di,9
                loop    cl_looppi
                cmp     bx,10
                jnz     ei_linjaa_pois

                inc     ds:[lines_eliminated]

                push    ds
                push    es
                push    di

                add     di,320*7-90
                mov     si,di
                sub     si,320*8
                mov     dx,0a000h
                mov     ds,dx
                mov     es,dx

                xor     dx,dx
                mov     bx,320
                mov     ax,si
                div     bx
                mov     cx,ax
clclclcl:       push    cx
                mov     cx,90
                rep     movsb
                pop     cx
                sub     di,410
                sub     si,410
                loop    clclclcl

                pop     di
                pop     es
                pop     ds

ei_linjaa_pois: add     di,320-90+320*7
                pop     cx
                loop    cl_looppi2

                mov     ax,ds:[lines_eliminated]
                test    ax,0ffh
                jz      pois
                add     ds:[rows],ax
                mov     bx,ax
                mul     bl
                mov     bl,3
                mul     bl
                mov     bl,ds:[level]
                inc     bl
                mul     bl
                add     ds:[score],ax
                push    ds
                call    show_score
                test    ds:[curr_flags],soundflag
                jz      ohi_beep
                call    beep
ohi_beep:       pop     ds
                mov     ax,ds:[rows]
                xor     ah,ah
                mov     bl,10
                div     bl
                cmp     al,9
                jbe     level_ok
                mov     al,9
level_ok:
                cmp     ds:[level],al
                jae     suuremp_level
                mov     ds:[level],al
                mov     bl,3
                mul     bl
                mov     bl,4+9*3
                sub     bl,al
                mov     ds:[speed],bl
                dec     bl
                mov     ds:[timer],bl
                call    show_score
                test    ds:[curr_flags],soundflag
                jz      ohi_beep2
                call    beep2
ohi_beep2:
suuremp_level:

pois:           xor     al,al
                ret
cl_yepp:        mov     al,1h
                ret
beep:           push    ax
                push    cx
                push    dx
                mov     al,0b6h         ;10110110
                out     043h,al
                mov     al,0cch
                out     042h,al
                mov     al,00ch
                out     042h,al         ;???/2 Hz
                in      al,061h
                or      al,3h
                out     061h,al         ;speaker on
                call    beep_timer
                mov     al,066h
                out     042h,al
                mov     al,006h
                out     042h,al         ;??? Hz
                call    beep_timer
                in      al,061h
                and     al,0ffh-3h
                out     061h,al         ;speaker off
                pop     dx
                pop     cx
                pop     ax
                ret
beep2:          push    ax
                push    cx
                push    dx
                mov     al,0b6h         ;10110110
                out     043h,al
                mov     al,044h
                out     042h,al
                mov     al,004h
                out     042h,al         ;???/2 Hz
                in      al,061h
                or      al,3h
                out     061h,al         ;speaker on
                call    beep_timer2
                mov     al,088h
                out     042h,al
                mov     al,008h
                out     042h,al         ;??? Hz
                call    beep_timer2
                in      al,061h
                and     al,0ffh-3h
                out     061h,al         ;speaker off
                pop     dx
                pop     cx
                pop     ax
                ret
beep_timer2:    mov     cx,3
                jmp     bapp
beep_timer:     mov     cx,1
bapp:           mov     dx,3DAh
beep_l:         in      al,dx
                test    al,8
                jz      beep_l
beep_l_2:       in      al,dx
                test    al,8
                jnz     beep_l_2
                loop    beep_l
                ret
show_score:     mov     dx,dseg
                mov     ds,dx
                mov     si,offset empty_buf
                mov     ax,263
                mov     bx,28
                call    center_text
                mov     si,offset empty_buf
                mov     ax,263
                mov     bx,72
                call    center_text
                mov     si,offset empty_buf
                mov     ax,263
                mov     bx,116
                call    center_text
                mov     ax,ds:[rows]
                mov     byte ptr ds:[converter],230
                call    conv_int
                mov     si,di
                mov     ax,263
                mov     bx,72
                call    center_text
                mov     ax,ds:[score]
                call    conv_int
                mov     si,di
                mov     ax,263
                mov     bx,28
                call    center_text
                xor     ah,ah
                mov     al,ds:[level]
                call    conv_int
                mov     si,di
                mov     ax,263
                mov     bx,116
                call    center_text
                ret
                endp

conv_int        proc    near
                lea     di,int_conv_buf+5
                mov     bx,10
                mov     cx,6
                mov     dx,0
si_l:           div     bx
                add     dl,byte ptr ds:[converter]
                mov     byte ptr ds:[di],dl
                mov     dx,0
                dec     di
                loop    si_l
                mov     al,byte ptr ds:[converter]
si_l2:          inc     di
                cmp     byte ptr ds:[di],al
                jnz     si_ok
                cmp     di,offset int_conv_buf+5
                jb      si_l2
si_ok:          ret
                endp
;----------------------------------------------------------------------------

rand            proc    near
                mov     dx,seg dseg
                mov     ds,dx
                mov     ax,ds:[random_seed]
                add     ax,55555
                xor     ax,0eeeeh

                mov     ds:[random_seed],ax
                xor     ah,ah
                div     bl
                shr     ax,8
                ret
                endp

arvo_next_piece proc    near

                call    clr_next

                mov     ax,ds:[next_piece]
                mov     ds:[current_piece],ax
                mov     ax,ds:[next_angle]
                mov     ds:[current_angle],ax
                mov     bl,ds:[number_of_pieces]
                call    rand
                cmp     ds:[current_piece],ax
                jnz     ooki
                mov     bl,ds:[number_of_pieces]
                call    rand
ooki:           mov     ds:[next_piece],ax
                mov     bl,4
                call    rand
                mov     ds:[next_angle],ax

                call    draw_next
                ret
                endp

draw_next       proc    near
                test    ds:[curr_flags],nextflag
                jz      ohize
                push    ds
                mov     cx,ds:[next_piece]
                mov     dx,ds:[next_angle]
                mov     bx,cx
                sal     bx,3
                add     bx,dx
                add     bx,dx
                mov     bx,ds:[koordit+BX]
                call    put_put
                pop     ds
ohize:          ret
                endp

clr_next        proc    near
                push    ds
                mov     cx,ds:[next_piece]
                mov     dx,ds:[next_angle]
                mov     bx,cx
                sal     bx,3
                add     bx,dx
                add     bx,dx
                mov     bx,ds:[koordit+BX]
                call    clr_clr
                pop     ds
                ret
                endp
;----------------------------------------------------------------------------

read_highscores proc    near
                call    hscrypt

                mov     ax,3d00h
                mov     dx,seg highscore_filename
                mov     ds,dx
                mov     dx,offset highscore_filename
                int     21h
                jc      rb_ohi

                mov     dx,seg dseg
                mov     ds,dx
                mov     ds:[data_handle],ax
                mov     bx,ax
                mov     cx,43*22
                mov     dx,seg hstab_a
                mov     ds,dx
                mov     dx,offset hstab_a
                mov     ah,3fh
                int     21h

                mov     bx,ds:[data_handle]
                mov     ah,3eh
                int     21h
rb_ohi:
                call    hscrypt
                ret
                endp

write_highscores proc    near
                call    hscrypt
                mov     ax,3c00h
                mov     dx,seg highscore_filename
                mov     ds,dx
                mov     dx,offset highscore_filename
                int     21h
                jc      wb_ohi

                mov     dx,seg dseg
                mov     ds,dx
                mov     ds:[data_handle],ax
                mov     bx,ax
                mov     cx,43*22
                mov     dx,seg hstab_a
                mov     ds,dx
                mov     dx,offset hstab_a
                mov     ah,40h
                int     21h

                mov     bx,ds:[data_handle]
                mov     ah,3eh
                int     21h
wb_ohi:
                call    hscrypt
                ret
                endp

hscrypt         proc    near

                pusha

                mov     dx,seg hstab_a
                mov     es,dx
                mov     di,offset hstab_a

                mov     cx,22*43
hscrypt_loop:   xor     es:[di],cl
                inc     di
                loop    hscrypt_loop

                popa

                ret
                endp

read_setup      proc    near
                mov     ax,3d00h
                mov     dx,seg setup_filename
                mov     ds,dx
                mov     dx,offset setup_filename
                int     21h
                jc      rbs_ohi

                mov     dx,seg dseg
                mov     ds,dx
                mov     ds:[data_handle],ax
                mov     bx,ax
                mov     cx,17
                mov     dx,seg flags
                mov     ds,dx
                mov     dx,offset flags
                mov     ah,3fh
                int     21h

                mov     bx,ds:[data_handle]
                mov     ah,3eh
                int     21h
rbs_ohi:
                ret
                endp

write_setup     proc    near
                mov     ax,3c00h
                mov     dx,seg setup_filename
                mov     ds,dx
                mov     dx,offset setup_filename
                int     21h
                jc      wbs_ohi

                mov     dx,seg dseg
                mov     ds,dx
                mov     ds:[data_handle],ax
                mov     bx,ax
                mov     cx,17
                mov     dx,seg flags
                mov     ds,dx
                mov     dx,offset flags
                mov     ah,40h
                int     21h

                mov     bx,ds:[data_handle]
                mov     ah,3eh
                int     21h

wbs_ohi:
                ret
                endp

;----------------------------------------------------------------------------

put_block       proc    near

                push    dx
                push    ax

                mov     dx,seg palat
                mov     ds,dx
                mov     si,offset palat
                and     ax,7
                add     si,ax           ;ax=block number
                sal     ax,3
                add     si,ax

                mov     dx,0a000h
                mov     es,dx
                mov     di,bx           ;bx=x+y*320

                mov     cx,9
                rep     movsb
                add     si,63
                add     di,311
                mov     cx,9
                rep     movsb
                add     si,63
                add     di,311
                mov     cx,9
                rep     movsb
                add     si,63
                add     di,311
                mov     cx,9
                rep     movsb
                add     si,63
                add     di,311
                mov     cx,9
                rep     movsb
                add     si,63
                add     di,311
                mov     cx,9
                rep     movsb
                add     si,63
                add     di,311
                mov     cx,9
                rep     movsb
                add     si,63
                add     di,311
                mov     cx,9
                rep     movsb
                pop     ax
                pop     dx
                ret
                endp

;-----------------------------------------------------------------

clr_block       proc    near

                push    dx

                mov     dx,0a000h
                mov     es,dx
                mov     di,bx           ;bx=x+y*320
                xor     al,al
                mov     cx,9
                rep     stosb
                add     di,311
                mov     cx,9
                rep     stosb
                add     di,311
                mov     cx,9
                rep     stosb
                add     di,311
                mov     cx,9
                rep     stosb
                add     di,311
                mov     cx,9
                rep     stosb
                add     di,311
                mov     cx,9
                rep     stosb
                add     di,311
                mov     cx,9
                rep     stosb
                add     di,311
                mov     cx,9
                rep     stosb
                pop     dx
                ret
                endp

;-----------------------------------------------------------------------

; ax=row
; bx=column
; cx=piece shape (0 - 6)
; dx=angle (0-3)


put_piece       proc    near
                mov     bx,ds:[current_column]
                mov     ax,ds:[current_row]

                mov     cx,320*8
                mul     cx              ;ax=ax*320*8
                add     ax,eka_x
                add     ax,bx
                sal     bx,3
                add     bx,ax

                mov     cx,ds:[current_piece]
                mov     dx,ds:[current_angle]

put_put:        mov     ax,cx
                sal     cx,3                    ;piece number
                sal     dx,1                    ;angle

                add     cx,dx
                mov     si,cx
                mov     dx,seg dseg
                mov     ds,dx
                mov     dx,word ptr ds:paloja[si]

                mov     cx,4

pp_l:           push    cx
                test    dh,080h
                jz      pp_1
                call    put_block
pp_1:           add     bx,9
                test    dh,040h
                jz      pp_2
                call    put_block
pp_2:           add     bx,9
                test    dh,020h
                jz      pp_3
                call    put_block
pp_3:           add     bx,9
                test    dh,010h
                jz      pp_4
                call    put_block
pp_4:           add     bx,320-9*3+320*7
                sal     dx,4
                pop     cx
                loop    pp_l

                ret
                endp

;---------------------------------------------------------------------

clr_piece       proc    near

                mov     bx,ds:[current_column]
                mov     ax,ds:[current_row]

                mov     cx,320*8
                mul     cx              ;ax=ax*320*8
                add     ax,eka_x
                add     ax,bx
                sal     bx,3
                add     bx,ax

                mov     cx,ds:[current_piece]
                mov     dx,ds:[current_angle]

clr_clr:        mov     ax,cx
                sal     cx,3                    ;piece number
                sal     dx,1                    ;angle

                add     cx,dx
                mov     si,cx
                mov     dx,seg dseg
                mov     ds,dx
                mov     dx,word ptr ds:paloja[si]

                mov     cx,4

cp_l:           push    cx
                test    dh,080h
                jz      cp_1
                call    clr_block
cp_1:           add     bx,9
                test    dh,040h
                jz      cp_2
                call    clr_block
cp_2:           add     bx,9
                test    dh,020h
                jz      cp_3
                call    clr_block
cp_3:           add     bx,9
                test    dh,010h
                jz      cp_4
                call    clr_block
cp_4:           add     bx,320-9*3+320*7
                sal     dx,4
                pop     cx
                loop    cp_l
                ret
                endp

;------------------------------------------------------------------------

; ax=row
; bx=column
; cx=piece shape (0 - 6)
; dx=angle (0-3)

test_piece      proc    near

                mov     bx,ds:[current_column]
                mov     ax,ds:[current_row]

                mov     cx,320*8
                mul     cx              ;ax=ax*320*8
                add     ax,eka_x
                add     ax,bx
                sal     bx,3
                add     bx,ax

                mov     cx,ds:[current_piece]
                mov     dx,ds:[current_angle]

                mov     ax,cx
                sal     cx,3                    ;piece number
                sal     dx,1                    ;angle

                add     cx,dx
                mov     si,cx
                mov     dx,seg dseg
                mov     ds,dx
                mov     dx,word ptr ds:paloja[si]

                mov     cx,4

                mov     ax,0a000h
                mov     es,ax
                mov     di,bx

tp_l:           test    dh,080h
                jz      tp_1
                mov     bl,es:[di]
                test    bl,0ffh
                jnz     not_zero
tp_1:           add     di,9
                test    dh,040h
                jz      tp_2
                mov     bl,es:[di]
                test    bl,0ffh
                jnz     not_zero
tp_2:           add     di,9
                test    dh,020h
                jz      tp_3
                mov     bl,es:[di]
                test    bl,0ffh
                jnz     not_zero
tp_3:           add     di,9
                test    dh,010h
                jz      tp_4
                mov     bl,es:[di]
                test    bl,0ffh
                jnz     not_zero
tp_4:           add     di,320-9*3+320*7
                sal     dx,4
                loop    tp_l
                xor     al,al
                ret
not_zero:       mov     al,1
                ret

                endp

;-----------------------------------------------------------------------

set_kbhandler   proc    near

                mov     ax,3509h
                int     21h

                mov     dx,seg dseg
                mov     ds,dx
                mov     word ptr ds:[old_kb_seg],es
                mov     word ptr ds:[old_kb_off],bx

                mov     dx,seg oma_kb_int
                mov     ds,dx
                mov     dx,offset oma_kb_int
                mov     ax,2509h
                int     21h

                ret
                endp

remove_kbhandler proc   near

                mov     dx,seg dseg
                mov     es,dx
                mov     ds,word ptr es:[old_kb_seg]
                mov     dx,word ptr es:[old_kb_off]
                mov     ax,2509h
                int     21h

                ret
                endp

                ends

intit           segment para public use16 'CODE2'
                assume  cs:intit

oma_kb_int      proc    far

                push    es
                push    ds
                push    ax
                push    bx

                mov     bx,seg dseg
                mov     ds,bx
                mov     bx,40h
                mov     es,bx

                in      al,060h         ; get key code
                push    ax              ; save it
                in      al,061h         ; get current control
                mov     ah,al           ; save PB control
                or      al,80h          ; set keyboard bit
                out     061h,al         ; keyboard acknowledge
                xchg    ah,al           ; get back PB
                out     061h,al         ; reset PB control

                pop     ax              ; get back code

                xor     ah,ah
                test    ds:[flags],lshiftflag+rshiftflag
                jz      ei_lsifti
                mov     ah,1
ei_lsifti:

                test    ax,80h
                jnz     eieieieiei      ;depressions not saved
                inc     ds:[random_seed]
                mov     word ptr ds:[keycode],ax
eieieieiei:

                cmp     al,2ah          ;left shift
                jnz     eieieilshift
                or      ds:[flags],lshiftflag
eieieilshift:
                cmp     al,36h          ;right shift
                jnz     eieieirshift
                or      ds:[flags],rshiftflag
eieieirshift:
                cmp     al,0aah          ;left shift dep
                jnz     eieieilshiftd
                and     ds:[flags],-1-lshiftflag
eieieilshiftd:
                cmp     al,0b6h          ;right shift dep
                jnz     eieieirshiftd
                and     ds:[flags],-1-rshiftflag
eieieirshiftd:

                cli
                mov     al,20h
                out     20h,al          ; send eoi to interrupt controller
                pop     bx
                pop     ax
                pop     ds
                pop     es
                iret

                endp
                ends

;--------------------------------------------------------------------------

                end
