@ Semantica funzione che inizializza un array di n elementi e ritorna il numero di elementi
@ int riempi(int n){
@	for(int i=0;i<n;i++){
@		x[i] = 0;
@	}
@	return n;
@ }
@ chiamata di funzione:
@ riempi(3);
@ con x -> R2, i -> R0, n -> R1, 

@ dico dove sia definito il main
.text
.global main

@ definisco il main:

main:	@ DA CONTINUARE
