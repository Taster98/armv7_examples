@ Trasformare una stringa da minuscola a tutti maiuscoli:
@ for(int i=0;i<strlen(s);i++)
@	if(lower(s[i]))
@		s[i] = toUpper(s[i]);
@ In ASM è un po' differente:

@ Definisco la stringa da passare alla printf e una stringa da "maiuscolizzare":
.data

outp: .string "La stringa da rendere maiuscola è: '%s'\n"
str: .string "hello world!"

@ definisco dove si trova il main
.text
.global main

@ definisco il main

@ la prima cosa da fare è stampare la stringa minuscola, usando la printf:

main:	ldr r0, =outp
	ldr r1, =str
	bl printf
	
	@ devo rimettere in r1 la mia stringa perché il registro viene svuotato:
	ldr r1, =str
	@ inizio il mio ciclo, caricando un solo carattere:
for:	ldrb r2, [r1]
	cmp r2, #0 @ verifico che non sia il carattere di terminazione
	beq end
	cmp r2, #0x61
	blt skip @ se è già maiuscola o un simbolo allora vado al carattere successivo
	cmp r2, #0x7a
	bgt skip
	@ se sono qui io devo sottrarre 0x20 e sostituirlo nel r1, poi andare avanti
	sub r2, r2, #0x20
	strb r2, [r1]
skip:	add r1,r1,#1
	b for
	@ se finisco voglio stampare nuovamente la stringa:
end:	ldr r0, =outp
	ldr r1, =str
	bl printf

	mov r7, #1
	svc 0


