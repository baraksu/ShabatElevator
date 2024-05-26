.MODEL small
.STACK 100h

.DATA
 logo db  13,10, ' ____  _           _           _     _____ _                 _            ' ,13,10
 logo2 db 13,10,' / ___|| |__   __ _| |__   ____| |_  | ____| | _____   ____ _| |_ ___  _ __ ',13,10
 logo3 db 13,10,' \___ \|  _ \ / _` |  _ \ / _  | __| |  _| | |/ _ \ \ / / _` | __/ _ \|  __|',13,10
 logo4 db 13,10,'  ___) | | | | (_| | |_) | (_| | |_  | |___| |  __/\ V / (_| | || (_) | |    ',13,10
 logo5 db 13,10,' |____/|_| |_|\____|____/ \____|\__| |_____|_|\___| \_/ \____|\__\___/|_|     ' ,13,10,'$'
 msg1 db 13,10,,'  Enter numbers of floors' ,13,10,'$'
 msg2 db 13,10,' Enter size of floor' ,13,10,'$'
 max dw 200
 floor_num db ?
 floor_size dw ?
x_coordinate dw 199
y dw 179
color dw 15 
len dw 10
x_temp dw 10 
x_2 dw 100
y_2 dw 20
first_floor dw 100
next_floor dw ? 
                
                
x_center dw 20
y_center dw 130
y_value dw 0
x_value dw 10 
decision dw ?
color_o db 0fh 
y_stickman dw 150
x_stickman dw 30
h dw 30                
                
                

.CODE 
proc circle

 



     mov bx, x_value
     mov ax,2
     mul bx
     mov bx,3
     sub bx,ax 
     mov decision,bx
     mov al,color_o
     mov ah,0ch
     drawcircle:
     mov al,color_o
     mov ah,0ch 
     mov cx, x_value
     add cx, x_center 
     mov dx, y_value
     add dx, y_center
     int 10h
     mov cx, x_value 
     neg cx
     add cx, x_center 
     int 10h
     mov cx, y_value     
     add cx, x_center 
     mov dx, x_value
     add dx, y_center
     int 10h 
     mov cx, y_value 
     neg cx
     add cx, x_center 
     int 10h
     mov cx, x_value 
     add cx, x_center
     mov dx, y_value
     neg dx
     add dx, y_center
     int 10h

; 

 mov cx, x_value 
 neg cx

 add cx, x_center 

 int 10h



 mov cx, y_value 

 add cx, x_center 

 mov dx, x_value

 neg dx

 add dx, y_center

 int 10h

; 

 mov cx, y_value 

 neg cx

 add cx, x_center 

 int 10h

 

condition1:

 cmp decision,0

 jg condition2      

 mov cx, y_value

 mov ax, 2

 imul cx 

 add ax, 3 

 mov bx, 2

 mul bx  

 add decision, ax

 mov bx, y_value

 mov dx, x_value

 

  

 inc y_value

 jmp drawcircle



condition2:

 mov cx, y_value 

 mov ax,2

 mul cx 

 mov bx,ax

 mov cx, x_value

 mov ax, -2

 imul cx 

 add bx,ax

 add bx,5

 mov ax,2

 imul bx        

 add decision,ax

 mov bx, y_value

 mov dx, x_value

 cmp bx, dx

 ja donedrawing

 dec x_value    

 inc y_value

 jmp drawcircle
 
donedrawing:
mov cx,x_stickman
mov dx,y_stickman
add dx,h
mov al,0fh
mov ah,0ch
next3:
int 10h
dec dx
cmp dx,y_stickman
jne next3
;lf hand
mov bx,10
mov cx,30
mov dx,155
mov ah,0ch
mov al,0fh
lfhand:
int 10h
 inc cx  
 inc dx 
 dec bx 
 cmp bx,0
 jne lfhand 
 ;r_hand
    mov bx,10
    mov cx,30
    mov dx,155
    mov ah,0ch
    mov al,0fh
rhandloop:
int 10h
dec cx ; increase x values 
 inc dx ; decrease y values
 dec bx ; decrease length
 cmp bx,0
 jne rhandloop
 
 ;lf lag
mov bx,10
mov cx,30
mov dx,180
mov ah,0ch
mov al,0fh
lfleg:
int 10h
 inc cx  
 inc dx 
 dec bx 
 cmp bx,0
 jne lfleg 
 ;r lag
    mov bx,10
    mov cx,30
    mov dx,180
    mov ah,0ch
    mov al,0fh
rlegloop:
int 10h
dec cx ; increase x values 
 inc dx ; decrease y values
 dec bx ; decrease length
 cmp bx,0
 jne rlegloop
 
 
 
 
  

ret
endp circle+



start: 
    mov ax, @data
    mov ds, ax
    xor ax,ax  
     lea dx,logo
   mov ah,09h
   int 21h 
   
   read_floor:                                                                                                                                                                                                                                               
   lea dx, msg1
   mov ah,09h
   int 21h       
        mov ah, 1 ; read character function
int 21h   ; read first digit
sub al, '0' ; convert ASCII to integer 
cmp al, 9
ja read_floor

mov floor_num, al
   
   read_size:
   lea dx, msg2
   mov ah,09h
   int 21h
  mov ah, 1 ; read character function
int 21h   ; read first digit
sub al, '0' ; convert ASCII to integer 
cmp bl, 9
ja read_size

mov bl, al ; save first digit in BL 


mov ah, 1 ; read character function
int 21h   ; read second digit
sub al, '0' ; convert ASCII to integer 
cmp al, 9
ja read_size
mov bh, al ; save second digit in BH

mov al, 10 ; multiply first digit by 10
mul bl
  

add al, bh ; add second digit
cmp al, 20
jbe read_size 
sub max, ax
mov ax, max
mov floor_size, ax 


 



 
 mov ax,13h
 int 10h 
 
 loop:
 
	 proc draw_LefteLine
	pusha
	xor bh, bh  ; bh = 0
	mov cx, [x_2]
	mov dx, [y_2]
	mov ax, [color] 
	mov ah, 0ch
	int 10h
	inc y_2
	cmp y_2,180
	jb draw_LefteLine  
	

     proc draw_GroundFloor
	pusha
	xor bh, bh  ; bh = 0
	mov cx, [x_2]
	mov dx, [y_2]
	mov ax, [color] 
	mov ah, 0ch
	int 10h  
	inc x_2
	cmp x_2, 200
	jb draw_GroundFloor
	
	 proc draw_RightLine
	pusha
	xor bh, bh  ; bh = 0
	mov cx, [x_coordinate]
	mov dx, [y]
	mov ax, [color] 
	mov ah, 0ch
	int 10h
	dec y
	cmp y,20
	jg draw_RightLine  
	

     proc draw_Roof
	pusha
	xor bh, bh  ; bh = 0
	mov cx, [x_coordinate]
	mov dx, [y]
	mov ax, [color] 
	mov ah, 0ch
	int 10h  
	dec x_coordinate
	cmp x_coordinate, 100
	jg draw_Roof  
	  
	 
	  proc draw_Floor
	pusha            
	xor bh, bh  ; bh = 0
	mov cx, [first_floor]
	mov dx, [floor_size]
	mov ax, [color] 
	mov ah, 0ch
	int 10h  
	inc first_floor
	cmp first_floor, 200
	jb draw_Floor   
	
	
	  proc new_floor
	pusha            
	xor bh, bh  ; bh = 0
	mov cx, [first_floor]
	sub dx, floor_size
	
	mov ax, [color] 
	mov ah, 0ch
	int 10h  
	dec first_floor
	cmp first_floor, 100
	ja new_Floor 
	
	
	
	int 10h 

 mov x_center,30

 mov y_center,140

 mov y_value,0

 mov x_value,10

 call circle
	
	
	
	
	
     
   
   
   
   
exit:
			

  mov AH,4CH
  int 21h

END start    
	
	
	
	
	
  
 

    

  
     

  
  
 
 
 
    
 
   
   

