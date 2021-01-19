@ int *filt(int n, int *v){
@	for(int i=0;i<n;i++){
@		if(mmod(v[i], 2) == 0){
@ 			v[i] = 0;
@ 		}
@ 	}
@	return v;
@ }

.data
v:	.word 1,2,3,4,5,6,7,8
.text
.global main
main:	mov r0, #8
	ldr r1, =v
	push {lr}
	bl filt
	pop {pc}

filt:	mov r4, #0 @ indice i
	mov r5, r0
for:	cmp r4, r5 @ i<n?
	bge end
	@ Prendo l'elemento i-esimo dal mio vettore (in r2)
	ldr r2, [r1], #4
	@ ora voglio farne il modulo per vedere se è pari:
	push {r0-r2, r4, r5, lr}
	mov r0, r2
	bl mmod
	@ il risultato è in r0: se è uguale a 1 allora devo agire, sennò no
	cmp r0, #1
	bne nonug
	@ se invece è uguale, devo cambiare il valore in r1:
	mov r0, #0
	ldr r1, =v
	str r0, [r1, r4]
nonug:	pop {r0-r2, r4, r5, lr}
	@ ora aumento il mio indice
	add r4, r4, #1
	b for
end:	ldr r0, =v
	mov pc, lr

mmod:	sub r0, r0, #2
	cmp r0, #0
	beq si
	blt no
	b mmod
si:	mov r0, #1
no:	mov pc, lr
	
