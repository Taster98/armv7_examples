.text
.global somma
.type somma %function
.type quanto %function

@ In R0 ho il carattere c
quanto:	mov R2, #0 		@ int ret = 0
	sub R1, R0, #0x30 	@ int v = c - '0'
	cmp R1, #0			@ Confronto v prima con 0
	blt skip			@ Se è minore skippo
	cmp R1, #9			@ Altrimenti confronto con 9
	bgt skip			@ Se è maggiore skippo
	mov R2, R1			@ Altrimenti posso mettere v in ret
skip:	mov R0, R2		@ Sposto ret in R0 per ritornarlo
	mov PC, LR

@ In R0 ho la stringa s
somma:	mov R1, #0 		@ int sum = 0
	mov R2, #0 			@ int i = 0
	push {R0-R2, LR}	@ Salvo nello stack i registri prima di chiamare strlen(s)
	bl strlen
	mov R3, R0  		@ int n = strlen(s)
	pop {R0-R2, LR}		@ Recupero i valori salvati nello stack
while:	cmp R2, R3		@ Nel while confronto i con n
	bge skip2			@ Se è maggiore o uguale skippo
	push {R0-R2, LR}	@ Sennò salvo nello stack i registri perchè sto per chiamare la funzione quanto
	ldrb R0, [R0, R2]	@ Carico nel primo parametro il carattere i-esimo della stringa: R0 = s[i]
	bl quanto
	mov R4, R0			@ Sposto il valore di ritorno in R4
	pop {R0-R2, LR}		@ Recupero i valori dai registri precedentemente salvati nello stack
	add R1, R1, R4		@ Incremento sum (sum += quanto(s[i]))
	add R2, R2, #1		@ Incremento i
	b while
skip2:	mov R0, R1		@ Posso mettere sum in R0 così posso ritornare
	mov PC, LR
	
	
	
