#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define MAX_BASE 36
#define MAX_WIDTH 7
#define N ((MAX_BASE-3)*(MAX_BASE-4))

int numSol;
int base, width, cnt;
int curr, e, MIN, V;
int used1[MAX_BASE], used2[MAX_BASE], tableLen[MAX_BASE];  // size of base
int vs[MAX_BASE-3]; 
int sp[MAX_WIDTH], EXP[MAX_WIDTH];        // size of width
int table[MAX_BASE][MAX_BASE];
int va[N], vb[N], br[N];

// table helpers
void reset(int* used){
  for(int i=0; i<base; i++) used[i] = 0;
  used[1] = 1;
}
int checkWrite(int* used, int a){
  // mutable check
  for(int i=width; i--; a/=base){
    int t = a%base;
    if( used[t] ) return 0;
    used[t] = 1;
  }
  return 1;
}

char *c = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
void printInt(int x){     
  // quick hack, not work for x = 0
  if( x == 0 ) return;
  int t = x%base;
  printInt(x/base);
  printf("%c", c[t]);
}
void print(int a, int b, int c, int d){
  int e = a-b+d;
  printInt(a);
  printf("-");
  printInt(b);
  printf("=");
  printInt(c);
  printf(", ");
  printInt(c);
  printf("+");
  printInt(d);
  printf("=");
  printInt(e);
  printf("\n");
}

void search(int i, int borrow, int a, int b){
  if( i == width ){
    if( a > b && b > MIN ){
      if( numSol ){
        print(a,b,curr,e-curr);
        numSol--;
      }
      cnt++;
    }
    return;
  }
  int di = sp[i] + borrow;
  if( di == base ) return;    // this implies that a0 = b0 = 0, so not a solution
  int *vec = table[di], len = tableLen[di];
  for(int j=0; j<len; j++){
    int t = vec[j], a0 = va[t], b0 = vb[t];
    if( used2[a0] || used2[b0] ) continue;
    used2[a0] = used2[b0] = 1;
    search(i+1, br[t], a+a0*EXP[i], b+b0*EXP[i]);
    used2[a0] = used2[b0] = 0;
  }
}

void solveAB(int c){
  int i,j,t;

  // possible digits in a and b
  for(i=0,j=0; i<base; i++) if( !used2[i] ) vs[j++] = i;

  // clear table
  for(i=0; i<base; i++) tableLen[i] = 0;

  // O( B*B )
  t=0;
  for(i=0; i<V; i++){
    for(j=i+1; j<V; j++){
      int v1 = vs[i], v2 = vs[j];
      int i1 = v2-v1, i2 = base+v1-v2;

      table[i1][tableLen[i1]++] = t;
      va[t] = v2; vb[t] = v1; br[t] = 0;
      t++;

      table[i2][tableLen[i2]++] = t;
      va[t] = v1; vb[t] = v2; br[t] = 1;
      t++;
    }
  }
  
  curr = c;
  for(i=0, t=curr; i<width; i++, t /= base ) sp[i] = t%base;
  search(0, 0, 0, 0);
  
  // due to symmetry of c and d
  curr = e - c;
  for(i=0, t=curr; i<width; i++, t /= base ) sp[i] = t%base;
  search(0, 0, 0, 0);
}

int generate(int w, int c){
  if( w == width ){
    int d = e - c;
    if( d < c ) return 1;    // due to symmetry of c and d
    reset(used2);
    if( checkWrite(used2, c) && checkWrite(used2, d) ) solveAB(c);
    return 0;
  }

  // left-most digit cannot start with zero and one is used
  int start = w == 0 ? 2 : 0;
  for(int i=start; i<base; i++){
    if( used1[i] ) continue;
    used1[i] = 1;
    if( generate(w+1, base*c+i) ) return 1;
    used1[i] = 0;
  }
  return 0;
}

int abcdefghppp(int b, int w){
  int i;

  base = b; width =w; cnt = 0; numSol = 50;

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

  reset(used1);
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

