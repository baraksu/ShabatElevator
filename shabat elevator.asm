; 101
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
 floor_num dw ?
 floor_size dw ?
 remember dw ?
x_coordinate dw 199
y dw 199
color dw 15 
len dw 10
x_temp dw 10 
x_2 dw 100
y_2 dw 20
first_floor dw 100
next_floor dw ? 
mone dw 0
max_black dw 7
rect_floor dw 0               
new_y dw 0                
x_center dw 30
y_center dw 130
y_value dw 0
x_value dw 10 
decision dw ?
color_o db 0fh 
y_stickman dw 150
x_stickman dw 30
h dw 30                
y_coordinate dw 25 
y_temp dw 25                
x_rect dw 150
y_first dw 198
max_rect dw 199
count dw 0                
mid_rect dw 157
end_rect dw 164
count_2 dw 7 
.CODE 

 proc draw_LeftLine
	pusha
	xor bh, bh  ; bh = 0
	mov cx, [x_2]
	mov dx, [y_2]
	mov ax, [color] 
	mov ah, 0ch
	int 10h
	inc y_2
	cmp y_2,199
	jb draw_LeftLine 
	popa
	
	endp draw_LeftLine 
	

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
	popa
	
	endp  draw_GroundFloor
	
	
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
	popa
	
	endp draw_RightLine
	

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
	popa
	
	endp draw_Roof
	  
	 
	  proc draw_Floor
	pusha            
	xor bh, bh  ; bh = 0
	
	
	mov cx, [first_floor]
	mov dx, [floor_size]
	mov ax, [color] 
	mov ah, 0ch
	int 10h  
	inc first_floor
	cmp first_floor, 199
	jb draw_Floor
	je math
	popa

	  endp draw_Floor
	    
	 
	  
	  proc new_floor
	pusha            
	xor bh, bh  ; bh = 0
	mov cx, [first_floor]
	mov dx, [floor_size]
	mov ax, [color] 
	mov ah, 0ch
	int 10h  
	dec first_floor
	cmp first_floor, 100
	ja new_Floor
	je math
	popa
	 ret
	  endp new_Floor
	  
	    proc rect
	     
	    pusha
	    xor bh, bh  ; bh = 0 
	   
	    mov cx, [x_rect]
	    mov dx, [y_first]
	    mov ax, [color]
	    mov ah, 0ch
	    int 10h
	    dec y_first
	    mov bx, y_first
	    cmp bx, max_rect
	    ja rect
        je next_line
	   
	    popa

	        endp rect
	        
	    proc paint_rect
	     
	    pusha
	    xor bh, bh  ; bh = 0 
	   
	    mov cx, [mid_rect]
	    mov dx, [y_first]
	    mov ax, [color]
	    mov ah, 0ch
	    int 10h
	    dec y_first
	    mov bx, y_first
	    cmp bx, 174
	    ja paint_rect
	    je next_color_line
	   
	    popa

	    endp print_rect
	    
	proc delete_rect
	    pusha
	    xor bh, bh  ; bh = 0 
	   
	    mov cx, [x_rect]
	    mov dx, [y_first]
	    mov ax, [color]
	    mov ah, 0ch
	    int 10h
	    dec y_first
	    mov bx, y_first
	    cmp bx, max_rect
	    ja delete_rect
	    je next_delete_line
	    popa    
	    endp delete_rect    
	    
	  
	  



start: 
    mov ax, @data
    mov ds, ax  
 
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
   mov floor_num, ax
   
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
mov remember, ax
mov ax, max 
sub ax, remember
mov floor_size, ax


 




 



 
mov ah, 0
mov al, 13h
int 10h
 
 

   
  ; call draw_LeftLine 
   
   
   
 
    
    math:
  
    
   mov ax, floor_size 
	   
	 sub ax, remember
	 
	 

mov floor_size, ax  
mov [first_floor], 199  
 inc mone
  
mov ax, mone
mov bx,floor_num
xor bh, bh
cmp al,bl
jb new_floor

rect_math:
mov color, 15
  mov ax, max_rect
    sub ax, 25
    mov max_rect, ax
call rect

next_line:
 mov y_first, 198
 mov ax, new_y
 sub y_first, ax 
 inc x_rect 
	
	inc count
	mov ax, count
	xor bh, bh
	cmp ax, 21
	jbe rect
	ja color_rect 
	
	next_color_line:
 mov y_first, 198
 mov ax, new_y
 sub y_first, ax 
 inc mid_rect 
	
	inc count_2
	mov ax, count_2
	xor bh, bh
	cmp ax, 14
	jbe  color_rect 
	ja delete
	
	color_rect:
	mov color, 0h
	call paint_rect
	  
	  delete:
	  mov x_rect, 150
	 mov color, 0
	call delete_rect
	
	next_delete_line:
	mov y_first, 198
 mov ax, new_y
 sub y_first, ax 
 inc x_rect 
	
	inc max_black
	mov ax, max_black
	xor bh, bh
	cmp ax, 28
	jbe delete_rect
 
	 
	 
	next_rect_floor:
	mov y_first, 198
	mov x_rect, 150 
	add new_y, 25
	mov ax, new_y
	sub y_first, ax
	inc rect_floor
	mov ax, rect_floor
	cmp ax, floor_num
	jb rect_math
	je exit
	
	
	 
	 
	 
	    


	

    
	
	
	
	
	
     
   
   
   
   
exit:
			

  mov AH,4CH
  int 21h

END start    
	
	
	
	
	
  
 

    

  
     

  
  
 
 
 
    
 
   
   
