.text
.global cambia
.type cambia %function
.type cambiaV %function

@ In R0 ho la stringa, in R1 ho i, in R2 ho j
cambiaV: mov R3, #0 	@ int cambio = 0;
	ldrb R4, [R0, R1] 	@ R4 prende s[i]
	ldrb R5, [R0, R2] 	@ R5 prende s[j]
	cmp R4, R5			@ Confronto s[i] e s[j]
	ble skip			@ Se s[i] è minore o uguale skippo
	mov R6, R4			@ Altrimenti devo fare lo swap tra s[i] ed s[j], mi salvo s[i] in R6
	mov R4, R5			@ Metto in s[i] s[j]
	mov R5, R6			@ Metto in s[j] R6
	strb R4, [R0, R1]	@ Aggiorno la stringa nei due chars modificati
	strb R5, [R0, R2]
	mov R3, #1			@ Mi memorizzo che il cambio è stato fatto
skip:	mov R0, R3		@ Se ho skippato ritorno 0, altrimenti cambio varrà 1
	mov PC, LR

@ In R0 ho la stringa
cambia:	push {R0, LR}	@ Salvo subito R0 e LR per chiamare strlen(s)
	bl strlen
	mov R4, R0			@ Mi salvo il valore di ritorno in R4
	pop {R0, LR}		@ Recupero R0 e LR
	mov R5, #0			@ int sum = 0
	mov R6, #0 			@ Inizializzo l'indice i
	sub R4, R4, #1 		@ Decremento la lunghezza della stringa di 1 (devo fare i < ls-1)
for1:	cmp R6, R4		@ Inizio il primo confronto del primo for
	bge fine1			@ Se i è maggiore o uguale di ls ho finito di iterare
	mov R7, R6			@ Altrimenti inizializzo la j del secondo ciclo, eguagliandola a i
	add R7, R7, #1 		@ E incremento di 1: metto in j il valore i+1
for2:	cmp R7, R4		@ Qui faccio il confronto del secondo for (che dice j < ls, equivalente a j <= ls-1)
	bgt fine2			@ Se j è maggiore finisco il ciclo annidato
	push {R0-R6, LR}	@ Altrimenti salvo i registri usati per chiamare la funzione cambiaV
	mov R1, R6			@ Passandogli gli opportuni argomenti i e j come secondo e terzo parametro
	mov R2, R7
	bl cambiaV
	mov R8, R0			@ Il valore di ritorno lo salvo in R8
	pop {R0-R6, LR}		@ Recupero i valori dallo stack
	add R5, R5, R8 		@ sum+=cambiaV(s,i,j)
	add R7, R7, #1		@ Incremento j
	b for2				@ Rieseguo il for annidato
fine2:	add R6, R6, #1	@ Se il for annidato è finito incremento i e faccio un'altra iterazione del for principale
	b for1
fine1:	mov R0, R5		@ Se ho finito anche il for principale, posso ritornare sum
	mov PC, LR
	
