@ semantica per il For:
@ for(int i=0;i<7;i++){
@	x[i] = i;
@ }
@ con x -> R2 Locazione di memoria (base) di indice i (bound) con i -> R0

@ definisco dove si trova il codice
.text
.global main

@ scrivo il main

main:	mov R0, #0 @ inizializzo la mia i a 0
for:	cmp R0, #7
	bge end
	@ ora voglio caricare in memoria, nella posizione x[i] il valore i:
	str R0, [R2, R0, LSL #2] @ shift a sinistra di 2 alla 2 (4) perché ragiono al byte:
	@ a questo punto incremento la i
	add R0, R0, #1
	b for
end:	mov R0, #3
	@ mostro che nella memoria, quarta posizione del vettore x c'è salvato il numero 3:
	ldr R1, [R2, R0, LSL #2]

@ termino il programma

	mov R7, #1
	svc 0
	
