@ testo il programma di fibonacci con un main che legga da console l'input:
.data
outp:	.string "Il numero di fibonacci è: %d\n"
.text
.global main
main:	push {lr}
	ldr r0, [r1, #4]
	bl atoi
	push {r0}
	bl fibonacci
	mov r2, r0
	pop {r1}
	mov r1, r2
	ldr r0, =outp	
	bl printf
	pop {pc}
