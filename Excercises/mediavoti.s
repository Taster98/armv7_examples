@ Media dei voti
@ int res=0;
@ int n=0;
@ int i=0;
@ while(voti[i] != -1){
@	res += voti[i];
@	n++;
@	i++;
@ }
@ res = res/n;
@ printf("La media è: %d\n",res);
@ In asm è un po' diverso:
@ VERSIONE CORRETTA: I registri dal 4 al 6 vanno salvati perché non permangono al ritorno della funzione main.
@ va salvato anche il lr perché dopo la chiamata della printf questo rimarrebbe sennò cambiato, ed è male.

.data
voti:	.word 30, 28, 27, 24, 28, 18, -1
outp:	.string "La media è: %d\n"
res:	.word 0
.text
.global main

main:	push {r4-r6, lr}
	@ il risultato lo metto in r0, il numero di voti in r1, il voto corrente in r2, l'indice in r3
	mov r0, #0
	mov r1, #0
	mov r3, #0
	mov r4, #0
	mov r5, #0
	ldr r2, =voti
	ldr r2, [r2]
	ldr r6, =res
for:	cmp r2, #-1
	beq end
	add r0, r0, r2
	add r1, r1, #1
	add r5, r5, #4
	ldr r2, =voti
	add r2, r2, r5
	ldr r2, [r2]
	b for
end:	mov r3, r0
	mov r2, #0
div:	cmp r3, #0
	ble endtwo
	sub r3, r3, r1
	add r2, r2, #1
	str r2, [r6]
	b div
endtwo:	ldr r0, =outp
	ldr r1, [r6]
	bl printf
	pop {r4-r6, lr}
	mov r0, #0
	mov pc, lr
