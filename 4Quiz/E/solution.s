.text
.global somma
.type somma %function
.type quanto %function

@ In R0 ho il carattere C
quanto:	mov R2, #0 @ret = 0
	sub R1, R0, #0x30 @v= c - '0'
	cmp R1, #0
	blt skip
	cmp R1, #9
	bgt skip
	mov R2, R1
skip:	mov R0, R2
	mov PC, LR

@ In R0 ho la stringa s
somma:	mov R1, #0 @ sum = 0
	mov R2, #0 @ i = 0
	push {R0-R2, LR}
	bl strlen
	mov R3, R0  @n = strlen(s)
	pop {R0-R2, LR}
while:	cmp R2, R3
	bge skip2
	push {R0-R2, LR}
	ldrb R0, [R0, R2]
	bl quanto
	mov R4, R0
	pop {R0-R2, LR}
	add R1, R1, R4
	add R2, R2, #1
	b while
skip2:	mov R0, R1
	mov PC, LR
	
	
	
