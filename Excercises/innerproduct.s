@ Prodotto vettoriale: vettore * vettore = scalare
@ res=0;
@ for(int i=0;i<n;i++){
@	res += a[i] * b[i];
@ printf("Il prodotto è uguale a: %d\n",res);
@ In asm è un po' diverso:
@ VERSIONE CORRETTA: I registri dal 4 al 6 vanno salvati perché non permangono al ritorno della funzione main.
@ va salvato anche il lr perché dopo la chiamata della printf questo rimarrebbe sennò cambiato, ed è male.
.data
@ definisco la stringa da passarre alla printf

outp: .string "Il prodotto è uguale a: %d\n"
@ definisco i due vettori e la dimensione:

first:	.word 1,2,3,4
second:	.word 5,6,7,8
dim:	.word 4
res:	.word 0
@ definisco dove si trova il main

.text
.global main

@ definisco il main
@ in r3 metto la dimensione, in r2 metto il risultato, in r1 metto il secondo vettore,
@ in r0 il primo vettore
main:	push {r4-r6,lr}
	ldr r3, =dim
	ldr r3, [r3]
	ldr r0, =first
	ldr r1, =second
	mov r2, #0
	mov r5, #0
	ldr r6, =res
for:	cmp r3, #0
	beq end
	@ ne prendo i valori
	ldr r0, [r0]
	ldr r1, [r1]
	mov r4, #0
	mul r4, r0, r1
	add r2, r2, r4
	@ mi riprendo gli indirizzi e vado al prossimo
	ldr r0, =first
	ldr r1, =second
	add r5, r5, #4
	add r0, r0, r5
	add r1, r1, r5
	
	sub r3, r3, #1
	str r2, [r6]
	b for
	
end:	ldr r0, =outp
	ldr r1, [r6]
	bl printf
	@ ora che ho chiamato la printf devo ripescare i miei registri e il lr
	pop {r4-r6, lr}
	mov r0, #0
	mov pc, lr
