//
//  main.c
//  c-only-program
//


#include <stdio.h>
#include <string.h>
#include <time.h>
#include <stdlib.h>

#define MAX_SOL_TO_PRINT    50
#define START_WITH_2_ALWAYS 2
#define MAX_BASE            64

int _base_w4;  // not related to width but need to _w4 for future _wx
               //     (and avoid w2 version conflict)
int _width_w4; // not used yet for wx version

// int used_number_w4[10];

//int *used_number_w4; // if use dynamics; see below for both malloc, memset (which set only within _base_w4 not MAX_BASE) and free

int used_number_w4[MAX_BASE]; // static array, if we fix the maximum _base_w4
                              // not related to width but need to _w4 for future _wx (and avoid w2 version conflict)

int valid_w4(int wxyz) {
    int z   = wxyz % _base_w4;
    int wxy = wxyz / _base_w4;
    int y   = wxy  % _base_w4;
    int wx  = wxy  / _base_w4;
    int x   = wx   % _base_w4;
    int w   = wx   / _base_w4;
    return    wxyz >= _base_w4*_base_w4*_base_w4           // not  0xxx
           && wxyz < (_base_w4*_base_w4*_base_w4*_base_w4)  // not 1xxxx
           && !(w == x    ||                         // w, x, y, z all unique
                w == y    ||
                w == z    ||
                x == y    ||
                x == z    ||
                y == z    ||
                used_number_w4[w] ||                         // and not used
                used_number_w4[x] ||
                used_number_w4[y] ||
                used_number_w4[z] );
}

int use_w4(int wxyz) {
    int z   = wxyz % _base_w4;
    int wxy = wxyz / _base_w4;
    int y   = wxy  % _base_w4;
    int wx  = wxy  / _base_w4;
    int x   = wx   % _base_w4;
    int w   = wx   / _base_w4;
    return    valid_w4(wxyz)
           && (used_number_w4[w] = 1)
           && (used_number_w4[x] = 1)
           && (used_number_w4[y] = 1)
           && (used_number_w4[z] = 1);
}

void unuse_w4(int wxyz) {
    int z   = wxyz % _base_w4;
    int wxy = wxyz / _base_w4;
    int y   = wxy  % _base_w4;
    int wx  = wxy  / _base_w4;
    int x   = wx   % _base_w4;
    int w   = wx   / _base_w4;
    used_number_w4[w] = 0;
    used_number_w4[x] = 0;
    used_number_w4[y] = 0;
    used_number_w4[z] = 0;
}

void test_used_number_w4(int i)
{
    printf("\nused_number_w4[%d] is %d with _base_w4 %d \n", i, used_number_w4[i], _base_w4);
}

void reset_w4() {
    
    memset(used_number_w4, 0, (sizeof(int*) * _base_w4)); // sizeof(used_number_w4));
                                                 // memset only those affected; outside not count
                                                 // array size _base_w4d on _base_w4 not width
    used_number_w4[1] = 1;  //    1 is used whatever
                         //    test_used_number_w4(1);
                         //    test_used_number_w4(0);
                         //    test_used_number_w4(_base_w4 - 1);
}

// display formula from generative c

char *digit_list = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz+/";
void printInt_w4(int x){  // need _w4 if compile togethe later with _wx
    // quick hack, not work for x = 0
    if( x == 0 ) return;
    int t = x%_base_w4;
    printInt_w4(x/_base_w4);
    printf("%c", digit_list[t]);
}
void print_w4(int a, int b, int c, int d){ // need _w4 if compile togethe later with _wx
    int e = a - b + d; // a - b (= c) + d
    printInt_w4(a); printf("-"); printInt_w4(b); printf("="); printInt_w4(c); printf(", ");
    printInt_w4(c); printf("+"); printInt_w4(d); printf("="); printInt_w4(e); printf(" => "); // not line break
}
void printInt4_w4(int wxyz){ // need _w4 if compile togethe later with _wx
    // quick hack, not work for x = 0
    if( wxyz == 0 ) return;
    int z   = wxyz % _base_w4;
    int wxy = wxyz / _base_w4;
    int y   = wxy  % _base_w4;
    int wx  = wxy  / _base_w4;
    int x   = wx   % _base_w4;
    int w   = wx   / _base_w4;
    printf("%2d~%2d~%2d~%2d", w, x, y, z); // %*d then 2, w ...
}

void print2_w4(int a, int b, int c, int d){ // need _w4 if compile togethe later with _wx

    printInt4_w4(a); printf(" - "); printInt4_w4(b); printf(" = "); printInt4_w4(c); printf(", ");
    printInt4_w4(c); printf(" + "); printInt4_w4(d); printf(" (_base_w4 10) ="); // not line break
}

int main_w4(int base_in) { // need _w4 if compile togethe later with _wx
    
    if (base_in > MAX_BASE) {
        printf("\n_base_w4 input is %d and exceed maximum _base_w4 %d allowed \n", base_in, MAX_BASE);
        return 1;
    }
    
    _base_w4 = base_in;

    clock_t tick_l;
    
    int cnt_l = 0;
    int a_w4, b_w4, c_w4, d_w4;
    
    int _base_w411111 = (1 * ( _base_w4 * _base_w4 * _base_w4 * _base_w4
                          + _base_w4 * _base_w4 * _base_w4
                          + _base_w4 * _base_w4
                          + _base_w4
                          + 1));
    
    tick_l = clock();
    
    reset_w4();
    
    for (a_w4 = START_WITH_2_ALWAYS * _base_w4 * _base_w4 * _base_w4;
         a_w4 < (_base_w4 * _base_w4 * _base_w4 * _base_w4 );
         a_w4++)
               // a cannot be 0xxx, 1xxx and 1xxxx, start from 2 * _base_w4 ** (width - 1)
        if (use_w4(a_w4)) { //try to use a
        for (b_w4 = START_WITH_2_ALWAYS * _base_w4 * _base_w4 * _base_w4;
             b_w4 < a_w4;
             b_w4++) // a > b to avoid c < 0 and b go into a
                if (use_w4(b_w4)) {
                    c_w4 = a_w4 - b_w4;    // you do not need to loop over c and d
                    d_w4 = _base_w411111
                           - c_w4; //??? need a loop
                        // a - b = c + d = p = 11111 (_base_w4 at width 4)
                        // fixed a, b then c, d is fixed by logic
                    
                    if (use_w4(c_w4)) {
                        if (use_w4(d_w4)) {
                            if (cnt_l < MAX_SOL_TO_PRINT) {
                                printf("%*d: ", 2, cnt_l + 1);
                                print_w4(a_w4,b_w4,c_w4,d_w4);
                                print2_w4(a_w4,b_w4,c_w4,d_w4);
                                printInt_w4(_base_w411111);
                                printf(" (%d) \n",
                                       _base_w4);  //??? need a better print one
                            }
                            cnt_l++; // need that for those time you cannot print all
                            unuse_w4(d_w4);
                        }
                        unuse_w4(c_w4);
                    }
                unuse_w4(b_w4);
                }
        unuse_w4(a_w4); // if used(ab) unuse it
        }
    
    printf("\n_base_ is: %d\n", _base_w4);
    tick_l = clock()-tick_l;
    printf("time used: %f\n", ((double)tick_l)/CLOCKS_PER_SEC);
    // printf("MAX_SOL_TO_PRINT: %d\n\n", MAX_SOL_TO_PRINT);
    printf("number of solutions: %d\n\n", cnt_l);
    
    // free(used_number_w4); dynamic array only
    
    return 0;
}



