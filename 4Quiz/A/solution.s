.text
.global cambia
.type cifra %function
.type cambia %function

@in R0 ho c, e in R1 ho n
cifra:	mov R2, R0 @ Sposto c in R2 (unsigned int cc = c;)
	cmp R0, #0x7a  @ Confronto c con 'z'
	bgt skip	   @ Se è maggiore di 'z' skippo
	cmp R0, #0x61  @ Confronto c con 'a'
	blt skip	   @ Se è minore di 'a' skippo
	add R2,R0,R1   @ Se arrivo qui vuol dire che sono nel range 'a'-'z', quindi faccio cc = c+n;
	cmp R2, #0x7a  @ Confronto cc con 'z'
	ble skip	   @ Se è minore o uguale skippo
	sub R2, R2, #0x7a @ In cc metto cc-'z'
	add R2, R2, #0x61 @ In cc aggiungo 'a'
	sub R2, R2, #1    @ In cc sottraggo 1
skip:	mov R0, R2    @ Il valore di ritorno è cc che sta in R2, lo sposto in R0 e posso fare la return
	mov PC, LR

@ Ora qui implemento la funzione cambia
@ In R0 ho la mia stringa e in R1 ho la sua lunghezza
cambia:	push {R0-R1, LR} @ Salvo questi parametri nello stack perché chiamo strlen
	bl strlen
	mov R2, R0  @ Salvo il valore di ritorno di strlen in R2 (ls = strlen(s))
	pop {R0-R1, LR} @ Recupero i valori precedentemente salvati
	mov R3, #0 @ sum = 0
	mov R4, #0 @ i=0
for:	cmp R4, R2 @ confronto i con ls (lungh stringa)
	bge fine	   @ Se i >= ls allora ho finito di iterare
	push {R0-R3, LR} @ Salvo i parametri della funzione cambia
	ldrb R6, [R0,R4] @ Metto in R6 l'elemento i-esimo di R0 che ha il vettore, usando LDRB
	mov R0, R6       @ Sposto il valore in R0 prima di chiamare la funzione cifra, perché deve essere il primo parametro
	bl cifra		 @ Il secondo parametro non lo abbiamo spostato quindi possiamo chiamarla subito
	mov R5, R0 		 @ In R5 ho il valore di ritorno di cifra (cc = cifra)
	pop {R0-R3, LR}	 @ Recupero i valori precedentemente salvati
	cmp R5,R6		 @ Confronto cc con s[i]
	beq skip2		 @ Se sono uguali skippo
	mov R6, R5		 @ Se differiscono allora aggiorno s[i] con STRB e incremento sum:
	strb R6,[R0,R4]  @ Memorizzo il cambiamento
	add R3, R3, #1 	 @ Incremento sum
skip2:	add R4, R4, #1 @ Incremento l'indice i del for
	b for			   @ Rivado a for
fine:	mov R0, R3	   @ Se sono qui ho finito di iterare, e devo ritornare sum che è in R3, lo sposto in R0
	mov PC, LR		   @ Ritorno
	
	


	

