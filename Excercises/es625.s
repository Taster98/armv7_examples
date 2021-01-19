@ void strcopia(char dest[], char sorg[]){
@ 	int i = 0;
@	do {
@		dest[i] = sorg[i];
@	}while(sorg[i++]);
@ }

.data
sorg:	.string "stringa da copiare"
dest:	.string ""
res:	.string "La stringa copiata è: %s"
.text
.global main
main:	ldr r0, =dest
	ldr r1, =sorg
	push {lr}
	bl strcop
	pop {lr}
	mov r1, r0
	ldr r0, =res
	push {lr}
	bl printf
	pop {pc}

strcop: mov r4, #0
		push {r0-r5,lr}
		mov r0, r1
		bl strlen
		mov r6, r0
		pop {r0-r5, lr}
while:	cmp r4,r6	@in r6 c'è la lunghezza della stringa; se è uguale esco, sennò continuo
		bge end
		ldr r3, [r0,r4]
		ldr r5, [r1,r4]
		mov r5, r3
		str r5, [r1,r4]
		add r4, r4, #1
		b while
end:	ldr r0, [r1, #0]
		mov pc, lr
	
