@ Calcolo il numero di fibonacci
@ int fibonacci(int n){
@	if(n<=1) return n;
@	else return fibonacci(n-1) + fibonacci(n-2);
@ }
.data
outp:	.string "Il risultato è: %d\n"
.text
.global fibonacci
fibonacci:	cmp r0, #1
		movle pc, lr
		push {lr}
		sub r0, r0, #1
		push {r0}
		bl fibonacci
		pop {r1}
		push {r0}
		sub r0, r1, #1
		bl fibonacci
		pop {r1}
		add r0, r0, r1
		pop {pc}
