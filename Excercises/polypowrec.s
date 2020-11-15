@ Programma che calcola la somma delle potenze di un polinomio con la pow ricorsiva
@ ris = x + 2x^2 + 3x^3 + ... + nx^n
@ int polypow (n){
@	for(int i=1;i<=n;i++){
@		ris = ris + i*pow(x,i);
@	}
@	return ris;
@ }
@ int pow(int x, int p){
@	if(p == 1) return x;
@	else return x * pow(x, p-1);
@	}

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
	push {r0, r1, lr}
	bl pow
	mov r3, r0
	pop {r0, r1, lr}
	mul r3, r3, r1
	add r4, r4, r3
	add r1, r1, #1
	b for
end:	push {lr}
	mov r1, r4
	ldr r0, =outp
	bl printf
	pop {pc} 

pow:	cmp r1, #1
	moveq pc, lr
	push {r0, lr}
	sub r1, r1, #1
	bl pow
	pop {r1, lr}
	mul r0, r1, r0
	mov pc, lr




















