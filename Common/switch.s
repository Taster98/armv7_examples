@ Semantica switch case:

@ switch(x){
@	case 0: x++;
@	break;
@	case 1: x--;
@	break;
@	case 2: x + 7;
@	break;
@ }
@ con x -> R0

@ definisco dove sta il mio codice
.text
.global main

@ scrivo il main

main:	mov R0, #2 @ inizializzo a 2 la variabile, in questo modo dovrei avere un 9 nel R0 alla fine;

switch:	cmp R0, #0 @ confronto R0 con 0
	beq case0 @ se è vero vado in case0 altrimenti no
	cmp R0, #1
	beq case1
	cmp R0, #2
	beq case2
case0:	add R0, R0, #1 @ qui ci sono i vari case
	b break @ come nello switch case, quando ho finito esco
case1:	sub R0, R0, #1
	b break
case2:	add R0, R0, #7
	b break
break: mov R0, R0

	mov r7, #1
	svc 0		@ syscall per la exit
