//
//  main.c
//  c-only-program
//
//  Created by Dennis Ng on 9/4/2016.
//  Copyright © 2016 kwccoin. All rights reserved.
//

// old main_w2_old.c
 
#include <stdio.h>

/*
int main(int argc, const char * argv[]) {
    // insert code here...
    printf("Hello, World!\n");
    return 0;
}
*/

// #include <stdio.h>
#include <string.h>

#include <time.h>

#define MAX_SOL_TO_PRINT_w2_old 5
#define START_AB_w2_old 20 // 85 // should be 20 test 85 86 90 90 95
#define START_CD_w2_old 20 // 27 // should be 20 test 46 54 27 63 27

/*
 
 85 - 46 = 39, 39 + 72 = 111
 86 - 54 = 32, 32 + 79 = 111
 90 - 27 = 63, 63 + 48 = 111
 90 - 63 = 27, 27 + 84 = 111
 95 - 27 = 68, 68 + 43 = 111
 
 */


int vis_w2_old[10];

int valid_w2_old(int x) {
    int y = x % 10;
    int z = x / 10;
    return x >= 10 && x < 100 && !(y == z || vis_w2_old[y] || vis_w2_old[z]);
        // x >= 10       <-- cannot a/c/e/g be 0
        // x < 100       <-- cannot a/c/e/g >  10 (i.e. a/c/e/g is 1 ... 9)
        // !(y == z ||   <-- the two digits have to be different
        //   vis[y] ||   <-- and not already in
        //   vis[z])     <-- ...
}

int use_w2_old(int x) {
    return valid_w2_old(x) && (vis_w2_old[x % 10] = vis_w2_old[x / 10] = 1);
           // implicit if valid
           //          update 2 pos
}

void unuse_w2_old(int x) {
    vis_w2_old[x % 10] = vis_w2_old[x / 10] = 0;
}

void reset_w2_old() {
    memset(vis_w2_old, 0, sizeof(vis_w2_old));
    vis_w2_old[1] = 1;  // ?? v meant but 1 is used
}

int main_w2_old() {
    
    clock_t tick_l;
    int cnt_l = 0;
    
    int ab, cd, ef, gh;
    
    tick_l = clock();
    reset_w2_old();
    for (ab = START_AB_w2_old; ab < 100; ab++) // a cannot be 0 and 1, start from 20
        if (use_w2_old(ab)) { //try to use ab
        for (cd = START_CD_w2_old; cd < ab; cd++) // ab > cd to avoid ef < 0 and cd go into ab
                if (use_w2_old(cd)) {
                    ef = ab - cd;    // you do not need to loop over ef and gh
                    gh = 111 - ef;   // a - b = c + d = p = 111
                                     // fixed a, b then c, d is fixed by logic
                    
                    if (use_w2_old(ef)) {
                        if (use_w2_old(gh)) {
                            if (cnt_l < MAX_SOL_TO_PRINT_w2_old) {
                                printf("%d - %d = %d, %d + %d = 111\n", ab, cd, ef, ef, gh);
                                cnt_l++; // need that for those time you cannot print all
                            }
                            unuse_w2_old(gh);
                        }
                        unuse_w2_old(ef);
                    }
                unuse_w2_old(cd);
                }
        unuse_w2_old(ab); // if used(ab) unuse it
        }
    
    tick_l = clock()-tick_l;
    printf("time used: %f\n", ((double)tick_l)/CLOCKS_PER_SEC);
    // printf("MAX_SOL_TO_PRINT: %d\n\n", MAX_SOL_TO_PRINT_w2_old);
    printf("number of solutions: %d\n\n", cnt_l);
    
    return 0;
}



