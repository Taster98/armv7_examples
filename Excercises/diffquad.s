@ Programma che esegue la differenza di due quadrati:
@ Ris = x^2 - y^2
@ int diffquad(int x, int y){
@	x = x*x;
@	y = y*y;
@	ris = x-y;
@	return ris;
@ }

.data
outp:	.string "La differenza di quadrati è: %d\n"

.text
.global main

main:	mov r1, #4
	mov r2, #7
	mul r1, r1, r1
	mul r2, r2, r2
	sub r0, r1, r2
	push {lr}
print:	mov r1, r0
	ldr r0, =outp
	bl printf
	pop {pc}
