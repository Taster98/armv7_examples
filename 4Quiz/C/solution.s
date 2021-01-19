.text
.global cambia
.type cambia %function
.type cambiaV %function

@ In R0 ho la stringa, in R1 ho i, in R2 ho j
cambiaV: mov R3, #0 @int cambio = 0;
	ldrb R4, [R0, R1] @ R4 prende s[i]
	ldrb R5, [R0, R2] @ R5 prende s[j]
	cmp R4, R5
	ble skip
	mov R6, R4
	mov R4, R5
	mov R5, R6
	strb R4, [R0, R1]
	strb R5, [R0, R2]
	mov R3, #1
skip:	mov R0, R3
	mov PC, LR

@ In R0 ho la stringa
cambia:	push {R0, LR}
	bl strlen
	mov R4, R0
	pop {R0, LR}
	mov R5, #0
	mov R6, #0 @ Inizializzo l'indice i
	sub R4, R4, #1 @decremento la lunghezza della stringa di 1
for1:	cmp R6, R4
	bge fine1
	mov R7, R6
	add R7, R7, #1 @metto in j il val i+1
for2:	cmp R7, R4
	bgt fine2
	push {R0-R6, LR}
	mov R1, R6
	mov R2, R7
	bl cambiaV
	mov R8, R0
	pop {R0-R6, LR}
	add R5, R5, R8 @sum+=cambiaV(s,i,j)
	add R7, R7, #1
	b for2
fine2:	add R6, R6, #1
	b for1
fine1:	mov R0, R5
	mov PC, LR
	
