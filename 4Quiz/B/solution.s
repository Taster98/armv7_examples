.text
.global mystrstr
.type mystrstr %function
.type match %function

@Nella funzione match ho in R0 la base della stringa 'uno', in R1 la base della stringa 'due', in R2 ho l (lunghezza di parola)
match:	mov R3,#1 			@ int res=1;
	mov R4,#0 				@ int i=0;
for:	cmp R4,R2			@ Confronto i ed l
	bge fine				@ Se è maggiore o uguale ho finito di iterare
	ldrb R5, [R0,R4]		@ Mi carico il carattere i-esimo di uno in R5 e di due in R6
	ldrb R6, [R1,R4]
	cmp R5, R6				@ Confronto uno[i] e due[i]
	beq skip				@ Se sono uguali skippo
	mov R3, #0				@ Se sono qui significa che sono diversi quindi le stringhe non combaciano, esco:
	b fine					@ Salto direttamente alla fine del ciclo perché non ho trovato la sottostringa
skip:	add R4, R4, #1 		@ Qui incremento l'indice del for (i++)
	b for					@ E qui risalto al for
fine:	mov R0, R3			@ Se sono qui ho finito, e ritorno il valore di res (che è in R3)
	mov PC, LR

@ Nella funzione mystrstr ho in R0 la base di 'stringa', e in R1 la base di 'parola'
mystrstr: push {R0-R3,LR}		@ Mi salvo subito i registri prima di chiamare la strlen(stringa)
	bl strlen
	mov R4, R0 					@ In R4 salvo la lunghezza di 'stringa'
	pop {R0-R3, LR}				@ Recupero i vecchi valori dei registri e mi preparo a salvarli di nuovo
	push {R0-R3, LR}			@ perché sto per chiamare nuovamente la strlen(parola)
	mov R0, R1					@ Siccome devo chiamrla su 'parola', sposto la sua base in R0
	bl strlen
	mov R5, R0 					@ In R5 salvo la lunghezza di 'parola'
	pop {R0-R3, LR}				@ Recupero i valori dei registri originali
	mov R2, R4					@ Sposto in R2 la lunghezza di 'stringa'
	mov R3, R5					@ Sposto in R3 la lunghezza di 'parola'
	mov R4, #-1 				@ int trovata = -1
	mov R5, #0 					@ int i=0
	sub R6, R2, R3				@ Salvo in R6 la differenza di lunghezze (ls-lp)
	add R6, R6, #1				@ Incremento di 1 (per ottenere ls-lp+1)
for2:	cmp R5, R6				@ Confronto l'indice del for con questo valore trovato
	bge fine2					@ Se è maggiore o uguale ho finito di iterare, vado a fine
	push {R0-R6, LR}			@ Salvo i registri usati perché sto per chiamare match
	add R0, R0, R5				@ Devo passare come argomento la sottostringa originale a partire da i, quindi sommo i a R0
	mov R2, R3					@ Sposto la lunghezza di parola in R2 per passarlo come terzo argomento di match
	bl match					@ Chiamo match
	mov R7, R0 					@ In R7 ho il ritorno di match
	pop {R0-R6, LR}				@ Ripristino i registri precedenti
	cmp R7,#1					@ Confronto ciò che mi ha ritornato match con 1
	bne skip2					@ Se sono diversi skippo, non era una sottostringa
	mov R4, R5					@ Altrimenti devo ritornare l'indice, quindi lo metto in R4
	b fine2						@ Esco dal ciclo
skip2:	add R5, R5, #1			@ Se ho skippato, vado avanti con le iterazioni, quindi incremento i
	b for2						@ E risalto al ciclo
fine2:	mov R0, R4				@ Se sono qui allora posso ritornare ciò che ho trovato (-1 in caso di errore)
	mov PC, LR










