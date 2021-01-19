.text
.global mystrstr
.type mystrstr %function
.type match %function

@Nella funzione match ho in R0 la base di 'uno', in R1 la base di 'due', in R2 ho l
match:	mov R3,#1 @int res=1;
	mov R4,#0 @int i=0;
for:	cmp R4,R2 @i,l
	bge fine
	@Mi carico il carattere i-esimo di uno in R5 e di due in R6
	ldrb R5, [R0,R4]
	ldrb R6, [R1,R4]
	cmp R5, R6
	beq skip
	mov R3, #0
	b fine
skip:	add R4, R4, #1 @i++
	b for
fine:	mov R0, R3
	mov PC, LR

@ Nella funzione mystrstr ho in R0 la base di 'stringa', e in R1 la base di 'parola'
mystrstr: push {R0-R3,LR}
	bl strlen
	mov R4, R0 @In R4 salvo la lunghezza della prima stringa
	pop {R0-R3, LR}
	push {R0-R3, LR}
	mov R0, R1
	bl strlen
	mov R5, R0 @In R5 salvo la lunghezza della seconda stringa
	pop {R0-R3, LR}
	mov R2, R4
	mov R3, R5
	mov R4, #-1 @int trovata = -1
	mov R5, #0 @int i=0
	sub R6, R2, R3
	add R6, R6, #1
for2:	cmp R5, R6
	bge fine2
	push {R0-R6, LR}
	add R0, R0, R5
	mov R2, R3
	bl match
	mov R7, R0 @In R7 ho il ritorno di match
	pop {R0-R6, LR}
	cmp R7,#1
	bne skip2
	mov R4, R5
	b fine2
skip2:	add R5, R5, #1
	b for2
fine2:	mov R0, R4
	mov PC, LR










