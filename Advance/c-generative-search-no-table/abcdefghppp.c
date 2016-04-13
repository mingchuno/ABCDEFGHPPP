#include <stdio.h>
#include <time.h>

#define OUTPUT_SIZE 50
#define MAX_WIDTH 7

#define LS(n) ((long long) 1 << (n))  // left shift

int base, width, cnt;
int curr, e;
unsigned long long used1, used2;
int *sp, spc[MAX_WIDTH], spd[MAX_WIDTH], EXP[MAX_WIDTH];

// display formula
char *digit = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz+/";
void printInt(int x){     
  // quick hack, not work for x = 0
  if( x == 0 ) return;
  int t = x%base;
  printInt(x/base);
  printf("%c", digit[t]);
}
void print(int a, int b, int c, int d){
  printInt(a); printf("-"); printInt(b); printf("="); printInt(c); printf(", ");
  printInt(c); printf("+"); printInt(d); printf("="); printInt(e); printf("\n");
}

void search(int i, int di, int a, int b){
  int a0, b0, di_;
  unsigned long long mask;
  if( di == base ) return;    // can't prove this never happen
  if( i == width ){
    if( a > b && b > EXP[width-1] ) if( cnt++ < OUTPUT_SIZE ) print(a,b,curr,e-curr);
    return;
  }

  a0=di; b0=0; di_=sp[i+1];
  mask = LS(a0) + LS(b0);
  while( a0 < base ){
    if( (used2 & mask) == 0 ){
      used2 |= mask;
      search(i+1, di_, a+a0*EXP[i], b+b0*EXP[i]);
      used2 &= ~mask;
    }
    a0++; b0++; mask = mask << 1;
  }

  a0=0; b0=base-di; di_++; 
  mask = LS(a0) + LS(b0);
  while( b0 < base ){
    if( (used2 & mask) == 0 ){
      used2 |= mask;
      search(i+1, di_, a+a0*EXP[i], b+b0*EXP[i]);
      used2 &= ~mask;
    }
    a0++; b0++; mask = mask << 1;
  }
}

int generate(int w, int c){
  int i;

  if( w == width ){
    int d = e - c;
    if( d < c ) return 1;    // due to symmetry of c and d

    used2 = used1;
    for(i=0; i<width; i++, d /= base){
      unsigned long long j = LS(spd[i] = d % base);
      if( used2 & j ) return 0;
      used2 |= j;
    }

    curr = c; sp = spc;
    search(0, sp[0], 0, 0);
  
    // due to symmetry of c and d
    curr = e-c; sp = spd;
    search(0, sp[0], 0, 0);

    return 0;
  }

  c *= base;
  // left-most digit cannot start with zero and one is used
  int start = w == 0 ? 2 : 0;
  for(i=start; i<base; i++){
    long long t = LS(i);
    if( used1 & t ) continue;
    spc[width-w-1] = i;
    used1 |= t;
    if( generate(w+1, c+i) ) return 1;
    used1 &= ~t;
  }
  return 0;
}

int abcdefghppp(int b, int w){
  int i;

  base = b; width = w; cnt = 0;

  // EXP[i] = base^i
  EXP[0] = 1;
  for(i=1; i<width; i++) EXP[i] = base*EXP[i-1];

  // value of e
  e = 1;
  for(i=0; i<width; i++) e = base*e+1;

  used1 = 2;
  generate(0,0);

  return cnt;
}

int main(){
  clock_t t;
  int tc;
  scanf("%d", &tc);
  for(int i=0; i<tc; i++){
    int b,w, cnt;
    scanf("%d%d", &b, &w);
    printf("base=%d width=%d\n", b, w);
    printf("---------------------------------\n");
    t = clock();
    cnt = abcdefghppp(b,w);
    t = clock()-t;
    printf("time used: %f\n", ((double)t)/CLOCKS_PER_SEC);
    printf("number of solutions: %d\n\n", cnt);
  }

  return 0;
}

