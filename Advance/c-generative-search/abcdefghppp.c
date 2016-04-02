#include <stdio.h>
#include <time.h>

#define OUTPUT_SIZE 50
#define MAX_BASE 64
#define MAX_WIDTH 7
#define N (MAX_BASE)      // exact: base - 2*width -1
#define N2 (N*N)          // exact: (base-2*with-1)*(base-2*with-2)

#define LS(N) ((long long) 1 << (N))  // left shift

int base, width, cnt;
int curr, e, MIN, V;
long long used1, used2;
int sp[MAX_WIDTH], EXP[MAX_WIDTH];
int vs[N];
int table[MAX_BASE][N], tableLen[MAX_BASE];
int va[N2], vb[N2];

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
  int e = a-b+d;
  printInt(a); printf("-"); printInt(b); printf("="); printInt(c); printf(", ");
  printInt(c); printf("+"); printInt(d); printf("="); printInt(e); printf("\n");
}

void search(int i, int di, int a, int b){
  if( di == base ) return;    // don't know why seem never happen
  if( i == width ){
    if( a > b && b > MIN ) if( cnt++ < OUTPUT_SIZE ) print(a,b,curr,e-curr);
    return;
  }
  int *ts = table[di], len = tableLen[di], di_ = sp[i+1];
  for(int j=0; j<len; j++){
    int t = ts[j], a0 = va[t], b0 = vb[t];
    long long  mask = LS(a0) + LS(b0);
    if( used2 & mask ) continue;
    used2 |= mask;
    search(i+1, di_ + (a0<b0), a+a0*EXP[i], b+b0*EXP[i]);
    used2 &= ~mask;
  }
}

void solveAB(int c){
  int i,j,t;

  // possible digits in a and b
  for(i=0,j=0; i<base; i++) if( ~used2 & LS(i) ) vs[j++] = i;

  // clear table
  for(i=0; i<base; i++) tableLen[i] = 0;

  // O( B*B )
  t=0;
  for(i=0; i<V; i++){
    for(j=i+1; j<V; j++){
      int v1 = vs[i], v2 = vs[j];
      int i1 = v2-v1, i2 = base+v1-v2;

      table[i1][tableLen[i1]++] = t;
      va[t] = v2; vb[t] = v1; t++;
      table[i2][tableLen[i2]++] = t;
      va[t] = v1; vb[t] = v2; t++;
    }
  }
  
  curr = c;
  for(i=0, t=curr; i<width; i++, t /= base ) sp[i] = t%base;
  search(0, sp[0], 0, 0);
  
  // due to symmetry of c and d
  curr = e - c;
  for(i=0, t=curr; i<width; i++, t /= base ) sp[i] = t%base;
  search(0, sp[0], 0, 0);
}

int generate(int w, int c){
  int i;

  if( w == width ){
    int d = e - c;
    if( d < c ) return 1;    // due to symmetry of c and d

    used2 = used1;
    for(i=width; i--; d/=base ){
      long long j = LS(d % base);
      if( used2 & j ) return 0;
      used2 |= j;
    }

    solveAB(c);
    return 0;
  }

  c *= base;
  // left-most digit cannot start with zero and one is used
  int start = w == 0 ? 2 : 0;
  for(i=start; i<base; i++){
    long long t = LS(i);
    if( used1 & t ) continue;
    used1 |= t;
    if( generate(w+1, c+i) ) return 1;
    used1 &= ~t;
  }
  return 0;
}

int abcdefghppp(int b, int w){
  int i;

  base = b; width = w; cnt = 0;

  // for storing candidate of digits of a and b
  V = base-2*width-1;

  // EXP[i] = base^i
  EXP[0] = 1;
  for(i=1; i<width; i++) EXP[i] = base*EXP[i-1];

  // value of e
  e = 1;
  for(i=0; i<width; i++) e = base*e+1;

  // just to make sure b has at least width-digits
  MIN = 1;
  for(i=1; i<width; i++) MIN = MIN*base;

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

