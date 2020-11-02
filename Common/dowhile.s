@ semantica per il Do-While:
@ do{
@ 	x++;
@ }while(x <= 7);
@
@ con x -> R0

@ definisco dove sta il mio codice
.text
.global main

@ scrivo il main
main:	mov R0, #7
do:	add R0, R0, #1
while:	cmp R0, #7
	ble do
	
	@ termino il programma
	mov r7, #1
	svc 0
