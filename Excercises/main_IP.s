@ Questo è il main che chiamerà la mia funzione globale che calcola l'innerproduct.

@ come dati avrà i vettori e la loro dimensione:

.data
x:  .word 1,2,3,4
y:  .word 5,6,7,8
n:  .word 4

@ mi costruisco anche una stringa per la printf
outp:   .string "Il prodotto vettoriale è: %d\n"

@ scrivo il main

.text
.global main

main:   ldr r0, =x
        ldr r1, =y
        ldr r2, =n
        ldr r2, [r2]
        @ salvo il link register perché chiamerò un'altra funzione
        push {lr}
        bl IP
        @ dopo aver chiamato la funzione voglio andare alla fine del mio main
        @ qui voglio stampare il risultato che sposto in r1 perché il primo parametro di printf è la stringa:
end:    mov r1, r0
        ldr r0, =outp
        bl printf
        mov r0, #0
        pop {pc}