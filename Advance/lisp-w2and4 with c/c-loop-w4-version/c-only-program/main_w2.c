//
//  main.c
//  c-only-program
//
//


#include <stdio.h>
#include <string.h>
#include <time.h>
#include <stdlib.h>

#define MAX_SOL_TO_PRINT    50
#define START_WITH_2_ALWAYS 2

/* w2 final result
 
 85 - 46 = 39, 39 + 72 = 111
 86 - 54 = 32, 32 + 79 = 111
 90 - 27 = 63, 63 + 48 = 111
 90 - 63 = 27, 27 + 84 = 111
 95 - 27 = 68, 68 + 43 = 111
 
 */

int _base_; // global var, set by main as parameter in
          // no width in this round

// instead of int used_number[10], change to dynamic array
// but can use another #DEFINE MAX_base_ 64 to use static array as used_number[MAX_base_];
// see _w4 version

int *used_number;

int valid_w2(int x) {
    int z = x % _base_;
    int y = x / _base_;
    return    x >= _base_         //  <--- this is implicit if-then-else c style
           && x < (_base_*_base_)
           && !(  z == y           //  <--- note the ! i.e. not
               || used_number[z]
               || used_number[y]);
    // x >= _base_                <-- cannot a/c/e/g be 0   i.e. not 0_base_
    // x < _base_ * _base_       <-- cannot a/c/e/g >  10  i.e. not 1_base_
    //                             <--        (i.e. a/c/e/g is 1 ... 9)
    // !(y == z ||   <-- the two digits have to be different
    //                   this need major re-architecture later
    //   vis[y] ||   <-- and not already in the used_number array
    //   vis[z])     <-- ...
}

int use(int x) {
    return valid_w2(x)
       && (used_number[x % _base_] = 1)
       && (used_number[x / _base_] = 1); //two digits used
    // implicit if valid
    //          update 2 pos
}

void unuse(int x) {
    used_number[x % _base_] = 0; // two digits unused
    used_number[x / _base_] = 0;
}

void test_used_number(int i) // my own test program (use dynamic array not obvious debug under xCode)
{
    printf("\nused_number[%d] is %d with _base_ %d \n", i, used_number[i], _base_);
}

void reset_w2() {
    
    memset(used_number, 0, (sizeof(int*) * _base_)); // sizeof(used_number));
    used_number[1] = 1;  //    1 is used always
                    //    test_used_number(1);
                    //    test_used_number(0);
                    //    test_used_number(_base_ - 1);
}




int main_w2(int base_in) {

    //    use the input number to set the global variable
    
    _base_ = base_in;
    
    // see http://stackoverflow.com/questions/6792235/declaring-global-variable-array-inside-a-function-in-c
    
    // http://forum.codecall.net/topic/51010-dynamic-arrays-using-malloc-and-realloc/
    
    used_number = (int *)malloc(sizeof(int*) * _base_); // seems need (int *); should not be under c99
    
    if (used_number ==NULL) {
        printf("Error allocating memory!\n"); //print an error message
        return 1; //return with failure
    }
    
//    used_number[0] = 90; <-- remember to set it back to 0 if used
//    used_number[_base_ - 1] = 99;
//    test_used_number(0);
//    test_used_number(_base_ - 1);
//    used_number[0] = 0;
//    used_number[_base_ - 1] = 0;
    
    clock_t tick_l;
    
    int cnt_l = 0;
    int ab, cd, ef, gh;
    
    tick_l = clock();
    reset_w2();
    
    for (ab = START_WITH_2_ALWAYS * _base_; ab < (_base_ * _base_); ab++)
             // a cannot be 0 and 1, start from 20
        if (use(ab)) { //try to use ab
            for (cd = START_WITH_2_ALWAYS * _base_; cd < ab; cd++)
                // ab > cd to avoid ef < 0 and cd run into ab
                if (use(cd)) {
                    ef = ab - cd;    // you do not need to loop over ef and gh
                    gh = (1 * (_base_ * _base_ + _base_ + 1)) - ef;
                                     // a - b = c + d = p = 111
                                     // fixed a and b then c and d is fixed by logic
                    
                    if (use(ef)) {
                        if (use(gh)) {
                            if (cnt_l < MAX_SOL_TO_PRINT) {
                                printf("%d: %d - %d = %d, %d + %d = %d\n", cnt_l + 1, ab, cd, ef, ef, gh, (1 * (_base_ * _base_ + _base_ + 1)) );
                            }
                            cnt_l++; // need that for those time you cannot print all
                            unuse(gh);
                        }
                        unuse(ef);
                    }
                    unuse(cd);
                }
            unuse(ab); // if used(ab) unuse it
        }
    
    tick_l = clock()-tick_l;
    
    printf("\n_base_ is: %d\n", _base_);
    
    printf("time used: %f\n", ((double)tick_l)/CLOCKS_PER_SEC);
    // printf("MAX_SOL_TO_PRINT: %d\n\n", MAX_SOL_TO_PRINT);
    printf("number of solutions: %d\n\n", cnt_l);
    
    free(used_number);
    
    return 0;
}



