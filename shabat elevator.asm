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
 

.CODE

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


 



 
 mov ax,19h
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
	cmp y_2,199
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
	
	    
	
	
	
	
	
  
 

    

  
     

  
  
 
 
 
    
 
   
   

