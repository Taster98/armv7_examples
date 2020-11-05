@ Questa è la mia implementazione di una funzioen:
@ Devo esportare nei nomi di funzioni globali la funzione che dichiaro nel
@ segmento del codice per poterla chiamare al di fuori di questo file (come con la printf)
@ quindi per prima cosa esporto la funzione:

.text
.global IP

@ Ora posso implementarla, fornendo come etichetta il nome con cui l'ho esportata:

@ Per prima cosa salvo i registri superiori al 4 per non perderne i valori
IP: push {r4-r5}
    mov r3, #0

for:    ldr r4, [r0], #4
        ldr r5, [r1], #4

        @ utilizzo la funzione di multiply&add per fare somma di prodotti:
        mla r3, r4, r5, r3
        @ decremento di uno (il for è al contrario)
        sub r2, r2, #1
        cmp r2, #0
        bne for

        @ se non sono uguali a 0 continuo, altrimenti passo qui sotto:
        @ prelevo i miei registri
        pop {r4-r5}
        @ sposto il risultato in r0
        mov r0, r3
        @ restituisco il risultato
        mov pc, lr