@ semantica per il While:
@ while(x <= 7){
@	x = x + 2;
@ }
@ con x -> R0

@ definisco dove sta il mio codice
.text
.global main

@ scrivo il main

main:	mov R0, #0
while:	cmp R0, #7	@ fino a che R0 è minore o uguale a 7 gli aggiungo 2
	bgt end
	add R0, R0, #2
	b while
end:	mov R0, R0	@ esco dal ciclo

	mov R7, #1
	svc 0

