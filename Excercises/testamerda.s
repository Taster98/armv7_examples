@ scrivi i cazzo di -1 nei cazzo di numeri dispari del cazzo di array
@ {1,2,3,4} --> {-1, 2, -1, 4}

.data
v:	.word 1,2,3,4

.text
.global main

main:	mov r0, #4 @ in r0 la dimensione
	ldr r1, =v @ in r1 il vettore
	push {lr}
	bl cazzo
	pop {pc} @ return del main

@ in r0 ho la dimensione (4) e in r1 ho caricato l'indirizzo di v
cazzo:	mov r2, r0
	mov r4, #0 @ questo è l'indice del for
for:	cmp r4, r2
	bge end
	ldr r3, [r1, r4, LSL #2]
	@ controllo se il numero è dispari
	push {r0-r4, lr}
	mov r0, r3
	bl disp
	cmp r0, #0
	beq skip
	mov r5, #-1
	str r5, [r1, r4, LSL #2]
skip:	pop {r0-r4, lr}
	add r4, r4, #1
	b for
end:	mov pc, lr

@ funzione che ritorna 1 se dispari, 0 altrimenti
disp:	sub r0, r0, #2
	cmp r0, #0
	beq pr @ se è 0, allora il numero è pari
	blt dspr @ se è minore di 0, il numero è dispari
	b disp
pr:	mov r0, #0
	b fine
dspr:	mov r0, #1
fine:	mov pc, lr
	
