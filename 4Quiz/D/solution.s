.text
.global cambia
.type cambiaV %function
.type cambia %function

@ In R0 ho il carattere c
cambiaV: sub R1, R0, #0x30	@ int v = c - '0'
	cmp R1, #0				@ Confronto prima v con 0
	blt skip				@ Se è minore di 0 skippo
	cmp R1, #9				@ altrimenti confronto anche con 9
	bgt skip				@ Se è maggiore skippo
	add R1, R1, #5			@ Altrimenti sono nel range 0-9. Incremento v di 5
	cmp R1, #9				@ Confronto il nuovo v con 9
	ble skip				@ Se è minore o uguale skippo, altrimenti devo dividere v per 2: vedi sotto
	lsr R1, R1, #1 			@ Per dividere per due faccio logical shift right, equivale a dividere per potenze di 2
skip:	add R0, R1, #0x30	@ Se sono qui posso aggiungere a c il valore di v + '0'
	mov PC, LR				@ ritorno questo risultato

@ In R0 c'è la stringa
cambia:	push {R0,LR}		@ Salvo subito R0 e LR per chiamare strlen(s)
	bl strlen
	mov R4, R0 				@ ls = strlen(s) (salvo in R4 la lunghezza della stringa)
	pop {R0, LR}			@ Recupero i valori salvati nello stack
	mov R1, #0				@ int sum = 0
	mov R2, #0 				@ int i=0
for:	cmp R2, R4			@ Confronto i con ls
	bge fine				@ Se è maggiore o uguale ho finito di iterare
	ldrb R3, [R0,R2] 		@ Altrimenti carico in R3 s[i]
	push {R0-R3, LR}		@ Salvo i registri per chiamare la mia funzione con il carattere s[i] come argomento
	mov R0, R3
	bl cambiaV
	mov R5, R0 				@ Sposto il valore di ritorno in R5 (int cc = cambiaV(s[i]))
	pop {R0-R3, LR}			@ Recupero i registri precedentemente salvati nello stack
	cmp R5, R3				@ Confronto cc con s[i]
	beq skip2				@ Se sono uguali skippo
	strb R5, [R0,R2]		@ Altrimenti modifico il valore s[i] nella stringa con cc
	add R1, R1, #1			@ Incremento sum
skip2:	add R2, R2, #1		@ Se ho skippato vado solo avanti con il for (i++)
	b for					
fine:	mov R0, R1			@ Se ho finito posso ritornare sum, spostandolo in R0
	mov PC, LR

