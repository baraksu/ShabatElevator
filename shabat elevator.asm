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
 floor_num db ?
 floor_size db ?
x dw 1h
y dw 1h
column dw 50
row dw 100 
w equ 16
h equ 4
 
 

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
mov floor_size, al
 
 mov ax,13h
 int 10h  
  
  
 
 
 
    
 
   
   

