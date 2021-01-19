.text
.global cambia
.type cifra %function
.type cambia %function

@in R0 ho c, e in R1 ho n
cifra:	mov R2, R0 @Sposto c in R2 (unsigned int cc;)
	cmp R0, #0x7a  @confronto c con 'z'
	bgt skip
	cmp R0, #0x61
	blt skip
	add R3,R0,R1 @Se arrivo qui vuol dire che sono nel range a-z, quindi in cc = c+n;
	mov R2, R3
	cmp R2, #0x7a @if(cc>'z') ..
	BLE skip
	sub R2, R2, #0x7a @In cc metto cc-'z'
	add R2, R2, #0x61 @In cc aggiungo 'a'
	sub R2, R2, #1 @In cc sottraggo 1
skip:	mov R0, R2
	mov PC, LR

@ Ora qui implemento la funzione cambia
@ In R0 ho la mia stringa e in R1 ho la sua lunghezza
cambia:	push {R0-R1, LR} @Salvo questi parametri nello stack perché chiamo strlen
	bl strlen
	mov R2, R0  @Salvo il valore di ritorno in R2
	pop {R0-R1, LR}
	@In R2 ho la lunghezza della stringa
	mov R3, #0 @sum = 0
	mov R4, #0 @i=0
for:	cmp R4, R2 @confronto i con ls
	bge fine
	push {R0-R3, LR} @salvo i parametri della funzione cambia
	@In R0 devo caricare il carattere corrente, con una LDRB
	ldrb R6, [R0,R4] @Metto in R6 l'elemento i-esimo di R0 che ha il vettore
	mov R0, R6
	bl cifra
	mov R5, R0 @In R5 ho il valore di ritorno di cifra
	pop {R0-R3, LR}
	cmp R5,R6
	beq skip2
	mov R6, R5
	strb R6,[R0,R4] @memorizzo il cambiamento
	add R3, R3, #1 @incremento sum
skip2:	add R4, R4, #1
	b for
fine:	mov R0, R3
	mov PC, LR
	
	


	

