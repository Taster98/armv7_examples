@ Il testo praticamente chiedeva se, dato un vettore, la sua
@ lunghezza e un intero da cercare, si scrivesse una funzione
@ cerca che restituisse 1 se il valore era presente, 0 altrimenti
@ il main era già dato
.data
v:	.word 1,2,3,4,5,6,7,8
outp:	.string "Il valore è presente: %d\n"
.text
.global main

main:	mov r0, #8
	ldr r1, =v
	mov r2, #11
	push {lr}
	bl cerca
	pop {pc}
@ FIN QUI ERA IL TESTO

@ L'ES INIZIA QUI
cerca:	mov r3, r0 @ dim
	mov r0, #0 @ risultato
	ldr r4, [r1] 
for:	cmp r4, r2
	beq end
	cmp r3, #0
	ble notthr
	sub r3, r3, #1
	ldr r4, [r1], #4
	b for
end:	mov r0, #1
notthr:	push {lr}
	mov r1, r0
	ldr r0, =outp
	bl printf
	pop {lr}
	mov pc, lr
	
	
