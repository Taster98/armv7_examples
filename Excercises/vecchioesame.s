.data
v:	.word 1,2,3,4,5,6,7,8
.text
.global main

main:	mov r0, #8
	ldr r1, =v
	mov r2, #5
	push {lr}
	bl cerca
	pop {pc}
