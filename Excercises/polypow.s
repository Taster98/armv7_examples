@ Programma che calcola la somma delle potenze di un polinomio
@ ris = x + 2x^2 + 3x^3 + ... + nx^n
@ int polypow (n){
@	for(int i=1;i<=n;i++){
@		ris = ris + i*pow(x,i);
@	}
@	return ris;
@ }
@ int pow(int x, int p){
@	ris = x;
@	p = p-1;
@	for(int i=p;i>0;i--){
@		ris = ris * x;
@	}
@	return ris;
@ }
.data
outp:	.string "Il risultato è: %d\n"
.text
.global main

main:	mov r0, #4 @x
	mov r1, #1 @i
	mov r2, #3 @n
	mov r4, #0 @sum_aux
for:	cmp r1, r2
	bgt end
	push {r0, lr}
	bl pow
	mov r3, r0
	pop {r0, lr}
	mul r3, r3, r1
	add r4, r4, r3
	add r1, r1, #1
	b for
end:	push {lr}
	mov r1, r4
	ldr r0, =outp
	bl printf
	pop {pc} 
pow:	push {r1-r3,lr}
	mov r2, r0
	mov r3, r1
	sub r3, r3, #1
forp:	cmp r3, #0
	ble endp
	mul r0, r0, r2
	sub r3, r3, #1
	b forp
endp:	pop {r1-r3,pc}
