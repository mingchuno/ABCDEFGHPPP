//
//  main.c
//  c-only-program
//
// not finished and not going to 

#include <stdio.h>
#include <string.h>
#include <time.h>
#include <stdlib.h>

#define MAX_SOL_TO_PRINT_wx 50
#define START_A_B_wx 2
#define MAXBASE 64

int base_wx;
int width_wx;

// int vis_wx[10];

//int *vis_wx; // if use dynamics; see below for both malloc, memset (which set only within base not maxbase) and free

// http://stackoverflow.com/questions/101439/the-most-efficient-way-to-implement-an-integer-based-power-function-powint-int no checking of neg no. or the more efficient integer power func

int ipow(int base, int exp)
{
    int result = 1;
    while (exp)
    {
        if (exp & 1)
            result *= base;
        exp >>= 1;
        base *= base;
    }
    
    return result;
}

int vis_wx[MAXBASE]; // static if we fix the maximum base

int valid_wx(int wxyz) {
    int z   = wxyz % base_wx;
    int wxy = wxyz / base_wx;
    int y   = wxy  % base_wx;
    int wx  = wxy  / base_wx;
    int x   = wx   % base_wx;
    int w   = wx   / base_wx;
    int bw  = ipow(base_wx, (width_wx - 1)); // 0xxx
    return    wxyz >=  bw   // not  0xxx
    && wxyz < (base_wx*bw)  // not 1xxxx
    && !(w == x    ||                         // w, x, y, z all unique
         w == y    ||
         w == z    ||
         x == y    ||
         x == z    ||
         y == z    ||
         vis_wx[w] ||                         // and not used
         vis_wx[x] ||
         vis_wx[y] ||
         vis_wx[z] );
    // x >= base_wx                <-- cannot: a/c/e/g cannot be 0
    // x < base_wx * base_wx       <-- cannot: a/c/e/g >  10 (i.e. a/c/e/g is 1 ... 9)
    // !(w == x || ...             <-- all combination of  digits have to be different
    //   vis[x] || ...             <-- and not already in
}

int use_wx(int wxyz) {
    int z   = wxyz % base_wx;
    int wxy = wxyz / base_wx;
    int y   = wxy  % base_wx;
    int wx  = wxy  / base_wx;
    int x   = wx   % base_wx;
    int w   = wx   / base_wx;
    return    valid_wx(wxyz)
    && (vis_wx[w] = 1)
    && (vis_wx[x] = 1)
    && (vis_wx[y] = 1)
    && (vis_wx[z] = 1); //seperate = =
    // implicit if valid
    //          update 2 pos
}

void unuse_wx(int wxyz) {
    int z   = wxyz % base_wx;
    int wxy = wxyz / base_wx;
    int y   = wxy  % base_wx;
    int wx  = wxy  / base_wx;
    int x   = wx   % base_wx;
    int w   = wx   / base_wx;
    vis_wx[w] = 0; //seperate = =
    vis_wx[x] = 0;
    vis_wx[y] = 0;
    vis_wx[z] = 0;
}

void test_vis_wx(int i)
{
    printf("\nvis_wx[%d] is %d with base_wx %d \n", i, vis_wx[i], base_wx);
}

void reset_wx() {
    
    memset(vis_wx, 0, (sizeof(int*) * base_wx)); // sizeof(vis_wx)); memset only those affected; outside not count
    //w=4 but the uniqueness require array size still based on base
    vis_wx[1] = 1;  // ?? v meant but 1 is used whatever the base
    //    test_vis_wx(1);
    //    test_vis_wx(0);
    //    test_vis_wx(base_wx - 1);
}

// display formula
char *digit_g_wx = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz+/";
void printInt_wx(int x){
    // quick hack, not work for x = 0
    if( x == 0 ) return;
    int t = x%base_wx;
    printInt_wx(x/base_wx);
    printf("%c", digit_g_wx[t]);
}
void print_wx(int a, int b, int c, int d){
    int e = a - b + d; // a - b (= c) + d
    printInt_wx(a); printf("-"); printInt_wx(b); printf("="); printInt_wx(c); printf(", ");
    printInt_wx(c); printf("+"); printInt_wx(d); printf("="); printInt_wx(e); printf(" => "); // not line break
}
void printInt2_wx(int wxyz){
    // quick hack, not work for x = 0
    if( wxyz == 0 ) return;
    int z   = wxyz % base_wx;
    int wxy = wxyz / base_wx;
    int y   = wxy  % base_wx;
    int wx  = wxy  / base_wx;
    int x   = wx   % base_wx;
    int w   = wx   / base_wx;
    printf("%2d~%2d~%2d~%2d", w, x, y, z); // %*d then 2, w ...
}

void print2_wx(int a, int b, int c, int d){
    
    printInt2_wx(a); printf(" - "); printInt2_wx(b); printf(" = "); printInt2_wx(c); printf(", ");
    printInt2_wx(c); printf(" + "); printInt2_wx(d); printf(" (base 10) ="); // not line break
}

int main_wx(int base_wx_in, int width_wx_in) {
    
    //    printf("\nbase_wx_in_wx is %d \n", base_wx_in_wx);
    
    if (base_wx_in > MAXBASE) {
        printf("\nbase input is %d and exceed maximum base %d allowed \n", base_wx_in, MAXBASE);
        return 1;
    }
    
    base_wx = base_wx_in;
    
    //    printf("\nbase_wx       is %d \n", base_wx);
    
    
    // see http://stackoverflow.com/questions/6792235/declaring-global-variable-array-inside-a-function-in-c
    
    // http://forum.codecall.net/topic/51010-dynamic-arrays-using-malloc-and-realloc/
    
    /* no need unless use dynamic array
     vis_wx = (int *)malloc(sizeof(int*) * base_wx);
     // seems need (int *); should not be under c99
     // side same different width ...
     if (vis_wx ==NULL) {
     printf("Error allocating memory!\n"); //print an error message
     return 1; //return with failure
     }
     */
    
    /*
     vis_wx[0] = 90;
     vis_wx[base_wx - 1] = 99;
     test_vis_wx(0);
     test_vis_wx(base_wx - 1);
     vis_wx[0] = 0;
     vis_wx[base_wx - 1] = 0;
     test_vis_wx(0);
     test_vis_wx(base_wx - 1);
     */
    clock_t tick_l;
    int cnt_l = 0;
    
    int a_wx, b_wx, c_wx, d_wx;
    
    int base11111 = (1 * ( base_wx * base_wx * base_wx * base_wx
                          + base_wx * base_wx * base_wx
                          + base_wx * base_wx
                          + base_wx
                          + 1));
    
    tick_l = clock();
    reset_wx();
    for (a_wx = START_A_B_wx * base_wx * base_wx * base_wx;
         a_wx < (base_wx * base_wx * base_wx * base_wx );
         a_wx++)
        // a cannot be 0xxx, 1xxx and 1xxxx, start from 2 * base ** (width - 1)
        if (use_wx(a_wx)) { //try to use a
            for (b_wx = START_A_B_wx * base_wx * base_wx * base_wx;
                 b_wx < a_wx;
                 b_wx++) // a > b to avoid c < 0 and b go into a
                if (use_wx(b_wx)) {
                    c_wx = a_wx - b_wx;    // you do not need to loop over c and d
                    d_wx = base11111
                    - c_wx; //??? need a loop
                    // a - b = c + d = p = 11111 (base at width 4)
                    // fixed a, b then c, d is fixed by logic
                    
                    if (use_wx(c_wx)) {
                        if (use_wx(d_wx)) {
                            if (cnt_l < MAX_SOL_TO_PRINT_wx) {
                                printf("%*d: ", 2, cnt_l + 1);
                                print_wx(a_wx,b_wx,c_wx,d_wx);
                                print2_wx(a_wx,b_wx,c_wx,d_wx);
                                printInt_wx(base11111);
                                printf(" (%d) \n",
                                       base_wx);  //??? need a better print one
                            }
                            cnt_l++; // need that for those time you cannot print all
                            unuse_wx(d_wx);
                        }
                        unuse_wx(c_wx);
                    }
                    unuse_wx(b_wx);
                }
            unuse_wx(a_wx); // if used(ab) unuse it
        }
    
    tick_l = clock()-tick_l;
    printf("time used: %f\n", ((double)tick_l)/CLOCKS_PER_SEC);
    // printf("MAX_SOL_TO_PRINT: %d\n\n", MAX_SOL_TO_PRINT_wx);
    printf("number of solutions: %d\n\n", cnt_l);
    
    // free(vis_wx); dynamic array only
    
    return 0;
}



