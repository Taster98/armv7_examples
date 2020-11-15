@ Programma che esegue la differenza di due quadrati:
@ Ris = x^2 - y^2
@ int diffquadabs(int x, int y){
@	x = x*x;
@	y = y*y;
@	ris = x-y;
@	if(ris<0) ris*-1;
@	return ris;
@ }
.data
outp:	.string "La differenza di quadrati assoluta è: %d\n"
.text
.global main

main:	mov r1, #4
	mov r2, #7
	mul r1, r1, r1
	mul r2, r2, r2
	sub r0, r1, r2
	cmp r0, #0
	push {lr}
	bge print
	bl abs
print:	mov r1, r0
	ldr r0, =outp
	bl printf
end:	pop {pc}
abs:	mov r2, #-1
	mul r0, r0, r2
	mov pc, lr
