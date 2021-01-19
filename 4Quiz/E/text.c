int quanto(char c) {
  int ret = 0;
  int v = c - '0';     // codice 0 = 0x30
  if(v >= 0 && v <= 9) {
    ret = v;
  }
  return(ret);
}

int somma(char * s) {

  int sum = 0;
  int i = 0;
  int n = strlen(s);
  while(i < n) {
    sum += quanto(s[i]);
    i++;
  }
  return(sum);
}