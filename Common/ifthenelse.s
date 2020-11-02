@ Semantica if then else: 

@ if(x==0) 
@ 	x++;
@ else 
@ 	y++;
@ con x -> R0, y -> R1

@ Definisco dove sta il mio codice:

.text
.global main

@ Scrivo il main

main:	mov R1, #7	
	mov R0, #1
	@ mov R0, #0
	cmp R0, #0
	beq then @ se la condizione è vera vado al ramo then, sennò skippo questo e vado all'else
	sub r1, r1, #1
	b end
then:	add r0, r0, #1
end:	mov R0, R0 @ Questa operazione non fa nulla ma mi permette di uscire dall'if

@ syscall per la exit
	mov r7, #1
	svc 0
	
