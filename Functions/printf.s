@ Semplice esempio di uso di una printf:
@ int x = 7;
@ printf("Il numero da stampare è: %d\n", x); con x -> R0, e "Il numero da stampare è: %d\n" -> R1

@ Mi salvo la stringa da passare come primo argomento alla printf:

.data
stringa: .string "Il numero da stampare è: %d\n"

@ scrivo dove sta il main

.text
.global main

@ scrivo il main

main:	mov R2, #7 @ numero da stampare
	ldr R0, =stringa @ carico in R1 la stringa salvata come "stringa"
	mov R1, R2	@ assegno a R1 che indica il secondo parametro della printf il numero da stampare (il mio placeholder)
	bl printf	@ chiamo la funzione printf, appartenente alla gnu library di C.
	
	@ termino il programma
	mov r7, #1
	svc 0

