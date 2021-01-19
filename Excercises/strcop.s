@ void strcp(char dest[], char sorg[]){
@ 	int i = 0;
@	do {
@		dest[i] = sorg[i];
@	}while(sorg[i++]);
@ }

.data
sorg:	.string "TEST"
dest:	.string ""
res:	.string "\n La stringa copiata è: %s\n"
dbg:	.string "DEBUG: %s\n"

.text
.global main
main:	ldr r0, =dest
	ldr r1, =sorg
	push {lr}
	bl strcp
	pop {lr}
	mov pc, lr

strcp:	push {r0, lr}
	mov r0, #5
	bl malloc
	mov r2, r0
	pop {r0, lr}
	str r2, [r0]
	
	
	ldr r1, [r0]
	ldr r0, =dbg
	push {lr}
	bl printf
	pop {pc}
	mov pc, lr
