

.model small
.stack 100H
.data

;for menu screen
levelstr1 byte 'L',1Fh,'E',1Fh,'V',1Fh,'E',1Fh,'L',1Fh,'1',1Fh
levelstr2 byte 'L',1Fh,'E',1Fh,'V',1Fh,'E',1Fh,'L',1Fh,'2',1Fh
levelstr3 byte 'L',1Fh,'E',1Fh,'V',1Fh,'E',1Fh,'L',1Fh,'3',1Fh
Mario byte 'S',1Fh,'U',1Fh,'P',1Fh,'E',1Fh,'R',1Fh,' ',1Fh,'M',1Fh,'A',1Fh,'R',1Fh,'I',1Fh,'0',1Fh
menu1 byte 'P',1Fh,'R',1Fh,'E',1Fh,'S',1Fh,'S',1Fh,' ',1Fh,'A',1Fh,'N',1Fh,'Y',1Fh,' ',1Fh,'K',1Fh,'E',1Fh,'Y',1Fh,' ',1Fh,'T',1Fh,'O',1Fh,' ',1Fh,'C',1Fh,'O',1Fh,'N',1Fh,'T',1Fh,'I',1Fh
stmenu byte 'P',1Fh,'R',1Fh,'E',1Fh,'S',1Fh,'S',1Fh,' ',1Fh,'E',1Fh,'N',1Fh,'T',1Fh,'E',1Fh,'R',1Fh,' ',1Fh,'T',1Fh,'O',1Fh,' ',1Fh,'C',1Fh,'O',1Fh,'N',1Fh,'T',1Fh,'I',1Fh,'N',1Fh,'U',1Fh,'E',1Fh
userndp db 'E',1Fh,'N',1Fh,'T',1Fh,'E',1Fh,'R',1Fh,' ',1Fh,'U',1Fh,'S',1Fh,'E',1Fh,'R',1Fh,' ',1Fh,'N',1Fh,'A',1Fh,'M',1Fh,'E',1Fh,' ',1fh,':',1Fh
usernam db 20 dup(0)
menu1st2 db 'N',1Fh,'U',1Fh,'E',1Fh
scorestr db 'Y',1Fh,'O',1Fh,'U',1Fh,'R',1Fh,' ',1Fh,'S',1Fh,'C',1Fh,'O',1Fh,'R',1Fh,'E',1Fh,' ',1Fh,'=',1fh
loststr byte 'Y',1Fh,'O',1Fh,'U',1Fh,' ',1Fh,'L',1Fh,'O',1Fh,'S',1Fh,'T',1Fh,' ',1Fh
Welcomestr byte 'W',1Fh,'E',1Fh,'L',1Fh,'C',1Fh,'O',1Fh,'M',1Fh,'E',1Fh
winstr db  'Y',1Fh,'O',1Fh,'U',1Fh,' ',1Fh,'W',1Fh,'I',1Fh,'N',1Fh

score dw 0

; for marios location
x db 0
y db 0
jm db 0
maxh db 20
level dw 1
xc dw 0 ; for cx in enemypix1function
enemytriL dw 0 ;for enemy length in enemypix1function

;for enemy 1 b/w secnd and thrd hurdle
enemytriX dw 0
enemytriY dw 0
xenemy db 0
yenemy db 0

;for enemy 2 b/w frst and scnd hurdle
enemy2triX dw 0
enemy2triY dw 0
xenemy2 db 0
yenemy2 db 0

;for bool checks movement of both enemies
boolen1 dw 0
boolen2 dw 0

;for drawing enemy or not for checking if mario kills them
benm1 dw 0
benm2 dw 0

;for perks
xper1 dw 0
yper1 dw 0
bper1 dw 0
xper2 dw 0
yper2 dw 0
bper2 dw 0
xper3 dw 0
yper3 dw 0
bper3 dw 0

;for man's chk
bman dw 0 


;for bullet in blocks axis
xbl db 0
ybl db 0

;for monster 
xbm db 0
ybm db 0
xpixm dw 0
ypixm dw 0
bolmon dw 0

;for castle 
xcst db 0
;-----------------------------------------DATA SEGMENTED ENDED---------------------------------------------------



;------------------------------------------CODE SEGMENT STARTED-----------------------------------------------

.code

;without pushing and popping same functions cannot be called again
;-------------------------------------------PUSHING REGISTER MACROS------------------------------------
	ToPush macro
		push ax 
		push bx
		push cx
		push dx
		push si
		push di

	endm
;------------------------------------------poping register maco------------------------------------------
	ToPop macro
		pop di
		pop si
		pop dx 
		pop cx
		pop bx
		pop ax
	endm

	;for outputting characters on screen
;------------------------------------------PRINTING MACRO --------------------------------------
	Print macro
		MOV AH,02H		;output intrupt  //set cursor position      dh=10 (row), dl=20(col),  bh=pg no.
		INT 10H

		mov bh,0		;bh=page number		al=charcter to display
		mov cx,1		;cx=n0. of times write

		mov ah,0ah		;//for input   //write chaarcter only at cursor position
		int 10h
	endm

;--------------------------------------------MAIN PROCEDURE-------------------------------------------
main proc

mov ax,@data
mov ds,ax

mov ah,0h	;to set video mode	ah=0 means text mode
mov al,10h	;al=10h graphic mode 	640*200 resolution
int 10h

;nexting::


;Initial Position of Monster
mov xbl,20
mov ybl,1
mov xbm,20
mov ybm,1
mov xpixm,160
mov ypixm,14

;initializers
mov level,1
mov benm1,1
mov benm2,1 
mov bper1,1
mov bper2,1
mov bper3,1
mov bman,1
mov bolmon,1
mov score,48			;0 ascii

;initializer for castle X
mov xcst,70

;Initial position of enemy 1 between 2nd hurdle and third

;Position in pixles
	mov enemytriX , 338 ;(HORIZONTAL)
	mov enemytriY,308 ;(VERTICAL)

;Position in terms of tiles
	mov xenemy,40 ;(Horizontal) ;enemy total width is 4  cells		//1 cell horizontal=10 
	mov yenemy,22 ;(vertical)	;enemy total height is 2 cells		//1 cell vertical=11

;Initial position of enemy 2 between 1st and 2nd hurdle

;Position in pixles
	mov enemy2triX , 186 ;(HORIZONTAL)
	mov enemy2triY,308 ;(VERTICAL)

;Position in terms of tiles
	mov xenemy2,21 ;(horizontal)
	mov yenemy2,22 ;(vertical)

;initial pos of mario in tiles
	mov x,3	
	mov y,21

;to run infinite loop		
mov si,0	
mov cx,0
L0:

	call startscreen
	
	;checking for Enter key press
		mov ah,11h		;check for keystroke in the keyboard buffer// ZF = 1 if keystroke is not available //ZF = 0 if keystroke available
		int 16h
		jnz agn	;if zf not set go to agn
		stbck:
		
loop L0



agn::
mov ah,10h
int 16h
.if ah== 1ch  ;	AH = BIOS scan code.  AL = ASCII character.
jmp strt
.endif
.if si<19
mov usernam[si],al
inc si
mov usernam[si],1fh
inc si
.endif

jmp stbck


strt:
 mov cx,0
 L1:

	call background
	call scoredisplay
	call man
		
	
	.if level >= 2 
		call enemyck ;checks for every enemies,bullets and monster according to the level
		.if benm2 == 1
			
			call Enemy2mov ;displays and moves enemy between hurdle 2 and 1
			
		.endif
		.if benm1 ==1
		
			call Enemy1mov ;displays and moves enemy between hurdle 2 and 3
			
		.endif

		ToPush
		CALL perks ;displays perks in pixels

		ToPop
		call perkchk ;checks for perks if mario eats them or not
		
		.if level >2
		ToPush
		call monsterpix
		ToPop
		call bullet ;fires bullet each time from monsters starting point
		.endif
	.endif

	;mario is killed by any enemy
	.if bman == 0
		jmp exting ;jumps to exiting screen
	.endif
	
	;checking for key press
		mov ah,11h
		int 16h
		jnz ckey
		back::
	call timer
	call doingjump
	
	
	
 loop L1


 ;Infinite loop for exit screen
	jmp noexit
	exting:
	call CLEAR
	mov cx ,0
	L2:
		call lostscreen

		;checking for key press
		mov ah,11h
		int 16h
		jnz ext




	loop L2
	leveling::
	;freeing buffer to ensure level changing screen appears
		mov ah,10h
		int 16h
	call CLEAR
	mov cx ,0
	L3:
		call screen

		;checking for key press
		mov ah,11h
		int 16h
		jnz bck
		bbck:
		call timer
	loop L3
	bck:
	mov ah,10h
	int 16h
	cmp ah,1ch
	jne bbck
	je back
	;for winning screen
	WNNG::
	call CLEAR
	mov cx ,0
	L4:
	call winingscreen

		;checking for key press
		mov ah,11h
		int 16h
		jnz ext



	loop L4

	noexit:



 ckey::

;//////////freeing buffer to check the key pressed during game execution///////
mov ah,10h
int 16h

;chk right key
	cmp ah,4dh
 	jne n1

 	.if x==76 && level ==1
	; level check and placing mario back to initial position
	mov x,3
	mov y,21
	mov benm1,1
	mov benm2,1 
	mov bper1,1
	mov bper2,1
	mov bper3,1
	mov level,2
	inc score
	jmp leveling
	.elseif x==76 && level ==2 
	mov x,3
	mov y,21
	mov benm1,1
	mov benm2,1 
	mov bper1,1
	mov bper2,1
	mov bper3,1
	mov level,3
	jmp leveling
	.elseif x==76 && level ==3 
	jmp WNNG
	.endif
	

	
	



	;///////Checking Hurdles///////
	;First Hurdle
	mov bh,x
	mov bl,y

	;FirstHurdle Check
	cmp bh,14 ;x for one sides length
		jge nst
		
	jmp ov
	nst:
	cmp bh,15 ;x of other hand to restrict movment for only pillars length
		jle nst2
		
	ov:
	jmp ov1
	nst2:
	cmp bl,15 ;y for height
		;jl skp3
		jge back
	ov1:



	;Second Hurdle Check
	
	scnd:
	cmp bh,34 ;x for one sides length
		jge nst3
		
	jmp ovr
	nst3:
	cmp bh,35 ;x of other hand to restrict movment for only pillars length
		jle nxt
		
	ovr:
	jmp ovr1
	nxt:
	cmp bl,14  ;y for height
		jge back
	ovr1:
	skp:

	

	;Third Hurdle Check

	cmp bh,55 ;x for one sides length
		jge nst4
		
	jmp ovv
	nst4:
	cmp bh,56 ;x of other hand to restrict movment for only pillars length
		jle nst5
		
	ovv:
	jmp ovrr1
	nst5:
	cmp bl,12 ;y for height
		;jl skp3
		jge back
	ovrr1:




	skp3:


 mov al,x
 add ax,1
 mov x,al
 jmp back
 

 ;checking left key
	 n1:
 		cmp x,2
 		je back
 		cmp ah,4bh
		 jne n2
	
		mov bh,x
		mov bl,y
	;FirstHurdle Check
		cmp bh,24 ;x for one sides length
		jl nsst	
		jmp oov

	nsst:
		cmp bh,21 ;x of other hand to restrict movment for only pillars length
		jge nsst2
		
	oov:
		jmp oov1

	nsst2:
		cmp bl,15 ;y for height
		;jl skp3
		jge back

	oov1:
	;SecondHurdle Check
		cmp bh,44 ;x for one sides length
		jl nsst1	
		jmp ooov1

	nsst1:
		cmp bh,39 ;x of other hand to restrict movment for only pillars length
		jge nsst3
		
	ooov1:
		jmp oov2

	nsst3:
		cmp bl,14 ;y for height
		;jl skp3
		jge back

	;ThirdHurdle Check
	oov2:
		cmp bh,65 ;x for one sides length
		jl nt1	
		jmp v1

	nt1:
		cmp bh,64 			;x of other hand to restrict movment for only pillars length
		jge nt3
		
	v1:
	jmp v2

	nt3:
		cmp bl,12 ;y for height
		;jl skp3
		jge back

	v2:
		 mov al,x
		 sub al,1
		 mov x,al
 		jmp back

 ;checking up key
	n2:
 		cmp ah,48h
 		jne back
 		cmp y, 0
 		je back
 		mov jm,1
 		mov bh,y

 mov maxh,bh
 sub maxh,14
 jmp back
 
	EXt::
	.exit
main endp				;endp????

;------------------------------------------------CLEAR SCREEN PROC-------------------------------------------------	
CLEAR PROC USES ax cx dx bx si di
mov ah,0h
mov al,10h
int 10h
ret
CLEAR ENDP

;-------------------------------------------GRAVITU ADJUSTMENT PROCEDURE-------------------------------------
comedown proc uses ax bx cx dx 
	cmp y,21
	jge rt
	;First Hurdle	
	mov bh,x
	mov bl,y
	mov dh,x
	sub dh,2
	add bh,3
	.if bh>=15 && dh<=23 && y==14
		jmp rt
	.endif
	;Second Hurdle
	.if bh>=35 && dh<=43 && y==13
		jmp rt
	.endif

	;Third Hurdle

	.if bh>=56 && dh<=64 && y==11
		jmp rt
	.endif
	
	inc y
	rt:
	; checking if enemy1 is killed or not
	mov bh,y
	add bh,3
	mov bl , xenemy
	mov dl,xenemy
	add bl,4
	.if bh == yenemy && x >= dl && x <= bl
		mov benm1,0 
		inc score
	.endif

	;checking enemy2 is killed or not
	mov bh,y
	add bh,3
	mov bl , xenemy2
	mov dl,xenemy2
	add bl,4
	.if bh==yenemy2 && x >= dl && x <= bl
		mov benm2,0
		inc score
	.endif
	

	ret 
comedown endp

;----------------------------------------JUMPING PROC---------------------------------------------
doingjump proc uses ax bx cx dx
	;check for screen check
	cmp y,0
	je ex


	;checking if jump is initiated or not
	cmp jm,1
	jne ex
		mov dl,x
		add dl,3
	;for stopping mario to surpass jump from hurdles from left side of hurdles  
		;first
	.if dl>=15 && dl<=18 
		.if y==20
			jmp ex
		.endif
	.endif
		;second
	.if dl>=35 && dl<=43 
		.if y==19
			jmp ex
		.endif
	.endif
		;third
	.if dl>=56 && dl<=64 
		.if y==17
			jmp ex
		.endif
	.endif

		mov dl,x
		sub dl,2
	;for stopping mario to surpass jump from hurdles from right side of hurdles  
		;first
	.if dl>=15 && dl<=23 
		.if y==20
			jmp ex
		.endif
	.endif
		;second
	.if dl>=35 && dl<=43 
		.if y==19
			jmp ex
		.endif
	.endif
		;third
	.if dl>=56 && dl<=64 
		.if y==17
			jmp ex
		.endif
	.endif



	;comparing for maximum jump val in maxh
		mov bh,maxh
		cmp y,bh
		je ex	 
		

		dec y
	
	
	ret

	ex:	
	call comedown
	mov jm,0
	
	
	ret 
	doingjump endp

;--------------------------------------------------TIMER PROC---------------------------------------------
timer proc uses ax cx dx bx si di 
mov cx,0h
mov dx,0ffffH
mov ah,86h
int 15h
ret 
timer endp

; ---------------------------------------Background AAND HURDLE DESIGN PROCEDURE----------------------------------
background proc uses cx dx ax bx


	;Background
		mov ah,6			;scroll window settings
		mov al,0			;al=no. of lines
		mov cl,0 ;col		;cl=col of windows' upper left corner
		mov ch,0 ;row		;ch=row of windows' upper left corner
		mov dl,79 ;col		;dl=col of windows' lower right corner
		mov dh,24 ;row		;dh=row of windows' lower right corner
		mov bh,14			;attribute used to write blank lines at bottom of window.
		int 10h
 

	;First Hurdle Top

		mov ah,6
		mov al,0
		mov cl,15 ;col	
		mov ch,18 ;rownhy
		mov dl,23 ;col
		mov dh,19 ;row
		mov bh,7
		int 10h
 
	;First Hurdle stick

	mov ah,6
	mov al,0
	mov cl,18 ;col
	mov ch,19 ;row
	mov dl,20 ;col
	mov dh,24 ;row
	mov bh,4
	int 10h

	;Second Hurdle top
	mov ah,6
	mov al,0
	mov cl,35 ;col
	mov ch,17 ;row
	mov dl,43 ;col
	mov dh,18 ;row
	mov bh,7
	int 10h
 
	;second Hurdle stick

	mov ah,6
	mov al,0
	mov cl,38 ;col
	mov ch,18 ;row
	mov dl,40 ;col	
	mov dh,24 ;row
	mov bh,4
	int 10h

	;Third Hurdle top

	mov ah,6
	mov al,0
	mov cl,56 ;col
	mov ch,15 ;row
	mov dl,64 ;col
	mov dh,16 ;row
	mov bh,7
	int 10h
	
;Third Hurdle stick

	mov ah,6
	mov al,0
	mov cl,59 ;col
	mov ch,16 ;row
	mov dl,61 ;col
	mov dh,24 ;row
	mov bh,4
	int 10h

.if level <3
	;Flag 

	;Flag Stick
	mov ah,6
	mov al,0
	mov cl,77 ;col
	mov ch,3 ;row
	mov dl,78 ;col
	mov dh,24 ;row
	mov bh,15
	int 10h

	;Flag
	mov ah,6
	mov al,0
	mov cl,66 ;col st
	mov ch,3 ;row st
	mov dl,76 ;col end
	mov dh,7 ;row end
	mov bh,10
	int 10h
.elseif level ==3
	call castle
.endif
	;call castle
	ret
	background endp


;----------------------------------------------MARIO DESIGNING---------------------------------------------
man proc uses ax bx cx dx 
	
	;height of man = 3 from head
	;total width == 4
	;head starting reference x is -3 ,x-1 is left hand and x+3 is right hand

	mov cl,x ;x=3
	mov ch,y ;y=21
 ;Head
	mov ah,6
	mov al,0
	mov cl,x ;col st
	mov ch,y ;row st
	mov dl,x ;col end
	inc dl
	mov dh,y ;row end
	inc dh
	mov bh,7
	int 10h

	;Mid
	mov ah,6
	mov al,0
	mov cl,x ;col st
	dec cl
	mov ch,y ;row st
	inc ch
	mov dl,x ;col end
	add dl,2
	mov dh,y ;row end
	add dh,2
	mov bh,5
	int 10h

	;First Leg
	mov ah,6
	mov al,0
	mov cl,x ;col st
	dec cl
	mov ch,y ;row st
	add ch,3
	mov dl,x ;col end
	dec dl
	mov dh,y ;row end
	add dh,3
	mov bh,5
	int 10h

	;Second Leg
	mov ah,6
	mov al,0
	mov cl,x ;col st
	add cl,2
	mov ch,y ;row st
	add ch,3
	mov dl,x ;col end
	add dl,2
	mov dh,y ;row end
	add dh,3
	mov bh,5
	int 10h


	;first Hand
	mov dl,20   ; y coordinate
	mov ax,' '  ;character
	mov bl,1111b
	print
	mov dh,y    ; y coordinate
	inc dh
	mov dl,x   ; x coordinate
	sub dl,2
	mov ax,'/'  ;character
	mov bl,1111b
	print

;second hand
	mov dh,y   ; y coordinate
	inc dh
	mov dl,x   ; x coordinate
	add dl,3
	mov ax,'\'  ;character
	mov bl,1111b
	print
	
	; is parcham k saye talay ham ek hain, ham ek hain


	.if level <3
		mov dh,5   ; y coordinate
	
		mov dl,71   ; x coordinate
	
		mov ax,'*'  ;character
		mov bl,1111b
		print

		mov dh,5   ; y coordinate
	
		mov dl,72   ; x coordinate
	
		mov ax,')'  ;character
		mov bl,1111b
		print

	.endif

	ret
	man endp
;----------------------------------------------ENEMY 1 DESIGN------------------------------------------
Enemypix1 proc uses ax bx cx dx si di

	;Saving enemy's x and y axis that is being changed inside function for different drawings
	
		push enemytriX
		push enemytriY

	; for drawing other parts saving initial terms
	push enemytriY 
	push enemytriX

	mov enemytriL ,1

	;enemy Triangle

	mov cx,7
	L1:
   		mov xc,cx
   		mov dx,enemytriY ;y axis(vertical)
   		mov cx,4 ;length(vertical)
   	ll26:
   		mov si,cx
   		mov cx,enemytriL ;breadth(horizontal)
   	ll27:
     	add cx,enemytriX ;x axis(horizontal)
     	mov al,1101b
     	mov bh,0
     	mov ah,0CH
     	int 10h
     	sub cx,enemytriX
   	loop ll27
   	inc dx
   	mov cx,si
   	loop ll26
	mov cx,xc
	add enemytriY,4
	sub enemytriX,3
	add enemytriL,6

	loop L1


	;Enemy legs


	pop enemytriX
	push enemytriX
	add  enemytriX,4
	mov  enemytriL,3
	mov cx,2
	L2:
   mov xc,cx
   mov dx,enemytriY ;y axis(vertical)
   mov cx,14 ;length(vertical)
   l26:
   mov si,cx
   mov cx,enemytriL ;breadth(horizontal)
   l27:
     add cx,enemytriX ;x axis(horizontal)
     mov al,1101b
     mov bh,0
     mov ah,0CH
     int 10h
     sub cx,enemytriX
   loop l27
   inc dx
   mov cx,si
   loop l26
   mov cx,xc
	sub  enemytriX,10
	loop L2

	;Enemy Eyes
	pop enemytriX
	pop enemytriY

	add enemytriX,4
	add enemytriY,12
	mov  enemytriL,2
	mov cx,2
	L3:
   mov xc,cx
   mov dx,enemytriY ;y axis(vertical)
   mov cx,6 ;length(vertical)
   l6:
   mov si,cx
   mov cx,enemytriL ;breadth(horizontal)
   l7:
     add cx,enemytriX ;x axis(horizontal)
     mov al,0000b
     mov bh,0
     mov ah,0CH
     int 10h
     sub cx,enemytriX
   loop l7
   inc dx
   mov cx,si
   loop l6

   mov cx,xc
	sub enemytriX,8
	loop L3


	;Restoring the initial pos at start of the function
	pop  enemytriY
	pop enemytriX

	ret 
	Enemypix1 endp

;--------------------------------------------MOVEMENT OF ENEMY 1-----------------------------------------
Enemy1mov proc uses ax bx cx dx si di

	ToPush
	call Enemypix1
	ToPop
	
	
	mov bh,xenemy
	;56 and 40 are the hardcoded values for the ending value of hurdle 2 and hurdle 
	 
	cmp bh,54 ;xenemy for third Hurdle check adjusted -2 for the enemy to start moving towards other side perfectly
		jne nt
		mov boolen1,2 ; works as boolen to check in condition on which side to move
	nt:
	cmp bh,41
		jne nt1
		mov boolen1,1

	
	nt1:
	cmp bh,54 ; this condition is always true in between the hurdles
		jl nt3
		
	
	nt3:
	cmp boolen1,1 ;Most significant boolean check to know wether to move right or left
		je c3

	
	cmp bh,41 ;comparing 1 grater box to check it breaks before 39
		jg nc
	
	jmp c3
	nc:
	cmp boolen1,2
	je dc

	;for right movement	
	c3:
	add enemytriX,8 
	inc xenemy
	jmp rt
	; for left movement
	dc:
	sub enemytriX,8 
	dec xenemy



	rt:
	ret
	Enemy1mov endp
	;-------------------------------------enemy2 deisgn-----------------------------------------------
Enemypix2 proc uses ax bx cx dx si di

	;Saving enemy's x and y axis that is being changed inside function for different drawings
	
	push enemy2triX
	push enemy2triY

	; for drawing other parts saving initial terms
	push enemy2triY 
	push enemy2triX

	mov enemytriL ,1

	;enemy Triangle

	mov cx,7
	L1:
   mov xc,cx
   mov dx,enemy2triY ;y axis(vertical)
   mov cx,4 ;length(vertical)
   ll26:
   mov si,cx
   mov cx,enemytriL ;breadth(horizontal)
   ll27:
     add cx,enemy2triX ;x axis(horizontal)
     mov al,1101b
     mov bh,0
     mov ah,0CH
     int 10h
     sub cx,enemy2triX
   loop ll27
   inc dx
   mov cx,si
   loop ll26
	mov cx,xc
	add enemy2triY,4
	sub enemy2triX,3
	add enemytriL,6

	loop L1


	;Enemy legs


	pop enemy2triX
	push enemy2triX
	add  enemy2triX,4
	mov  enemytriL,3
	mov cx,2
	L2:
   mov xc,cx
   mov dx,enemy2triY ;y axis(vertical)
   mov cx,14 ;length(vertical)
   l26:
   mov si,cx
   mov cx,enemytriL ;breadth(horizontal)
   l27:
     add cx,enemy2triX ;x axis(horizontal)
     mov al,1101b
     mov bh,0
     mov ah,0CH
     int 10h
     sub cx,enemy2triX
   loop l27
   inc dx
   mov cx,si
   loop l26
   mov cx,xc
	sub  enemy2triX,10
	loop L2

	;Enemy Eyes
	pop enemy2triX
	pop enemy2triY

	add enemy2triX,4
	add enemy2triY,12
	mov  enemytriL,2
	mov cx,2
	L3:
   mov xc,cx
   mov dx,enemy2triY ;y axis(vertical)
   mov cx,6 ;length(vertical)
   l6:
   mov si,cx
   mov cx,enemytriL ;breadth(horizontal)
   l7:
     add cx,enemy2triX ;x axis(horizontal)
     mov al,0000b
     mov bh,0
     mov ah,0CH
     int 10h
     sub cx,enemy2triX
   loop l7
   inc dx
   mov cx,si
   loop l6

   mov cx,xc
	sub enemy2triX,8
	loop L3


	;Restoring the initial pos at start of the function
	pop  enemy2triY
	pop enemy2triX


	ret 
	Enemypix2 endp

;--------------------------------MOVEMENT OF ENEMY2 -------------------------------------------------
Enemy2mov proc uses ax bx cx dx si di

	ToPush
	call Enemypix2
	ToPop
	
	mov bh,xenemy2
	;20 and 38 are the hardcoded values for the ending value of hurdle 2 and hurdle 
	 
	cmp bh,33 ;xenemy2 for third Hurdle check adjusted -2 for the enemy to start moving towards other side perfectly
		jne nt
		mov boolen2,2 ; works as boolen to check in condition on which side to move
	nt:
	cmp bh,21
		jne nt1
		mov boolen2,1

	
	nt1:
	cmp bh,33 ; this condition is always true in between the hurdles
		jl nt3
		
	
	nt3:
	cmp boolen2,1 ;Most significant boolean check to know wether to move right or left
		je c3

	
	cmp bh,21 ;comparing 1 grater box to check it breaks before 39
		jg nc
	
	jmp c3
	nc:
	cmp boolen2,2
	je dc

	;for right movement	
		c3:
		add enemy2triX,8 
	inc xenemy2
	jmp rt
	; for left movement
	dc:
	sub enemy2triX,8 
	dec xenemy2

	rt:
	ret 
	Enemy2mov endp 

	;----------------------------------------------------COINS----------------------------------------------------
perks proc uses ax bx cx dx si di
	;perk 1
		;mov ah,6
		;mov al,0
		;mov cl,25 ;col st
		;mov ch,10 ;row st
		;mov dl,31 ;col end
		;mov dh,12 ;row end
		;mov bh,2
		;int 10h
	;perk2 
		;mov ah,6
		;mov al,0
		;mov cl,44 ;col st
		;mov ch,8 ;row st
		;mov dl,51 ;col end
		;mov dh,11 ;row end
		;mov bh,2
		;int 10h
	;perk3
		;mov ah,6
		;mov al,0
		;mov cl,55 ;col st
		;mov ch,17 ;row st
		;mov dl,58 ;col end
		;mov dh,18 ;row end
		;mov bh,2
		;int 10h

	;perk1 by pixel	
	.if bper1 ==1
		mov xper1,212
		mov yper1,140
		mov si,2  ;length(vertical)
		mov di,30   ;breadth(horizontal)
		mov cx,11
		L1:
   			push cx
   			mov dx,yper1 ;y axis(vertical)
   			mov cx,si ;length(vertical)
   			ll26:
   				push cx
   				mov cx,di ;breadth(horizontal)
   				ll27:
     				add cx,xper1 ;x axis(horizontal)
     				mov al,1110b
     				mov bh,0
     				mov ah,0CH
     				int 10h
     				sub cx,xper1
   				loop ll27
   				inc dx
   				pop cx
   			loop ll26
			pop cx
			add Di,2
			sub xper1,1
			add yper1,2
		
		loop L1

	
		mov cx,11
		L:
   			push cx
   			mov dx,yper1 ;y axis(vertical)
   			mov cx,si ;length(vertical)
   			l26:
   				push cx
   				mov cx,di ;breadth(horizontal)
   				l27:
     				add cx,xper1 ;x axis(horizontal)
     				mov al,1110b
     				mov bh,0
     				mov ah,0CH
     				int 10h
     				sub cx,xper1
   				loop l27
   				inc dx
   				pop cx
   			loop l26
			pop cx
			sub Di,2
			add xper1,1
			add yper1,2
		
		loop L
	.endif
	;Perk 2
	.if bper2 ==1
	mov xper2,366
	mov yper2,112
	mov si,2  ;length(vertical)
	mov di,38   ;breadth(horizontal)
	mov cx,14
	L01:
   		push cx
   		mov dx,yper2 ;y axis(vertical)
   		mov cx,si ;length(vertical)
   		l6:
   			push cx
   			mov cx,di ;breadth(horizontal)
   			l7:
     			add cx,xper2 ;x axis(horizontal)
     			mov al,1110b
     			mov bh,0
     			mov ah,0CH
     			int 10h
     			sub cx,xper2
   			loop l7
   			inc dx
   			pop cx
   		loop l6
		pop cx
		add Di,2
		sub xper2,1
		add yper2,2
		
	loop L01

	
	mov cx,14
	LL:
   		push cx
   		mov dx,yper2 ;y axis(vertical)
   		mov cx,si ;length(vertical)
   		l2:
   			push cx
   			mov cx,di ;breadth(horizontal)
   			l3:
     			add cx,xper2 ;x axis(horizontal)
     			mov al,1110b
     			mov bh,0
     			mov ah,0CH
     			int 10h
     			sub cx,xper2
   			loop l3
   			inc dx
   			pop cx
   		loop l2
		pop cx
		sub Di,2
		add xper2,1
		add yper2,2
		
	loop LL
	.endif


	;perk3 by pixel
	.if bper3 ==1
	mov xper3,448
	mov yper3,238
	mov si,2  ;length(vertical)
	mov di,14  ;breadth(horizontal)
	mov cx,7
	L001:
   		push cx
   		mov dx,yper3 ;y axis(vertical)
   		mov cx,si ;length(vertical)
   		l60:
   			push cx
   			mov cx,di ;breadth(horizontal)
   			l70:
     			add cx,xper3 ;x axis(horizontal)
     			mov al,1110b
     			mov bh,0
     			mov ah,0CH
     			int 10h
     			sub cx,xper3
   			loop l70
   			inc dx
   			pop cx
   		loop l60
		pop cx
		add Di,2
		sub xper3,1
		add yper3,2
		
	loop L001

	
	mov cx,7
	LLl:
   		push cx
   		mov dx,yper3 ;y axis(vertical)
   		mov cx,si ;length(vertical)
   		ll2:
   			push cx
   			mov cx,di ;breadth(horizontal)
   			ll3:
     			add cx,xper3 ;x axis(horizontal)
     			mov al,1110b
     			mov bh,0
     			mov ah,0CH
     			int 10h
     			sub cx,xper3
   			loop ll3
   			inc dx
   			pop cx
   		loop ll2
		pop cx
		sub Di,2
		add xper3,1
		add yper3,2
		
	loop LLl
	.endif


ret 
perks endp
;-------------------------------------------POINTS COLLECT PROC-------------------------------------------
perkchk proc uses ax bx cx dx si di

	;for first coin check
		mov bh,y
		add bh,3
		mov bl,x
		add bl,3
		.if bl>=25 && bl<=31 && bh >= 10  && y <= 12 
			.if bper1 == 1 && score <58
				inc score
			.endif
			mov bper1,0
		
		.elseif x>=25 && x<=31 && y <= 12  && bh >= 10
			.if bper1 == 1 && score <58
				inc score
			.endif
			mov bper1,0
			
		
		.elseif y<=12 && y>=10 && bl >= 25 && bl <= 31
			.if bper1 == 1 && score <58
				inc score
			.endif
			mov bper1,0
			
		.endif
		mov bl,x
		sub bl,2
		.if y<=12 && y>=10 && bl <= 31 && bl>=25
			.if bper1 == 1 && score <58
				inc score
			.endif
			mov bper1,0
			
		.endif

	;for secnd coin
		mov bh,y
		add bh,3
		mov bl,x
		add bl,3
		.if bl>=44 && bl<=51 && bh >= 8  && y <= 11 
			.if bper2 == 1 && score <58
				inc score
			.endif
			mov bper2,0
			
		
		.elseif x>=44 && x<=51 && y <= 11  && bh >= 8
			.if bper2 == 1 && score <58
				inc score
			.endif
			mov bper2,0
		
		
		.elseif y<=11 && y>=8 && bl >= 44 && bl <= 51
			.if bper2 == 1 && score <58
				inc score
			.endif
			mov bper2,0
			
		.endif
		mov bl,x
		sub bl,2
		.if y<=11 && y>=8 && bl <= 51 && bl>=44
			.if bper2 == 1 && score <58
				inc score
			.endif
			mov bper2,0
			
		.endif

	;fpr third coin
		mov bh,y
		add bh,3
		mov bl,x
		add bl,3
		.if bl>=55 && bl<=58 && bh >= 17  && y <= 18 
			.if bper3 == 1 && score <58
				inc score
			.endif
			mov bper3,0
			
		.elseif x>=55 && x<=58 && y <= 18  && bh >= 17
			.if bper3 == 1 && score <58
				inc score
			.endif
			mov bper3,0
			
		.elseif y<=18 && y>=17 && bl >= 55 && bl <= 58
			.if bper3 == 1 && score <58
				inc score
			.endif
			mov bper3,0
			
		.endif
		mov bl,x
		sub bl,2
		.if y<=18 && y>=17 && bl <= 55 && bl>=58
			.if bper3 == 1 && score <58
				inc score
			.endif
			mov bper3,0
			
		.endif

ret
perkchk endp
;-------------------------------------------DEATH HANDLING PROC-----------------------------------------------
enemyck proc uses ax bx cx dx si di

;Checking enemy1 for death of mario check beween 2 qnd 3rd hurdle
	mov bh, xenemy ;xenemy
	mov bl,x
	mov dl, x
	mov ah,x ;x
	mov dh, xenemy
	add bl,3 ;x+3
	sub dl,1 ;x-1	
	add dh,4 ;xenemy+4, bh= xenemy
	.if level >=2 && benm1 == 1
	.if y >= 21 
		.if  bh <= bl && bh >= x 
			mov bman,0
		.endif
		.if dh>=x && dh<= bl
			mov bman,0
		.endif
		
	.endif
	.endif

;Checking enemy2 for death of mario check beween 1 qnd 2nd hurdle

	mov bh, xenemy2 ;xenemy
	mov dh, xenemy2
	add dh,4 ;xenemy+4, 
	.if level >=2 && benm2 == 1
	.if y >= 21 
		.if  bh <= bl && bh >= x 
			mov bman,0
		.endif
		.if dh>=x && dh<= bl
			mov bman,0
		.endif
		
	.endif
	.endif

.if level >2

;Checking bullet hit
	mov bh,y ;bh= y+3
	add bh,3
	mov bl,y ;bh=y
	mov dh,x ;dh = x+4
	mov dl,x ;dl = x-2
	sub dl,2
	add dh,4
		.if ybl> bl && ybl< bh
		.if  xbl <=dh && xbl>=dl
			mov bman,0
		.endif
		
	.endif

; Checking Monster hit
	mov ah,ybm
	mov al,ybm	;ybm+4 low point
	mov ch,xbm	
	mov cl,xbm	;xbm+10 high point
	add al,4
	add cl,9
	mov dl,x ;dl = x+3
		.if  dl>xbm && dl <= cl && y< al 
			mov bman,0
		.endif
		
		.if dh< cl && dh>= xbm && y< al
			mov bman,0
		.endif

	
.endif

	ret
enemyck endp

;-----------------------------------------MONSTER PROC---------------------------------------------------
monsterpix proc uses ax bx cx dx si di 
	
		
		mov ah,6
		mov al,0
		mov cl,xbm;col st
		mov ch,ybm ;row st
		mov dl,xbm ;col end
		add dl,9
		mov dh,ybm;row end
		add dh,4
		mov bh,7
		int 10h


		mov ah,6
		mov al,0
		mov cl,xbm;col st
		add cl,2
		mov ch,ybm ;row st
		add ch,3
		mov dl,xbm ;col end
		add dl,5
		mov dh,ybm;row end
		add dh,4
		mov bh,4
		int 10h



		mov ah,6
		mov al,0
		mov cl,xbm;col st
		add cl,3
		mov ch,ybm ;row st
		add ch,4
		mov dl,xbm ;col end
		add dl,4
		mov dh,ybm;row end
		add dh,4
		mov bh,14
		int 10h
;
		mov ah,6
		mov al,0
		mov cl,xbm;col st
		add cl,2
		mov ch,ybm ;row st
		add ch,1
		mov dl,xbm ;col end
		add dl,2
		mov dh,ybm;row end
		add dh,1
		mov bh,0
		int 10h


		mov ah,6
		mov al,0
		mov cl,xbm ;col st
		add cl,6
		mov ch,ybm ;row st
		add ch,1
		mov dl,xbm ;col end
		add dl,6
		mov dh,ybm;row end
		add dh,1
		mov bh,0
		int 10h

	
.if bolmon == 1
		add xpixm,8
		inc xbm
		
	.elseif bolmon == 0
		sub xpixm,8
		dec xbm
		
	.endif
	mov bh,xbm
	add bh,9
	.if bh == 79
		mov bolmon,0
	.elseif xbm == 0
		mov bolmon,1
	.endif


ret 
monsterpix endp


;------------------------------------------BULLET PROC--------------------------------------------------
bullet proc uses ax bx cx dx si di 

		mov ah,6
		mov al,0
		mov cl,xbl;col st
		mov ch,ybl ;row st
		mov dl,xbl ;col end
		inc dl
		mov dh,ybl ;row end
		mov bh,2
		int 10h
	.if ybl<= 23
		inc ybl
	.elseif
		mov bh,ybm
		add bh,4
	 	mov ybl,bh
	 	mov bh,xbm
	 	add bh,2
	 	mov xbl,bh
	 .endif
ret 
bullet endp
;------------------------------------------------CASTLE PROC-----------------------------------------------
castle proc uses ax bx cx dx si di 
			
		;lower box
		
		mov ah,6
		mov al,0
		mov cl,65;col st
		mov ch,21 ;row st
		mov dl,80 ;col end
		mov dh,25;row end
		mov bh,7
		int 10h
		;upar wala box
		mov ah,6
		mov al,0
		mov cl,68;col st
		mov ch,16 ;row st
		mov dl,80 ;col end
		mov dh,20;row end
		mov bh,7
		int 10h
		; idr sa small boxex start hoty ha

		mov ah,6
		mov al,0
		mov cl,68;col st
		mov ch,15 ;row st
		mov dl,69;col end
		mov dh,15 ;row end
		mov bh,7
		int 10h


		mov ah,6
		mov al,0
		mov cl,72;col st
		mov ch,15 ;row st
		mov dl,73;col end
		mov dh,15 ;row end
		mov bh,7
		int 10h

		mov ah,6
		mov al,0
		mov cl,75;col st
		mov ch,15 ;row st
		mov dl,76;col end
		mov dh,15 ;row end
		mov bh,7
		int 10h

		mov ah,6
		mov al,0
		mov cl,79;col st
		mov ch,15 ;row st
		mov dl,80;col end
		mov dh,15 ;row end
		mov bh,7
		int 10h
		
		mov ah,6
		mov al,0
		mov cl,65;col st
		mov ch,20 ;row st
		mov dl,66;col end
		mov dh,20 ;row end
		mov bh,7
		int 10h

		;idr sa ab windows bany ge

		; ya wala door ha
		mov ah,6
		mov al,0
		mov cl,72;col st
		mov ch,23 ;row st
		mov dl,75 ;col end
		mov dh,25;row end
		mov bh,4
		int 10h
		
		; idr ma window bana raha hu

		mov ah,6
		mov al,0
		mov cl,70;col st
		mov ch,17 ;row st
		mov dl,72 ;col end
		mov dh,18;row end
		mov bh,4
		int 10h

		mov ah,6
		mov al,0
		mov cl,76;col st
		mov ch,17 ;row st
		mov dl,78 ;col end
		mov dh,18;row end
		mov bh,4
		int 10h
			
ret
castle endp


;-----------------------------------------------display name and level proc---------------------------------

names proc uses	 ax es bx cx dx si di bp

.if level==1
 mov  ax,SEG levelstr1          ; set ES segment
 mov  es,ax 
 mov  ah,13h                       ; write string 
 mov  al,2                         ; write mode 
 mov  bh,0                       ; video page 
 mov  cx,(SIZEOF levelstr1) / 2  ; string length 
 mov  dh,2                      ; start row contains 2 
 mov  dl,39						  ;start column  contains 2
 mov  bp,OFFSET levelstr1       ; string offset 
int  10h 
.endif

.if level==2
mov  ax,SEG levelstr2          ; set ES segment
 mov  es,ax 
 mov  ah,13h                       ; write string 
 mov  al,2                         ; write mode 
 mov  bh,0                       ; video page 
 mov  cx,(SIZEOF levelstr2) / 2  ; string length 
 mov  dh,2                      ; start row contains 2 
 mov  dl,39						  ;start column  contains 2
 mov  bp,OFFSET levelstr2       ; string offset 
int  10h 
.endif


.if level==3
mov  ax,SEG levelstr3          ; set ES segment
 mov  es,ax 
 mov  ah,13h                       ; write string 
 mov  al,2                         ; write mode 
 mov  bh,0                       ; video page 
 mov  cx,(SIZEOF levelstr3) / 2  ; string length 
 mov  dh,2                      ; start row contains 2 
 mov  dl,39						  ;start column  contains 2
 mov  bp,OFFSET levelstr3       ; string offset 
int  10h 
.endif

ret
names endp

;--------------------------------------------display menu proc-------------------------------------------

menu proc uses	 ax bx es cx dx si di bp 

mov  ax,SEG mario          ; set ES segment
 mov  es,ax 
 mov  ah,13h                       ; write string 
 mov  al,2                         ; write mode 
 mov  bh,0                       ; video page 
 mov  cx,(SIZEOF mario) / 2  ; string length 
 mov  dh,10                ; start row contains 2 
 mov  dl,30		  ;start column  contains 2
 mov  bp,OFFSET mario        ; string offset 
int  10h 

mov  ax,SEG stmenu         ; set ES segment
 	mov  es,ax 
 	mov  ah,13h                       ; write string 
 	mov  al,2                         ; write mode 
 	mov  bh,0                       ; video page 
 	mov  cx,(SIZEOF stmenu ) / 2  ; string length 
 	mov  dh,14                 ; start row contains 2 
 	mov  dl,30			  ;start column  contains 2
 	mov  bp,OFFSET stmenu         ; string offset 
	int  10h 

ret
menu endp

;displaying full screens

screen proc uses ax bx es  cx dx si di bp

call names 
call menu

	mov  ax,SEG scorestr        ; set ES segment
	 mov  es,ax 
 	mov  ah,13h                       ; write string 
 	mov  al,2                         ; write mode 
 	mov  bh,0                       ; video page 
 	mov  cx,(SIZEOF scorestr) / 2  ; string length 
 	mov  dh,6                   ; start row contains 2 
 	mov  dl,30			  ;start column  contains 2
 	mov  bp,OFFSET scorestr       ; string offset 
	int  10h 

	;score literal
	mov dh, 6; y coordinate
	
	mov dl,43 ; x coordinate
	
	mov ax,score ;character
	mov bl,1111b
	print

ret
screen endp


;-----------------------------------------score display procedure------------------------------------------

scoredisplay proc uses ax bx es  cx dx si di bp

	mov  ax,SEG scorestr        ; set ES segment
	 mov  es,ax 
 	mov  ah,13h                       ; write string 
 	mov  al,2                         ; write mode 
 	mov  bh,0                       ; video page 
 	mov  cx,(SIZEOF scorestr) / 2  ; string length 
 	mov  dh,1                  ; start row contains 2 
 	mov  dl,34			  ;start column  contains 2
 	mov  bp,OFFSET scorestr       ; string offset 
	int  10h 

	;score literal
	mov dh, 1; y coordinate
	
	mov dl,48 ; x coordinate
	
	mov ax,score ;character
	mov bl,1111b
	print


ret
scoredisplay endp

;-----------------------------------START SCREEN PROC---------------------------------------------------

startscreen proc uses ax bx es cx dx si di bp

;print Welcome
	mov  ax,SEG Welcomestr         ; set ES segment// asigns si contents corresponding to Welcomestr to ax
	mov  es,ax 
 	mov  ah,13h                       ; write string //teletype output.
 	mov  al,2                         ; write mode 
 	mov  bh,0                       ; video page 
 	mov  cx,(SIZEOF Welcomestr) / 2  ; string length 
 	mov  dh,4                      ; start row contains 2 
 	mov  dl,39						  ;start column  contains 2
 	mov  bp,OFFSET Welcomestr       ; string offset 
	int  10h 
		
;printing super mario	
	mov  ax,SEG mario          ; set ES segment
	mov  es,ax 
 	mov  ah,13h                       ; write string 
 	mov  al,2                         ; write mode 
 	mov  bh,0                       ; video page 
 	mov  cx,(SIZEOF mario) / 2  ; string length 
 	mov  dh,8               ; start row contains 2 
 	mov  dl,30		  ;start column  contains 2
 	mov  bp,OFFSET mario        ; string offset 
	int  10h 
	
	;printing press Enter to continue

	mov  ax,SEG stmenu         ; set ES segment
 	mov  es,ax 
 	mov  ah,13h                       ; write string 
 	mov  al,2                         ; write mode 
 	mov  bh,0                       ; video page 
 	mov  cx,(SIZEOF stmenu ) / 2  ; string length 
 	mov  dh,12                  ; start row contains 2 
 	mov  dl,30			  ;start column  contains 2
 	mov  bp,OFFSET stmenu         ; string offset 
	int  10h 

;printing usernam prompt
	mov  ax,SEG userndp        ; set ES segment
 	mov  es,ax 
 	mov  ah,13h                       ; write string 
 	mov  al,2                         ; write mode 
 	mov  bh,0                       ; video page 
 	mov  cx,(SIZEOF userndp  ) / 2  ; string length 
 	mov  dh,14                  ; start row contains 2 
 	mov  dl,30			  ;start column  contains 2
 	mov  bp,OFFSET userndp         ; string offset 
	int  10h 
	
;printing username
	mov  ax,SEG usernam      ; set ES segment
 	mov  es,ax 
 	mov  ah,13h                       ; write string 
 	mov  al,2                         ; write mode 
 	mov  bh,0                       ; video page 
 	mov  cx,(SIZEOF usernam) / 2  ; string length 
 	mov  dh,14                  ; start row contains 2 
 	mov  dl,48	  ;start column  contains 2
 	mov  bp,OFFSET usernam           ; string offset 
	int  10h 
	

ret 
startscreen endp

;------------------------------------------------LOSING SCREEN PROC----------------------------------------
lostscreen proc uses ax bx cx dx si di es bp 
	
	mov  ax,SEG mario          ; set ES segment
 	mov  es,ax 
 	mov  ah,13h                       ; write string 
 	mov  al,2                         ; write mode 
 	mov  bh,0                       ; video page 
 	mov  cx,(SIZEOF mario) / 2  ; string length 
 	mov  dh,6                ; start row contains 2 
 	mov  dl,30		  ;start column  contains 2
 	mov  bp,OFFSET mario        ; string offset 
	int  10h 


	;score string
	mov  ax,SEG scorestr        ; set ES segment
	mov  es,ax 
 	mov  ah,13h                       ; write string 
 	mov  al,2                         ; write mode 
 	mov  bh,0                       ; video page 
 	mov  cx,(SIZEOF scorestr) / 2  ; string length 
 	mov  dh,8                   ; start row contains 2 
 	mov  dl,30			  ;start column  contains 2
 	mov  bp,OFFSET scorestr       ; string offset 
	int  10h 


	;score literal
	mov dh, 8; y coordinate
	
	mov dl,43 ; x coordinate
	
	mov ax,score ;character
	mov bl,1111b
	print

	;printing You Lost
	mov  ax,SEG loststr         ; set ES segment
 	mov  es,ax 
	mov  ah,13h                       ; write string 
 	mov  al,2                         ; write mode 
 	mov  bh,0                       ; video page 
 	mov  cx,(SIZEOF loststr ) / 2  ; string length 
 	mov  dh,10                ; start row contains 2 
 	mov  dl,30			  ;start column  contains 2
 	mov  bp,OFFSET loststr         ; string offset 
	int  10h 

	mov  ax,SEG usernam      ; set ES segment
 	mov  es,ax 
 	mov  ah,13h                       ; write string 
 	mov  al,2                         ; write mode 
 	mov  bh,0                       ; video page 
 	mov  cx,(SIZEOF usernam) / 2  ; string length 
 	mov  dh,10                  ; start row contains 2 
 	mov  dl,40	  ;start column  contains 2
 	mov  bp,OFFSET usernam           ; string offset 
	int  10h 


	;printing press any key to continue

	mov  ax,SEG menu1         ; set ES segment
 	mov  es,ax 
 	mov  ah,13h                       ; write string 
 	mov  al,2                         ; write mode 
 	mov  bh,0                       ; video page 
 	mov  cx,(SIZEOF menu1 ) / 2  ; string length 
 	mov  dh,12                  ; start row contains 2 
 	mov  dl,30			  ;start column  contains 2
 	mov  bp,OFFSET menu1         ; string offset 
	int  10h 

	mov  ax,SEG menu1st2        ; set ES segment
 	mov  es,ax 
 	mov  ah,13h                       ; write string 
 	mov  al,2                         ; write mode 
 	mov  bh,0                       ; video page 
 	mov  cx,(SIZEOF menu1st2  ) / 2  ; string length 
 	mov  dh,12                  ; start row contains 2 
 	mov  dl,52			  ;start column  contains 2
 	mov  bp,OFFSET menu1st2          ; string offset 
	int  10h 

ret
lostscreen endp


;--------------------------------------------WIN SCREEN PROCEDURE------------------------------------------------------

winingscreen proc uses ax bx cx dx si di es bp 

	mov  ax,SEG mario          ; set ES segment
 	mov  es,ax 
 	mov  ah,13h                       ; write string 
 	mov  al,2                         ; write mode 
 	mov  bh,0                       ; video page 
 	mov  cx,(SIZEOF mario) / 2  ; string length 
 	mov  dh,6                ; start row contains 2 
 	mov  dl,30		  ;start column  contains 2
 	mov  bp,OFFSET mario        ; string offset 
	int  10h 


	;score string
	mov  ax,SEG scorestr        ; set ES segment
	mov  es,ax 
 	mov  ah,13h                       ; write string 
 	mov  al,2                         ; write mode 
 	mov  bh,0                       ; video page 
 	mov  cx,(SIZEOF scorestr) / 2  ; string length 
 	mov  dh,10                  ; start row contains 2 
 	mov  dl,30			  ;start column  contains 2
 	mov  bp,OFFSET scorestr       ; string offset 
	int  10h 


	;score literal
	mov dh, 10; y coordinate
	
	mov dl,43 ; x coordinate
	
	mov ax,score ;character
	mov bl,1111b
	print

	;printing You win
	mov  ax,SEG winstr      ; set ES segment
 	mov  es,ax 
	mov  ah,13h                       ; write string 
 	mov  al,2                         ; write mode 
 	mov  bh,0                       ; video page 
 	mov  cx,(SIZEOF winstr  ) / 2  ; string length 
 	mov  dh,8              ; start row contains 2 
 	mov  dl,30			  ;start column  contains 2
 	mov  bp,OFFSET winstr          ; string offset 
	int  10h 

	mov  ax,SEG usernam      ; set ES segment
 	mov  es,ax 
 	mov  ah,13h                       ; write string 
 	mov  al,2                         ; write mode 
 	mov  bh,0                       ; video page 
 	mov  cx,(SIZEOF usernam) / 2  ; string length 
 	mov  dh,8                 ; start row contains 2 
 	mov  dl,40	  ;start column  contains 2
 	mov  bp,OFFSET usernam           ; string offset 
	int  10h 


	;printing press any key to continue

	mov  ax,SEG menu1         ; set ES segment
 	mov  es,ax 
 	mov  ah,13h                       ; write string 
 	mov  al,2                         ; write mode 
 	mov  bh,0                       ; video page 
 	mov  cx,(SIZEOF menu1 ) / 2  ; string length 
 	mov  dh,12                  ; start row contains 2 
 	mov  dl,30			  ;start column  contains 2
 	mov  bp,OFFSET menu1         ; string offset 
	int  10h 

	mov  ax,SEG menu1st2        ; set ES segment
 	mov  es,ax 
 	mov  ah,13h                       ; write string 
 	mov  al,2                         ; write mode 
 	mov  bh,0                       ; video page 
 	mov  cx,(SIZEOF menu1st2  ) / 2  ; string length 
 	mov  dh,12                  ; start row contains 2 
 	mov  dl,52			  ;start column  contains 2
 	mov  bp,OFFSET menu1st2          ; string offset 
	int  10h 




ret
winingscreen endp


 ;---------------------------------------main ended----------------------------------------------------------
end main 
