.text
.global cambia
.type cambiaV %function
.type cambia %function

@ In R0 ho il carattere c
cambiaV: sub R1, R0, #0x30
	cmp R1, #0
	blt skip
	cmp R1, #9
	bgt skip
	add R1, R1, #5
	cmp R1, #9
	ble skip
	lsr R1, R1, #1 @logical shift right equivale a dividere per (2*off), dove off in sto caso è 1
skip:	add R0, R1, #0x30
	mov PC, LR

@ In R0 c'è la stringa
cambia:	push {R0,LR}
	bl strlen
	mov R4, R0 @ ls = lungh in R4
	pop {R0, LR}
	mov R1, #0 @ sum = 0
	mov R2, #0 @ i=0
for:	cmp R2, R4
	bge fine
	ldrb R3, [R0,R2] @ carico in R3 s[i]
	push {R0-R3, LR}
	mov R0, R3
	bl cambiaV
	mov R5, R0 @cc sta in R5
	pop {R0-R3, LR}
	cmp R5, R3
	beq skip2
	strb R5, [R0,R2]
	add R1, R1, #1
skip2:	add R2, R2, #1
	b for
fine:	mov R0, R1
	mov PC, LR

