@ Calcolo del fattoriale
@ int fact(int n){
@	if(n==1) return 1;
@	else return n*fact(n-1);
@ In asm è un po' diverso:

.text
.global main

main:
	@ faccio il fattoriale di 7
	mov r0, #7
	bl fact
	
	mov r7, #1
	svc 0

@ definisco la funzione

fact:	cmp r0, #1	@ caso base: se è uno finisce, sennò continua a richiamare se stessa
	beq end
	push {r0, lr}	@ scrivo nello stack il corrente r0 (risultato) e il link register
	sub r0, r0, #1	@ decremento il mio risultato attuale (n)
	bl fact		@ richiamo la funzione con il nuovo valore r0
	pop {r1,lr}	@ recupero il valore precedente (risultato parziale, lo metto in r1) e il lr
	mul r0, r0, r1	@ moltiplico quindi in r0 il corrente (n-1) per il precedente (n)
	mov pc,	lr	@ aggiorno il program counter, ripassandogli il lr attuale
	b fact		@ ritorno su fact
end:	mov pc, lr
