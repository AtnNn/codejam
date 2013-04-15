#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define min(a,b) ((a) < (b) ? (a) : (b))
#define max(a,b) ((a) > (b) ? (a) : (b))

int lim = 100003;

int read(){
  int d;
  scanf("%d", &d);
  return d;
}

int cache[700*700];

int main(){
  int T = read();
  int Case;
  for(Case = 1; Case <= T; Case++){

    memset(cache, 0, sizeof(cache));

    int N = read();
    printf("Case #%d: %d\n", Case, f(N));
  }    
}

int f(n){
  int i;
  int sum = 0;
  for (i = 1; i < n; i++){
    sum = (sum + k(n,i)) % lim;
  }

  fprintf(stderr, "f %d: %d\n", n, sum);

  return sum;
}

int level = 0;
int k(n, c){
  if(c == 1){
    int i;
    //for(i = 0; i < level; i++) fputs(" ", stderr);
    //fprintf(stderr, "k %d %d: one\n", n, c);
    return 1;
  }

  if(n <= c){
    //fprintf(stderr, "k %d %d: zero\n", n, c);
    return 0;
  }

  int *result = &cache[n * 600 + c];
  if(*result != 0){
    int i;
    //for(i = 0; i < level; i++) fputs(" ", stderr);
    //fprintf(stderr, "k %d %d: %d (C)\n", n, c, *result);
    return *result;
  }

  int maxi = max(1, 2*c - n);
  //fprintf(stderr, "maki: %d, c-1: %d\n", maxi, c-1);
  int mx = n - c - 1;

  int i;
  int sum = 0;
  for(i = maxi; i < c; i++){
    //fprintf(stderr, "i: %d\n", i);
    //level ++;
    sum = (sum + k(c,i) * choose(mx, c-i-1)) % lim;
    //level --;
  }

  *result = sum;

  //for(i = 0; i < level; i++) fputs(" ", stderr);
  //fprintf(stderr, "k %d %d: %d\n", n, c, sum);

  return sum;
}

int fact(x){
  int p = 1;
  int i;
  for(i = 1; i <= x; i++){
    p = (p * i) % lim;
  }
  return p;
}        

int choose(n, k){
  if(k > n)
    fprintf(stderr, "*********** %d > %d\n", k, n);
  return fact(n) / (fact(k) * fact(n-k));
}


